import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/core/widget/show_snack_bar.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/custom_text_field.dart';
import 'package:loan_management/feature/Auth/presentation/view_model/auth_bloc/auth_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
    bool isLoading = false;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ResetLoading) {
          isLoading = true;
        } else if (state is ResetSuccess) {
          context.push("/finishResetPassword");

          isLoading = false;
        } else if (state is ResetFailure) {
          isLoading = false;
          showSnackBar(context, state.messageError);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: LoadingAnimationWidget.fourRotatingDots(
            color: AppColors.primaryColor,
            size: 150,
          ),
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
                    controller: emailController,
                  ),
                  CustomButton(
                    title: S.of(context).reset_pass,
                    onTap: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        ResetEvent(
                          email: emailController.text,
                        ),
                      );
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
