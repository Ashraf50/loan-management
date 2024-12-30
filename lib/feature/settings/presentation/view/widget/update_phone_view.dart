import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/custom_text_field.dart';
import 'package:loan_management/feature/settings/presentation/view_model/update_bloc/update_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_theme.dart';
import '../../../../../core/widget/custom_toast.dart';
import '../../../../../generated/l10n.dart';

class UpdatePhoneView extends StatelessWidget {
  const UpdatePhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final phoneController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => UpdateBloc(),
      child: BlocConsumer<UpdateBloc, UpdateState>(
        listener: (context, state) {
          if (state is UpdatePhoneLoading) {
            SmartDialog.showLoading();
          } else if (state is UpdatePhoneSuccess) {
            SmartDialog.dismiss();
            CustomToast.show(
              message: S.of(context).success,
              backgroundColor: AppColors.toastColor,
              alignment: Alignment.topCenter,
            );
            context.pop();
          } else if (state is UpdatePhoneFailure) {
            SmartDialog.dismiss();
            CustomToast.show(
              message: state.errMessage,
              backgroundColor: Colors.red,
            );
          }
        },
        builder: (context, state) {
          return CustomScaffold(
            appBar: CustomAppBar(title: S.of(context).update_phone),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextfield(
                      enableColor: themeProvider.isDarkTheme
                          ? AppColors.widgetColorDark
                          : const Color(0xffBCB8B1),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.length != 11) {
                          return S.of(context).valid_phone;
                        } else {
                          return null;
                        }
                      },
                      hintText: S.of(context).update_phone, // Adjusted key
                      obscureText: false,
                      controller: phoneController,
                    ),
                    CustomButton(
                      title: S.of(context).save_changes,
                      width: double.infinity,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<UpdateBloc>(context).add(
                            UpdatePhoneEvent(
                              phone: phoneController.text,
                            ),
                          );
                        } else {
                          CustomToast.show(message: S.of(context).value_empty);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
