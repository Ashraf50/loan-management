import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/widget/custom_widget.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/debtor_local_time_line.dart';
import 'package:loan_management/feature/debtor/home/presentation/view_model/update_installment/debtor_update_cubit.dart';
import 'package:loan_management/generated/l10n.dart';
import '../../../data/model/debtor_installment_model.dart';

class DebtorLocalDetailsViewBody extends StatefulWidget {
  final DebtorInstallmentModel installment;
  const DebtorLocalDetailsViewBody({
    super.key,
    required this.installment,
  });

  @override
  State<DebtorLocalDetailsViewBody> createState() =>
      _DebtorLocalDetailsViewBodyState();
}

class _DebtorLocalDetailsViewBodyState
    extends State<DebtorLocalDetailsViewBody> {
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DebtorUpdateCubit(),
      child: BlocBuilder<DebtorUpdateCubit, DebtorUpdateState>(
        builder: (context, state) {
          final cubit = context.read<DebtorUpdateCubit>();
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
                        "${S.of(context).remaining} ${widget.installment.numOfMonths.toInt() - widget.installment.completedMonths.where((month) => month).length} ${S.of(context).months}",
                        style: AppStyles.textStyle24,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "${S.of(context).remaining_amount}: ${(widget.installment.totalAmount - widget.installment.totalPaid).toString()}",
                        style: AppStyles.textStyle20notBoldWhite,
                      ),
                      const SizedBox(height: 15),
                      CustomWidget(
                        title: S.of(context).amount_monthly,
                        subtitle:
                            widget.installment.installmentValue.toString(),
                      ),
                      CustomWidget(
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
                      return DebtorLocalTimeLine(
                        installment: widget.installment,
                        index: index,
                        completedMonths: completedMonths,
                        textControllers: textControllers,
                        onMonthStatusChange: (int index, bool value) {
                          cubit.updateMonthStatus(
                              widget.installment, index, value);
                        },
                        onMonthNoteChanged: (value) {
                          cubit.updateMonthNotes(
                              widget.installment, index, value);
                        },
                        canRemoveMark: () =>
                            cubit.canRemoveMark(widget.installment),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
