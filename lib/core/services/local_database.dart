import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'local_database.g.dart';

// ─── Tables ───

class LocalGroups extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get adminId => text()();
  TextColumn get description => text()();
  RealColumn get contributionAmount => real()();
  TextColumn get contributionFrequency => text()();
  TextColumn get status => text()();
  RealColumn get totalBalance => real().withDefault(const Constant(0))();
  RealColumn get totalContributed => real().withDefault(const Constant(0))();
  RealColumn get totalLoaned => real().withDefault(const Constant(0))();
  TextColumn get memberIds => text()(); // JSON encoded
  TextColumn get payoutOrder => text()(); // JSON encoded
  IntColumn get currentPayoutIndex => integer().withDefault(const Constant(0))();
  TextColumn get inviteCode => text().nullable()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalContributions extends Table {
  TextColumn get id => text()();
  TextColumn get groupId => text()();
  TextColumn get memberId => text()();
  TextColumn get memberName => text()();
  RealColumn get amount => real()();
  IntColumn get contributionDate => integer()();
  TextColumn get status => text()();
  TextColumn get notes => text().nullable()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalLoans extends Table {
  TextColumn get id => text()();
  TextColumn get groupId => text()();
  TextColumn get borrowerId => text()();
  TextColumn get borrowerName => text()();
  RealColumn get amount => real()();
  RealColumn get interestRate => real()();
  IntColumn get durationMonths => integer()();
  TextColumn get status => text()();
  RealColumn get amountRepaid => real().withDefault(const Constant(0))();
  TextColumn get purpose => text().nullable()();
  IntColumn get requestedAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class LocalFines extends Table {
  TextColumn get id => text()();
  TextColumn get groupId => text()();
  TextColumn get memberId => text()();
  TextColumn get memberName => text()();
  RealColumn get amount => real()();
  TextColumn get reason => text()();
  TextColumn get status => text()();
  IntColumn get issuedAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class PendingSync extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get collection => text()();
  TextColumn get documentId => text()();
  TextColumn get operation => text()(); // 'create' | 'update' | 'delete'
  TextColumn get data => text()(); // JSON encoded
  IntColumn get createdAt => integer()();
}

// ─── Database ───

@DriftDatabase(
  tables: [LocalGroups, LocalContributions, LocalLoans, LocalFines, PendingSync],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // ─── Groups ───
  Future<void> upsertGroup(LocalGroupsCompanion group) =>
      into(localGroups).insertOnConflictUpdate(group);

  Future<List<LocalGroup>> getGroups() => select(localGroups).get();

  Stream<List<LocalGroup>> watchGroups() => select(localGroups).watch();

  // ─── Contributions ───
  Future<void> upsertContribution(LocalContributionsCompanion c) =>
      into(localContributions).insertOnConflictUpdate(c);

  Future<List<LocalContribution>> getContributionsByGroup(String groupId) =>
      (select(localContributions)
            ..where((c) => c.groupId.equals(groupId))
            ..orderBy([(c) => OrderingTerm.desc(c.contributionDate)]))
          .get();

  // ─── Loans ───
  Future<void> upsertLoan(LocalLoansCompanion loan) =>
      into(localLoans).insertOnConflictUpdate(loan);

  Future<List<LocalLoan>> getLoansByGroup(String groupId) =>
      (select(localLoans)
            ..where((l) => l.groupId.equals(groupId))
            ..orderBy([(l) => OrderingTerm.desc(l.requestedAt)]))
          .get();

  // ─── Pending Sync ───
  Future<int> addPendingSync(PendingSyncCompanion entry) =>
      into(pendingSync).insert(entry);

  Future<List<PendingSyncData>> getPendingSync() =>
      select(pendingSync).get();

  Future<void> removePendingSync(int id) =>
      (delete(pendingSync)..where((s) => s.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'ikimina_offline.db'));
    return NativeDatabase.createInBackground(file);
  });
}
