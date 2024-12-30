import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/feature/creditor/home/presentation/view_model/cubit/creditor_installment_state.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/custom_button.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/custom_text_field.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../../../../core/widget/custom_toast.dart';
import '../../../../../../generated/l10n.dart';
import '../../../data/model/creditor_installment_model.dart';
import 'package:uuid/uuid.dart';
import '../../view_model/cubit/creditor_installment_cubit.dart';

class AddInstallmentView extends StatefulWidget {
  const AddInstallmentView({super.key});

  @override
  State<AddInstallmentView> createState() => _AddInstallmentViewState();
}

class _AddInstallmentViewState extends State<AddInstallmentView> {
  final TextEditingController startDataController = TextEditingController();
  final TextEditingController installmentNameController =
      TextEditingController();
  final TextEditingController debtorNameController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController numOfMonthController = TextEditingController();
  final TextEditingController installmentValueController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        startDataController.text = DateFormat('d MMMM yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreditorInstallmentCubit, CreditorInstallmentState>(
      listener: (context, state) {
        if (state is CreditorInstallmentSuccess) {
          BlocProvider.of<CreditorInstallmentCubit>(context)
              .fetchAllInstallment();
          Navigator.pop(context);
        } else if (state is CreditorInstallmentFailure) {
          CustomToast.show(message: state.errMessage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is CreditorInstallmentLoading ? true : false,
          child: CustomScaffold(
            appBar: CustomAppBar(title: S.of(context).add_installment),
            body: Form(
              key: formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView(
                  children: [
                    CustomTextfield(
                      labelText: S.of(context).debtor_name,
                      keyboardType: TextInputType.text,
                      controller: debtorNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == '') {
                          return S.of(context).empty_value;
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextfield(
                      labelText: S.of(context).installment_name,
                      keyboardType: TextInputType.text,
                      controller: installmentNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == '') {
                          return S.of(context).empty_value;
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextfield(
                      labelText: S.of(context).total_amount,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: totalAmountController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == '') {
                          return S.of(context).empty_value;
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextfield(
                      labelText: S.of(context).num_of_month,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: numOfMonthController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == '') {
                          return S.of(context).empty_value;
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextfield(
                      labelText: S.of(context).installment_value,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: installmentValueController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == '') {
                          return S.of(context).empty_value;
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomTextfield(
                      labelText: S.of(context).start_date,
                      controller: startDataController,
                      readOnly: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == '') {
                          return S.of(context).empty_value;
                        } else {
                          return null;
                        }
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    CustomButton(
                      title: S.of(context).add_installment,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          var uuid = const Uuid();
                          CreditorInstallmentModel creditorInstallment =
                              CreditorInstallmentModel(
                            installmentId: uuid.v4(),
                            installmentDebtor: debtorNameController.text,
                            title: installmentNameController.text,
                            totalAmount:
                                double.tryParse(totalAmountController.text) ??
                                    0,
                            numOfMonths:
                                int.tryParse(numOfMonthController.text) ?? 0,
                            installmentValue: double.tryParse(
                                    installmentValueController.text) ??
                                0,
                            startDate: selectedDate ?? DateTime.now(),
                            completedMonths: List.filled(
                              int.tryParse(numOfMonthController.text) ?? 0,
                              false,
                            ),
                            monthNotes: List.filled(
                              int.tryParse(numOfMonthController.text) ?? 0,
                              null,
                            ),
                            totalPaid: 0,
                          );
                          BlocProvider.of<CreditorInstallmentCubit>(context)
                              .add(creditorInstallment);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
