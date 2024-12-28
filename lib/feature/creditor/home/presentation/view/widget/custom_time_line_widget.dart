import 'package:flutter/material.dart';
import 'package:loan_management/feature/creditor/home/presentation/view_model/cubit/creditor_installment_cubit.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/generated/l10n.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import '../../../../../../core/widget/show_snack_bar.dart';
import 'package:provider/provider.dart';
import '../../../data/model/creditor_installment_model.dart';

class CustomTimelineTileWidget extends StatelessWidget {
  final CreditorInstallmentModel installment;
  final int index;
  final List<bool> completedMonths;
  final List<TextEditingController> textControllers;
  final Function(int, bool) onMonthStatusChange;
  final void Function(String)? onMonthNoteChanged;
  const CustomTimelineTileWidget({
    super.key,
    required this.index,
    required this.completedMonths,
    required this.textControllers,
    required this.onMonthStatusChange,
    required this.onMonthNoteChanged,
    required this.installment,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.0,
      isLast: index == completedMonths.length - 1,
      indicatorStyle: IndicatorStyle(
        indicator: CircleAvatar(
          backgroundColor: completedMonths[index] ? Colors.green : Colors.grey,
          child: Text(
            '${index + 1}',
            style: AppStyles.textStyle18black,
          ),
        ),
        width: 40,
        height: 50,
        padding: const EdgeInsets.all(8),
      ),
      beforeLineStyle: LineStyle(
        thickness: 2,
        color: completedMonths[index] ? Colors.green : Colors.grey,
      ),
      endChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: themeProvider.isDarkTheme
                ? AppColors.widgetColorDark
                : AppColors.whiteGrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${S.of(context).month} ${index + 1}',
                      style: AppStyles.textStyle18black),
                  Checkbox(
                    fillColor: WidgetStatePropertyAll(
                      completedMonths[index]
                          ? Colors.green
                          : themeProvider.isDarkTheme
                              ? AppColors.widgetColorDark
                              : AppColors.whiteGrey,
                    ),
                    value: completedMonths[index],
                    onChanged: completedMonths[index]
                        ? null
                        : (value) {
                            if (index == 0 || completedMonths[index - 1]) {
                              onMonthStatusChange(index, value ?? false);
                              context
                                  .read<CreditorInstallmentCubit>()
                                  .checkAndMoveToCompleted(installment);
                            } else {
                              showSnackBar(context,
                                  '${S.of(context).complete_the_current_month} $index ${S.of(context).before_selecting_month}');
                            }
                          },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  maxLines: 2,
                  style: AppStyles.textStyle18black,
                  controller: textControllers[index],
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: AppColors.primaryColor),
                    ),
                    hintText: S.of(context).enter_note,
                    hintStyle: AppStyles.textStyle18gray,
                  ),
                  onChanged: onMonthNoteChanged,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
