import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/custom_button.dart';
import 'package:loan_management/feature/debtor/home/presentation/view/widget/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constant/app_colors.dart';
import '../../../../../../core/constant/app_theme.dart';
import '../../../../../../generated/l10n.dart';
import '../../../data/model/creditor_installment_model.dart';
import 'package:uuid/uuid.dart';
import '../../view_model/cubit/creditor_installment_cubit.dart';

class CreditorDialogWidget extends StatefulWidget {
  const CreditorDialogWidget({super.key});

  @override
  State<CreditorDialogWidget> createState() => _CreditorDialogWidgetState();
}

class _CreditorDialogWidgetState extends State<CreditorDialogWidget> {
  final TextEditingController startDataController = TextEditingController();
  final TextEditingController installmentNameController =
      TextEditingController();
  final TextEditingController debtorNameController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController numOfMonthController = TextEditingController();
  final TextEditingController installmentValueController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('d MMMM yyyy').format(pickedDate);
      setState(() {
        startDataController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Dialog(
      backgroundColor: themeProvider.isDarkTheme
          ? AppColors.widgetColorDark
          : AppColors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                            double.tryParse(totalAmountController.text) ?? 0,
                        numOfMonths:
                            int.tryParse(numOfMonthController.text) ?? 0,
                        installmentValue:
                            double.tryParse(installmentValueController.text) ??
                                0,
                        startDate:
                            DateTime.tryParse(startDataController.text) ??
                                DateTime.now(),
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
  }
}
