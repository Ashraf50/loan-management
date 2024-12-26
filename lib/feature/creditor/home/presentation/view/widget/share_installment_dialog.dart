import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/core/widget/show_snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../../../core/constant/app_styles.dart';

class ShareInstallmentDialog extends StatelessWidget {
  final String id;
  const ShareInstallmentDialog({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvide = Provider.of<ThemeProvider>(context);
    return Dialog(
      backgroundColor: themeProvide.isDarkTheme
          ? AppColors.widgetColorDark
          : AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: id)).then((_) {
                      showSnackBar(context, "Text copied to clipboard!");
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
            QrImageView(
              data: id,
              version: QrVersions.auto,
              size: 200.0,
              foregroundColor:
                  themeProvide.isDarkTheme ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
