import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/feature/home/presentation/view/widget/custom_button.dart';
import 'package:loan_management/feature/home/presentation/view/widget/custom_text_field.dart';
import 'package:provider/provider.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/cubit/add_installment_cubit.dart';
import '../../view_model/cubit/add_installment_state.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final TextEditingController startDataController = TextEditingController();
  final TextEditingController installmentNameController =
      TextEditingController();
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
    return CustomScaffold(
      appBar: CustomAppBar(title: S.of(context).home),
      body: BlocBuilder<InstallmentCubit, InstallmentState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.installments.length,
            itemBuilder: (context, index) {
              final installment = state.installments[index];
              return ListTile(
                title: Text(installment['installment_name']!),
                subtitle: Text(
                    'Amount: ${installment['total_amount']} - Value: ${installment['installment_value']}'),
                trailing: Text(installment['start_date']!),
              );
            },
          );
        },
      ),
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          showDialogWidget(context, themeProvider);
        },
        child: const CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primaryColor,
          child: Icon(
            Icons.add,
            color: AppColors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  void showDialogWidget(BuildContext context, ThemeProvider themeProvider) {
    showDialog(
      context: context,
      builder: (context) {
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
                          BlocProvider.of<InstallmentCubit>(context)
                              .addInstallment(
                            installmentName: installmentNameController.text,
                            totalAmount: totalAmountController.text,
                            numOfMonth: numOfMonthController.text,
                            installmentValue: installmentValueController.text,
                            startDate: startDataController.text,
                          );
                          Navigator.pop(context);
                        } else {}
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
