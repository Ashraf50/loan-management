import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../../../../core/constant/app_colors.dart';
import '../../../../../../core/constant/app_styles.dart';
import '../../../../../../core/constant/app_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../../data/model/debtor_installment_model.dart';

class DebtorSharedTimeLine extends StatelessWidget {
  final DebtorInstallmentModel installment;
  final int index;
  final bool completedMonth;
  final List<TextEditingController> textControllers;
  final String? monthNote;
  final void Function(String)? onMonthNoteChanged;

  const DebtorSharedTimeLine({
    super.key,
    required this.installment,
    required this.index,
    required this.completedMonth,
    required this.textControllers,
    required this.monthNote,
    required this.onMonthNoteChanged,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.0,
      isLast: index == installment.numOfMonths.toInt() - 1,
      indicatorStyle: IndicatorStyle(
        indicator: CircleAvatar(
          backgroundColor: completedMonth ? Colors.green : Colors.grey,
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
        color: completedMonth ? Colors.green : Colors.grey,
      ),
      endChild: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: themeProvider.isDarkTheme
                  ? AppColors.widgetColorDark
                  : AppColors.whiteGrey,
              borderRadius: BorderRadius.circular(12)),
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
                      completedMonth
                          ? Colors.green
                          : themeProvider.isDarkTheme
                              ? AppColors.widgetColorDark
                              : AppColors.whiteGrey,
                    ),
                    value: completedMonth,
                    onChanged: (value) {},
                  )
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
                    hintText: monthNote ?? S.of(context).enter_note,
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
