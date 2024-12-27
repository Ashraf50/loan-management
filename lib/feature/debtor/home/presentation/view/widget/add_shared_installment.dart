import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/custom_text_field.dart';
import 'package:loan_management/feature/debtor/home/presentation/view_model/cubit/debtor_installment_cubit.dart';
import 'package:loan_management/feature/debtor/home/presentation/view_model/cubit/debtor_installment_state.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../../core/widget/show_snack_bar.dart';
import '../../../../../../generated/l10n.dart';

class AddSharedInstallment extends StatefulWidget {
  const AddSharedInstallment({super.key});

  @override
  State<AddSharedInstallment> createState() => _AddSharedInstallmentState();
}

class _AddSharedInstallmentState extends State<AddSharedInstallment> {
  final TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DebtorInstallmentCubit, DebtorInstallmentState>(
      listener: (context, state) {
        if (state is DebtorInstallmentSuccess) {
          BlocProvider.of<DebtorInstallmentCubit>(context)
              .fetchAllInstallment();
          Navigator.pop(context);
        } else if (state is DebtorInstallmentFailure) {
          showSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is DebtorInstallmentLoading ? true : false,
          child: CustomScaffold(
            appBar: CustomAppBar(title: S.of(context).add_shared_inst),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ListView(
                children: [
                  CustomTextfield(
                    labelText: "Enter id",
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
