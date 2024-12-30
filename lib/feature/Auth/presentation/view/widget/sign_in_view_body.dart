import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_toast.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/check_account_widget.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/custom_text_field.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/role_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../../../core/widget/custom_app_bar.dart';
import '../../../../../core/widget/custom_scaffold.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/auth_bloc/auth_bloc.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool visibility = true;
  bool isLoading = false;
  late String selectedRole;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedRole = S.of(context).debtor;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          if (state.role == S.of(context).debtor) {
            context.go('/DebtorBottomBar');
          } else {
            context.go('/CreditorBottomBar');
          }
          CustomToast.show(
            message: S.of(context).success,
            alignment: Alignment.topCenter,
            backgroundColor: AppColors.toastColor,
          );

          isLoading = false;
        } else if (state is LoginFailure) {
          isLoading = false;
          CustomToast.show(
            message: state.message,
            backgroundColor: Colors.red,
          );
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
            appBar: CustomAppBar(title: S.of(context).login),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth < 600 ? 16 : screenWidth * .15),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoleButton(
                          selectedRole: selectedRole,
                          title: S.of(context).debtor,
                          onTap: () {
                            setState(() {
                              selectedRole = S.of(context).debtor;
                            });
                          },
                        ),
                        RoleButton(
                          selectedRole: selectedRole,
                          title: S.of(context).creditor,
                          onTap: () {
                            setState(() {
                              selectedRole = S.of(context).creditor;
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      S.of(context).email,
                      style: AppStyles.textStyle18black,
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
                    Text(
                      S.of(context).password,
                      style: AppStyles.textStyle18black,
                    ),
                    CustomTextfield(
                      enableColor: themeProvider.isDarkTheme
                          ? AppColors.widgetColorDark
                          : const Color(0xffBCB8B1),
                      hintText: S.of(context).enter_password,
                      obscureText: visibility,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                        icon: visibility
                            ? const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )
                            : const Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.length < 6) {
                          return S.of(context).valid_pass;
                        } else {
                          return null;
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            context.push('/forgetPasswordView');
                          },
                          child: Text(
                            S.of(context).forget_pass,
                            style: themeProvider.isDarkTheme
                                ? AppStyles.textStyle18
                                : AppStyles.textStyle18green,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      buttonColor: AppColors.primaryColor,
                      title: S.of(context).login,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(LoginEvent(
                              email: emailController.text,
                              password: passwordController.text,
                              role: selectedRole));
                        } else {
                          CustomToast.show(
                            message: S.of(context).check_email_or_pass,
                          );
                        }
                      },
                      textColor: AppColors.white,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CheckedAccount(
                      title: S.of(context).don_have_account,
                      buttonTitle: S.of(context).sign_up,
                      buttonOnTap: () {
                        context.push('/signUpView');
                      },
                    ),
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
