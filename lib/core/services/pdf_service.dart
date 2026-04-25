import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../shared/models/app_models.dart';

class PdfReportService {
  static final _currencyFormat = NumberFormat('#,###', 'en_US');
  static final _dateFormat = DateFormat('dd MMM yyyy');

  static Future<File> generateGroupReport({
    required GroupModel group,
    required List<UserModel> members,
    required List<ContributionModel> contributions,
    required List<LoanModel> loans,
    required List<PayoutModel> payouts,
    required List<FineModel> fines,
  }) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.notoSansRegular();
    final boldFont = await PdfGoogleFonts.notoSansBold();

    final primaryColor = PdfColor.fromHex('#00A86B');
    final navyColor = PdfColor.fromHex('#1A3C5E');
    final lightGrey = PdfColor.fromHex('#F8FAFB');

    final totalContributed = contributions.fold(0.0, (s, c) => s + c.amount);
    final totalLoaned = loans
        .where((l) => l.status == 'approved' || l.status == 'completed')
        .fold(0.0, (s, l) => s + l.amount);
    final totalFines = fines.fold(0.0, (s, f) => s + f.amount);
    final totalPayouts = payouts
        .where((p) => p.status == 'completed')
        .fold(0.0, (s, p) => s + p.amount);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        header: (context) => _buildHeader(group, font, boldFont, primaryColor, navyColor),
        footer: (context) => _buildFooter(context, font),
        build: (context) => [
          pw.SizedBox(height: 24),

          // Summary Cards
          _buildSectionTitle('Financial Summary', boldFont, primaryColor),
          pw.SizedBox(height: 12),
          pw.Row(children: [
            _summaryCard('Total Contributed', 'RWF ${_fmt(totalContributed)}',
                primaryColor, font, boldFont),
            pw.SizedBox(width: 12),
            _summaryCard('Total Loaned', 'RWF ${_fmt(totalLoaned)}',
                navyColor, font, boldFont),
            pw.SizedBox(width: 12),
            _summaryCard('Current Balance', 'RWF ${_fmt(group.totalBalance)}',
                PdfColor.fromHex('#F5A623'), font, boldFont),
          ]),
          pw.SizedBox(height: 8),
          pw.Row(children: [
            _summaryCard('Total Payouts', 'RWF ${_fmt(totalPayouts)}',
                PdfColor.fromHex('#29B6F6'), font, boldFont),
            pw.SizedBox(width: 12),
            _summaryCard('Total Fines', 'RWF ${_fmt(totalFines)}',
                PdfColor.fromHex('#EF5350'), font, boldFont),
            pw.SizedBox(width: 12),
            _summaryCard('Members', '${members.length}',
                PdfColor.fromHex('#7B1FA2'), font, boldFont),
          ]),
          pw.SizedBox(height: 24),

          // Members Table
          _buildSectionTitle('Members', boldFont, primaryColor),
          pw.SizedBox(height: 8),
          _buildMembersTable(members, group, contributions, font, boldFont, lightGrey),
          pw.SizedBox(height: 24),

          // Contributions Table
          if (contributions.isNotEmpty) ...[
            _buildSectionTitle('Recent Contributions', boldFont, primaryColor),
            pw.SizedBox(height: 8),
            _buildContributionsTable(contributions.take(20).toList(), font, boldFont, lightGrey),
            pw.SizedBox(height: 24),
          ],

          // Loans Table
          if (loans.isNotEmpty) ...[
            _buildSectionTitle('Loans', boldFont, primaryColor),
            pw.SizedBox(height: 8),
            _buildLoansTable(loans, font, boldFont, lightGrey),
            pw.SizedBox(height: 24),
          ],

          // Payouts Timeline
          if (payouts.isNotEmpty) ...[
            _buildSectionTitle('Payout History', boldFont, primaryColor),
            pw.SizedBox(height: 8),
            _buildPayoutsTable(payouts, font, boldFont, lightGrey),
          ],
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final fileName =
        'ikimina_${group.name.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  static pw.Widget _buildHeader(GroupModel group, pw.Font font, pw.Font bold,
      PdfColor primary, PdfColor navy) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(bottom: 16),
      decoration: pw.BoxDecoration(
        border: pw.Border(bottom: pw.BorderSide(color: primary, width: 2)),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text('IKIMINA DIGITAL',
                style: pw.TextStyle(
                    font: bold, fontSize: 20, color: primary)),
            pw.SizedBox(height: 4),
            pw.Text('Financial Report',
                style: pw.TextStyle(font: font, fontSize: 12, color: navy)),
          ]),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.end, children: [
            pw.Text(group.name,
                style: pw.TextStyle(font: bold, fontSize: 14, color: navy)),
            pw.SizedBox(height: 4),
            pw.Text(
                'Generated: ${_dateFormat.format(DateTime.now())}',
                style: pw.TextStyle(font: font, fontSize: 10,
                    color: PdfColor.fromHex('#526070'))),
          ]),
        ],
      ),
    );
  }

  static pw.Widget _buildFooter(pw.Context context, pw.Font font) {
    return pw.Container(
      padding: const pw.EdgeInsets.only(top: 8),
      decoration: pw.BoxDecoration(
        border: pw.Border(top: pw.BorderSide(color: PdfColor.fromHex('#E0E8EE'))),
      ),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Ikimina Digital — Confidential',
              style: pw.TextStyle(font: font, fontSize: 9,
                  color: PdfColor.fromHex('#9EB0BE'))),
          pw.Text('Page ${context.pageNumber} of ${context.pagesCount}',
              style: pw.TextStyle(font: font, fontSize: 9,
                  color: PdfColor.fromHex('#9EB0BE'))),
        ],
      ),
    );
  }

  static pw.Widget _buildSectionTitle(
      String title, pw.Font bold, PdfColor color) {
    return pw.Text(title,
        style: pw.TextStyle(font: bold, fontSize: 14, color: color));
  }

  static pw.Widget _summaryCard(String label, String value, PdfColor color,
      pw.Font font, pw.Font bold) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(12),
        decoration: pw.BoxDecoration(
          color: color,
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(label,
                style: pw.TextStyle(
                    font: font, fontSize: 9, color: PdfColors.white)),
            pw.SizedBox(height: 4),
            pw.Text(value,
                style: pw.TextStyle(
                    font: bold, fontSize: 13, color: PdfColors.white)),
          ],
        ),
      ),
    );
  }

  static pw.Widget _buildMembersTable(
    List<UserModel> members,
    GroupModel group,
    List<ContributionModel> contributions,
    pw.Font font,
    pw.Font bold,
    PdfColor lightGrey,
  ) {
    return pw.TableHelper.fromTextArray(
      headers: ['#', 'Name', 'Phone', 'Contributions', 'Total Paid', 'Payout Position'],
      headerStyle: pw.TextStyle(font: bold, fontSize: 9, color: PdfColors.white),
      headerDecoration: pw.BoxDecoration(color: PdfColor.fromHex('#1A3C5E')),
      cellStyle: pw.TextStyle(font: font, fontSize: 9),
      rowDecoration: pw.BoxDecoration(color: lightGrey),
      data: members.asMap().entries.map((e) {
        final idx = e.key;
        final m = e.value;
        final memberContribs = contributions.where((c) => c.memberId == m.id);
        final totalPaid = memberContribs.fold(0.0, (s, c) => s + c.amount);
        final payoutPos = group.payoutOrder.indexOf(m.id) + 1;
        return [
          '${idx + 1}',
          m.fullName,
          m.phone,
          '${memberContribs.length}',
          'RWF ${_fmt(totalPaid)}',
          payoutPos > 0 ? '#$payoutPos' : '-',
        ];
      }).toList(),
    );
  }

  static pw.Widget _buildContributionsTable(
    List<ContributionModel> contribs,
    pw.Font font,
    pw.Font bold,
    PdfColor lightGrey,
  ) {
    return pw.TableHelper.fromTextArray(
      headers: ['Date', 'Member', 'Amount', 'Status'],
      headerStyle: pw.TextStyle(font: bold, fontSize: 9, color: PdfColors.white),
      headerDecoration: pw.BoxDecoration(color: PdfColor.fromHex('#00A86B')),
      cellStyle: pw.TextStyle(font: font, fontSize: 9),
      rowDecoration: pw.BoxDecoration(color: lightGrey),
      data: contribs.map((c) => [
        _dateFormat.format(c.contributionDate),
        c.memberName,
        'RWF ${_fmt(c.amount)}',
        c.status.toUpperCase(),
      ]).toList(),
    );
  }

  static pw.Widget _buildLoansTable(
    List<LoanModel> loans,
    pw.Font font,
    pw.Font bold,
    PdfColor lightGrey,
  ) {
    return pw.TableHelper.fromTextArray(
      headers: ['Borrower', 'Amount', 'Interest', 'Duration', 'Repaid', 'Status'],
      headerStyle: pw.TextStyle(font: bold, fontSize: 9, color: PdfColors.white),
      headerDecoration: pw.BoxDecoration(color: PdfColor.fromHex('#F5A623')),
      cellStyle: pw.TextStyle(font: font, fontSize: 9),
      rowDecoration: pw.BoxDecoration(color: lightGrey),
      data: loans.map((l) => [
        l.borrowerName,
        'RWF ${_fmt(l.amount)}',
        '${l.interestRate}%',
        '${l.durationMonths} months',
        'RWF ${_fmt(l.amountRepaid)}',
        l.status.toUpperCase(),
      ]).toList(),
    );
  }

  static pw.Widget _buildPayoutsTable(
    List<PayoutModel> payouts,
    pw.Font font,
    pw.Font bold,
    PdfColor lightGrey,
  ) {
    return pw.TableHelper.fromTextArray(
      headers: ['Round', 'Recipient', 'Amount', 'Date', 'Status'],
      headerStyle: pw.TextStyle(font: bold, fontSize: 9, color: PdfColors.white),
      headerDecoration: pw.BoxDecoration(color: PdfColor.fromHex('#29B6F6')),
      cellStyle: pw.TextStyle(font: font, fontSize: 9),
      rowDecoration: pw.BoxDecoration(color: lightGrey),
      data: payouts.map((p) => [
        '#${p.roundNumber}',
        p.memberName,
        'RWF ${_fmt(p.amount)}',
        p.paidAt != null ? _dateFormat.format(p.paidAt!) : 'Pending',
        p.status.toUpperCase(),
      ]).toList(),
    );
  }

  static String _fmt(double val) => _currencyFormat.format(val.round());
}
