import 'package:flutter/material.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../../../generated/l10n.dart';

class ScanInstallmentView extends StatelessWidget {
  final Function(String) onScan;
  const ScanInstallmentView({
    super.key,
    required this.onScan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).scan_installment),
      body: MobileScanner(
        onDetect: (barcode) {
          if (barcode.raw != null) {
            try {
              var rawMap = barcode.raw as Map;
              var displayedValue = rawMap["data"][0]["displayValue"];
              onScan(displayedValue);
            } catch (e) {
              print("Error processing barcode from scanner: $e");
            }
          }
        },
      ),
    );
  }
}
