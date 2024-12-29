import 'package:flutter/material.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/helper/AuthHelper.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/debtor_shared_time_line.dart';
import 'package:loan_management/generated/l10n.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/widget/custom_widget.dart';
import '../../../data/model/debtor_installment_model.dart';
import '../../view_model/cubit/debtor_installment_cubit.dart';

class DebtorSharedDetailsViewBody extends StatefulWidget {
  final DebtorInstallmentModel installment;
  const DebtorSharedDetailsViewBody({
    super.key,
    required this.installment,
  });

  @override
  State<DebtorSharedDetailsViewBody> createState() =>
      _DebtorSharedDetailsViewBodyState();
}

class _DebtorSharedDetailsViewBodyState
    extends State<DebtorSharedDetailsViewBody> {
  late List<String?> monthNotes;
  late List<TextEditingController> textControllers;
  late Future<List<Map<String, dynamic>>?> futureInstallmentData;
  @override
  void initState() {
    super.initState();
    monthNotes = widget.installment.monthNotes;
    textControllers = List.generate(
      widget.installment.numOfMonths.toInt(),
      (index) => TextEditingController(text: monthNotes[index]),
    );
    futureInstallmentData =
        AuthHelper().fetchInstallmentData(widget.installment.id);
  }

  @override
  void dispose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateMonthNotes(int index, String? note) {
    setState(() {
      monthNotes[index] = note;
    });
    widget.installment.monthNotes = monthNotes;
    widget.installment.save();
  }

  void updateTotalPaid(double newTotalPaid, List completedMonths) {
    widget.installment.totalPaid = newTotalPaid;
    widget.installment.completedMonths = completedMonths.cast();
    widget.installment.save();
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: futureInstallmentData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
                child: Text(
              S.of(context).no_data,
              style: AppStyles.textStyle20notBold,
            ));
          } else {
            final installmentData = snapshot.data!;
            updateTotalPaid(
              installmentData[0]["total_paid"],
              installmentData[0]["completed_months"],
            );
            if (widget.installment.completedMonths.every((month) => month)) {
              context
                  .read<DebtorInstallmentCubit>()
                  .checkAndMoveToCompleted(widget.installment);
            }
            int remainingMonths = installmentData[0]["number_of_months"]
                    .toInt() -
                List<bool>.from(installmentData[0]["completed_months"] as List)
                    .where((month) => month)
                    .length;
            double totalAmount = installmentData[0]["total_amount"];
            double totalPaid = installmentData[0]["total_paid"];
            return ListView(
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
                        "${S.of(context).remaining_amount}: ${(totalAmount - totalPaid).toString()}",
                        style: AppStyles.textStyle20notBoldWhite,
                      ),
                      const SizedBox(height: 15),
                      CustomWidget(
                        title: S.of(context).amount_monthly,
                        subtitle:
                            installmentData[0]["installment_value"].toString(),
                      ),
                      CustomWidget(
                        title: S.of(context).amount_paid,
                        subtitle:
                            " ${totalPaid.toString()}/${totalAmount.toString()}",
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
                      return DebtorSharedTimeLine(
                        installment: widget.installment,
                        index: index,
                        completedMonth: installmentData[0]["completed_months"]
                            [index],
                        textControllers: textControllers,
                        monthNote: installmentData[0]["month_notes"][index],
                        onMonthNoteChanged: (value) {
                          _updateMonthNotes(index, value);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
