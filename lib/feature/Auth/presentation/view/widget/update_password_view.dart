import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/core/widget/custom_toast.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/custom_text_field.dart';
import 'package:loan_management/feature/Auth/presentation/view_model/auth_bloc/auth_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_styles.dart';
import '../../../../../core/constant/app_theme.dart';
import '../../../../../core/widget/custom_app_bar.dart';
import '../../../../../generated/l10n.dart';

class UpdatePasswordView extends StatelessWidget {
  const UpdatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final tokenController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UpdatePassLoading) {
          SmartDialog.showLoading();
        } else if (state is UpdatePassSuccess) {
          context.push("/finishResetPassword");
          SmartDialog.dismiss();
        } else if (state is UpdatePassFailure) {
          SmartDialog.dismiss();
          CustomToast.show(message: state.messageError);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: CustomScaffold(
            appBar: CustomAppBar(title: S.of(context).forget_password),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth < 600 ? 16 : screenWidth * .15),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    S.of(context).reset_pass,
                    style: AppStyles.textStyle24black,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextfield(
                    hintText: S.of(context).enter_otp,
                    controller: tokenController,
                    enableColor: themeProvider.isDarkTheme
                        ? AppColors.widgetColorDark
                        : const Color(0xffBCB8B1),
                  ),
                  CustomTextfield(
                    enableColor: themeProvider.isDarkTheme
                        ? AppColors.widgetColorDark
                        : const Color(0xffBCB8B1),
                    hintText: S.of(context).enter_email,
                    obscureText: false,
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return value != null && !EmailValidator.validate(value)
                          ? S.of(context).valid_email
                          : null;
                    },
                  ),
                  CustomTextfield(
                    enableColor: themeProvider.isDarkTheme
                        ? AppColors.widgetColorDark
                        : const Color(0xffBCB8B1),
                    hintText: S.of(context).enter_new_pass,
                    obscureText: false,
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.length < 6) {
                        return S.of(context).valid_pass;
                      } else {
                        return null;
                      }
                    },
                  ),
                  CustomButton(
                    title: S.of(context).reset_pass,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                          UpdatePassEvent(
                            token: tokenController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      } else {
                        CustomToast.show(
                            message: S.of(context).check_email_or_pass);
                      }
                    },
                    buttonColor: AppColors.primaryColor,
                    textColor: AppColors.white,
                    width: double.infinity,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
