import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:loan_management/core/constant/app_theme.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/core/widget/custom_toast.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/check_account_widget.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/custom_text_field.dart';
import 'package:loan_management/generated/l10n.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_styles.dart';
import '../../../../../core/widget/custom_app_bar.dart';
import '../../view_model/auth_bloc/auth_bloc.dart';
import 'role_button.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool visibility = true;
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
        if (state is RegisterLoading) {
          SmartDialog.showLoading();
        } else if (state is RegisterSuccess) {
          context.go('/signInView');
          SmartDialog.dismiss();
          CustomToast.show(
            message: S.of(context).verify_email,
          );
        } else if (state is RegisterFailure) {
          SmartDialog.dismiss();
          CustomToast.show(
            message: state.messageError,
            backgroundColor: Colors.red,
          );
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          appBar: CustomAppBar(title: S.of(context).sign_up),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth < 600 ? 16 : screenWidth * .15),
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    S.of(context).name,
                    style: AppStyles.textStyle18black,
                  ),
                  CustomTextfield(
                    enableColor: themeProvider.isDarkTheme
                        ? AppColors.widgetColorDark
                        : const Color(0xffBCB8B1),
                    hintText: S.of(context).enter_name,
                    obscureText: false,
                    controller: usernameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == '') {
                        return S.of(context).value_empty;
                      } else {
                        return null;
                      }
                    },
                  ),
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
                    S.of(context).phone,
                    style: AppStyles.textStyle18black,
                  ),
                  CustomTextfield(
                    enableColor: themeProvider.isDarkTheme
                        ? AppColors.widgetColorDark
                        : const Color(0xffBCB8B1),
                    hintText: S.of(context).phone,
                    obscureText: false,
                    controller: phoneController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.length != 11) {
                        return S.of(context).valid_phone;
                      } else {
                        return null;
                      }
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
                  Text(
                    S.of(context).confirm_pass,
                    style: AppStyles.textStyle18black,
                  ),
                  CustomTextfield(
                    enableColor: themeProvider.isDarkTheme
                        ? AppColors.widgetColorDark
                        : const Color(0xffBCB8B1),
                    hintText: S.of(context).confirm_pass,
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
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonColor: AppColors.primaryColor,
                    width: double.infinity,
                    title: S.of(context).sign_up,
                    onTap: () {
                      if (passwordController.text ==
                          confirmPasswordController.text) {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(
                            RegisterEvent(
                              phoneNumber: phoneController.text,
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              role: selectedRole,
                            ),
                          );
                        } else {
                          CustomToast.show(
                              message: S.of(context).check_email_or_pass);
                        }
                      } else {
                        CustomToast.show(
                            message: S.of(context).password_not_match);
                      }
                    },
                    textColor: AppColors.white,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CheckedAccount(
                    title: S.of(context).already_have_account,
                    buttonTitle: S.of(context).login,
                    buttonOnTap: () {
                      context.push('/signInView');
                    },
                  ),
                  const SizedBox(
                    height: 30,
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
