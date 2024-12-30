import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/core/widget/custom_toast.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../../../core/constant/app_styles.dart';
import '../../../../../../generated/l10n.dart';

class ShareInstallmentDialog extends StatelessWidget {
  final String id;
  final ThemeProvider theme;
  const ShareInstallmentDialog({
    super.key,
    required this.id,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: id)).then((_) {
                    CustomToast.show(message: S.of(context).copy);
                  });
                },
                icon: const Icon(Icons.copy),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SelectableText(
                  id,
                  style: AppStyles.textStyle18black,
                ),
              ),
            ],
          ),
        ),
        QrImageView(
          data: id,
          version: QrVersions.auto,
          size: 200.0,
          foregroundColor: theme.isDarkTheme ? Colors.white : Colors.black,
        ),
      ],
    );
  }
}
