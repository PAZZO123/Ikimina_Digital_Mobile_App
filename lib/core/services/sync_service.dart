import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'local_database.dart';
import 'connectivity_service.dart';

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(ref.read(localDbProvider));
});

final localDbProvider = Provider<LocalDatabase>((ref) => LocalDatabase());

class SyncService {
  final LocalDatabase _db;
  final _firestore = FirebaseFirestore.instance;
  final _logger = Logger();

  SyncService(this._db);

  /// Call this whenever the app comes back online.
  Future<void> syncPending() async {
    if (!ConnectivityService.isOnline) return;

    final pending = await _db.getPendingSync();
    if (pending.isEmpty) {
      _logger.d('✅ No pending sync operations');
      return;
    }

    _logger.i('🔄 Syncing ${pending.length} pending operations...');

    for (final item in pending) {
      try {
        final data = jsonDecode(item.data) as Map<String, dynamic>;
        final ref = _firestore.collection(item.collection).doc(item.documentId);

        switch (item.operation) {
          case 'create':
            await ref.set(data, SetOptions(merge: true));
            break;
          case 'update':
            await ref.update(data);
            break;
          case 'delete':
            await ref.delete();
            break;
        }

        await _db.removePendingSync(item.id);
        _logger.d('✅ Synced: ${item.collection}/${item.documentId}');
      } catch (e) {
        _logger.e('❌ Sync failed for ${item.collection}/${item.documentId}: $e');
        // Leave in pending queue to retry later
      }
    }
  }

  /// Queue an operation for when we're back online.
  Future<void> queueOperation({
    required String collection,
    required String documentId,
    required String operation,
    required Map<String, dynamic> data,
  }) async {
    await _db.addPendingSync(PendingSyncCompanion.insert(
      collection: collection,
      documentId: documentId,
      operation: operation,
      data: jsonEncode(data),
      createdAt: DateTime.now().millisecondsSinceEpoch,
    ));
    _logger.d('📦 Queued offline operation: $operation on $collection/$documentId');
  }
}
