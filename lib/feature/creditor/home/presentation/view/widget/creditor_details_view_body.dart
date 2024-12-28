import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/feature/creditor/home/presentation/view/widget/custom_time_line_widget.dart';
import 'package:loan_management/feature/creditor/home/presentation/view/widget/share_installment_dialog.dart';
import 'package:loan_management/generated/l10n.dart';
import '../../../../../../core/widget/custom_widget.dart';
import '../../../../../../core/widget/show_snack_bar.dart';
import '../../../data/model/creditor_installment_model.dart';
import '../../view_model/update_installment/creditor_update_cubit.dart';

class CreditorDetailsViewBody extends StatefulWidget {
  final CreditorInstallmentModel installment;
  const CreditorDetailsViewBody({
    super.key,
    required this.installment,
  });

  @override
  State<CreditorDetailsViewBody> createState() =>
      _CreditorDetailsViewBodyState();
}

class _CreditorDetailsViewBodyState extends State<CreditorDetailsViewBody> {
  late List<bool> completedMonths;
  late List<String?> monthNotes;
  late List<TextEditingController> textControllers;
  late StreamSubscription connectivitySubscription;

  @override
  void initState() {
    super.initState();
    completedMonths = widget.installment.completedMonths;
    monthNotes = widget.installment.monthNotes;
    textControllers = List.generate(
      widget.installment.numOfMonths.toInt(),
      (index) => TextEditingController(text: monthNotes[index]),
    );
    connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult != ConnectivityResult.none) {
        context.read<CreditorUpdateCubit>().uploadOfflineData();
      }
    });
  }

  @override
  void dispose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int remainingMonths = widget.installment.numOfMonths.toInt() -
        widget.installment.completedMonths.where((month) => month).length;
    return BlocConsumer<CreditorUpdateCubit, CreditorUpdateState>(
      listener: (context, state) {
        if (state is UpdateSuccess) {
          Future.delayed(const Duration(seconds: 1), () {
            showSnackBar(context, S.of(context).success);
          });
        } else if (state is UpdateFailure) {
          Future.delayed(const Duration(seconds: 10), () {
            showSnackBar(context, state.errorMessage);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            scrolledUnderElevation: 0,
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
            title: Text(
              widget.installment.installmentDebtor,
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
                      widget.installment.title,
                      style: AppStyles.textStyle24,
                    ),
                    const SizedBox(height: 10),
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
                    CustomWidget(
                      title: S.of(context).amount_monthly,
                      subtitle: widget.installment.installmentValue.toString(),
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
                    return CustomTimelineTileWidget(
                      installment: widget.installment,
                      index: index,
                      completedMonths: completedMonths,
                      textControllers: textControllers,
                      onMonthStatusChange: (int index, bool value) {
                        context.read<CreditorUpdateCubit>().updateMonthStatus(
                            widget.installment, index, value);
                      },
                      onMonthNoteChanged: (value) {
                        context
                            .read<CreditorUpdateCubit>()
                            .updateMonthNotes(widget.installment, index, value);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          floatingActionButton: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              showDialogWidget(
                widget.installment.installmentId,
              );
            },
            child: const CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                Icons.share,
                color: AppColors.white,
                size: 30,
              ),
            ),
          ),
        );
      },
    );
  }

  void showDialogWidget(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return ShareInstallmentDialog(id: id);
      },
    );
  }
}
