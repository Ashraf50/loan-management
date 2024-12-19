import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/feature/creditor/home/data/model/creditor_installment_model.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constant/app_colors.dart';
import '../../../../../../core/constant/app_styles.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../settings/presentation/view_model/language_bloc/language_bloc.dart';

class CreditorInstallmentItem extends StatefulWidget {
  final CreditorInstallmentModel installment;
  final void Function() onTap;
  const CreditorInstallmentItem({
    super.key,
    required this.installment,
    required this.onTap,
  });

  @override
  State<CreditorInstallmentItem> createState() => _CreditorInstallmentItemState();
}

class _CreditorInstallmentItemState extends State<CreditorInstallmentItem> {
  String? _selectedLanguage;
  @override
  void initState() {
    super.initState();
    _selectedLanguage = BlocProvider.of<LanguageBloc>(context).state
            is AppChangeLanguage
        ? (BlocProvider.of<LanguageBloc>(context).state as AppChangeLanguage)
            .langCode
        : null;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: widget.onTap,
        child: Dismissible(
          key: Key(widget.installment.title),
          direction: DismissDirection.startToEnd,
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: _selectedLanguage == 'ar'
                  ? const BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )
                  : const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
            ),
            alignment: _selectedLanguage == 'ar'
                ? Alignment.centerRight
                : Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
          ),
          onDismissed: (direction) {
            widget.installment.delete();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: themeProvider.isDarkTheme
                  ? AppColors.widgetColorDark
                  : AppColors.whiteGrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.installment.installmentDebtor,
                      style: AppStyles.textStyle20,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${S.of(context).total}: ${widget.installment.totalAmount}",
                      style: AppStyles.textStyle20,
                    )
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                  size: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
