import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/custom_text_field.dart';
import 'package:loan_management/feature/debtor/home/presentation/view_model/cubit/debtor_installment_cubit.dart';
import 'package:loan_management/feature/debtor/home/presentation/view_model/cubit/debtor_installment_state.dart';
import '../../../../../../core/widget/custom_toast.dart';
import '../../../../../../generated/l10n.dart';

class AddSharedInstallment extends StatefulWidget {
  const AddSharedInstallment({super.key});

  @override
  State<AddSharedInstallment> createState() => _AddSharedInstallmentState();
}

class _AddSharedInstallmentState extends State<AddSharedInstallment> {
  final TextEditingController idController = TextEditingController();
  void onScan(String scannedValue) {
    idController.text = scannedValue;
    BlocProvider.of<DebtorInstallmentCubit>(context)
        .addInstallmentById(scannedValue);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DebtorInstallmentCubit, DebtorInstallmentState>(
      listener: (context, state) {
        if (state is DebtorInstallmentSuccess) {
          BlocProvider.of<DebtorInstallmentCubit>(context)
              .fetchAllInstallment();
          SmartDialog.dismiss();
          context.pop(context);
        } else if (state is DebtorInstallmentFailure) {
          SmartDialog.dismiss();
          CustomToast.show(
            message: state.errMessage,
            backgroundColor: Colors.red,
          );
        } else if (state is DebtorInstallmentLoading) {
          SmartDialog.showLoading();
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          appBar: CustomAppBar(title: S.of(context).add_shared_inst),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ListView(
              children: [
                CustomTextfield(
                  labelText: S.of(context).enter_id,
                  keyboardType: TextInputType.text,
                  controller: idController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == '') {
                      return S.of(context).empty_value;
                    } else {
                      return null;
                    }
                  },
                ),
                CustomButton(
                  title: S.of(context).Search_for_installment,
                  width: double.infinity,
                  onTap: () {
                    String installmentId = idController.text;
                    if (installmentId.isNotEmpty) {
                      BlocProvider.of<DebtorInstallmentCubit>(context)
                          .addInstallmentById(installmentId);
                    }
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  title: S.of(context).scan_installment,
                  onTap: () {
                    context.push(
                      "/scan_view",
                      extra: onScan,
                    );
                  },
                  width: double.infinity,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
