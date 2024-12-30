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
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_styles.dart';
import '../../../../../core/constant/app_theme.dart';
import '../../../../../core/widget/custom_app_bar.dart';
import '../../../../../generated/l10n.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ResetLoading) {
          SmartDialog.showLoading();
        } else if (state is ResetSuccess) {
          context.push("/updatePasswordView");
          CustomToast.show(
            message: S.of(context).otp_sended,
            backgroundColor: AppColors.toastColor,
          );
          SmartDialog.dismiss();
        } else if (state is ResetFailure) {
          SmartDialog.dismiss();
          CustomToast.show(
            message: state.messageError,
            backgroundColor: Colors.red,
          );
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
                  SizedBox(
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.4,
                    child: Lottie.asset(
                      'assets/img/forget_pass.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    S.of(context).forget_password,
                    style: AppStyles.textStyle24black,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    S.of(context).please_enter_your_email,
                    style: AppStyles.textStyle18gray,
                  ),
                  const SizedBox(
                    height: 30,
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
                  CustomButton(
                    title: S.of(context).send_otp,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                          ResetEvent(
                            email: emailController.text,
                          ),
                        );
                      } else {
                        CustomToast.show(
                          message: S.of(context).valid_email,
                        );
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
