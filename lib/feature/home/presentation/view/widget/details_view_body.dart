import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../../../../core/constant/app_theme.dart';
import '../../../../../core/widget/show_snack_bar.dart';
import '../../../data/model/installment_model.dart';
import '../../view_model/cubit/installment_cubit.dart';

class DetailsViewBody extends StatefulWidget {
  final InstallmentModel installment;
  const DetailsViewBody({
    super.key,
    required this.installment,
  });

  @override
  State<DetailsViewBody> createState() => _DetailsViewBodyState();
}

class _DetailsViewBodyState extends State<DetailsViewBody> {
  late List<bool> completedMonths;
  late List<String?> monthNotes;
  late List<TextEditingController> textControllers;

  @override
  void initState() {
    super.initState();
    completedMonths = widget.installment.completedMonths;
    monthNotes = widget.installment.monthNotes;
    textControllers = List.generate(
      widget.installment.numOfMonths.toInt(),
      (index) => TextEditingController(text: monthNotes[index]),
    );
  }

  @override
  void dispose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateMonthStatus(int index, bool isCompleted) {
    setState(() {
      completedMonths[index] = isCompleted;
      if (isCompleted) {
        widget.installment.totalPaid += widget.installment.installmentValue;
      } else {
        widget.installment.totalPaid -= widget.installment.installmentValue;
      }
      widget.installment.completedMonths = completedMonths;
    });
    widget.installment.save();
    if (completedMonths.every((month) => month)) {
      context
          .read<InstallmentCubit>()
          .checkAndMoveToCompleted(widget.installment);
    }
  }

  void _updateMonthNotes(int index, String? note) {
    setState(() {
      monthNotes[index] = note;
      widget.installment.monthNotes = monthNotes;
    });
    widget.installment.save();
  }

  @override
  Widget build(BuildContext context) {
    int remainingMonths = widget.installment.numOfMonths.toInt() -
        widget.installment.completedMonths.where((month) => month).length;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          widget.installment.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Column(
              children: [
                Text(
                  "${S.of(context).remaining} ${remainingMonths.toString()} ${S.of(context).months}",
                  style: AppStyles.textStyle24,
                ),
                const SizedBox(height: 10),
                Text(
                  "${S.of(context).remaining_amount}: ${(widget.installment.totalAmount - widget.installment.totalPaid).toString()}",
                  style: AppStyles.textStyle20notBoldWhite,
                ),
                const SizedBox(height: 15),
                MyWidget(
                  title: S.of(context).amount_monthly,
                  subtitle: widget.installment.installmentValue.toString(),
                ),
                MyWidget(
                  title: S.of(context).amount_paid,
                  subtitle:
                      " ${widget.installment.totalPaid.toString()}/${widget.installment.totalAmount.toString()}",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.installment.numOfMonths.toInt(),
              itemBuilder: (context, index) {
                return TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.0,
                  isLast: index == widget.installment.numOfMonths.toInt() - 1,
                  indicatorStyle: IndicatorStyle(
                    indicator: CircleAvatar(
                      backgroundColor:
                          completedMonths[index] ? Colors.green : Colors.grey,
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
                                        if (index == 0 ||
                                            completedMonths[index - 1]) {
                                          _updateMonthStatus(
                                              index, value ?? false);
                                        } else {
                                          showSnackBar(context,
                                              '${S.of(context).complete_the_current_month} $index ${S.of(context).before_selecting_month}');
                                        }
                                      },
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
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.primaryColor),
                                ),
                                hintText: S.of(context).enter_note,
                                hintStyle: AppStyles.textStyle18gray,
                              ),
                              onChanged: (value) =>
                                  _updateMonthNotes(index, value),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  const MyWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/img/money.svg",
                height: 30,
              ),
              const SizedBox(width: 10),
              Text(
                "$title: ",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Text(
            subtitle,
            style: AppStyles.textStyle18White,
          ),
        ],
      ),
    );
  }
}
