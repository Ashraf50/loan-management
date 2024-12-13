import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loan_management/core/constant/app_colors.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/helper/AuthHelper.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/custom_text_field.dart';
import 'package:loan_management/feature/settings/presentation/view/widget/custom_dialog.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constant/app_theme.dart';
import '../../../../../core/widget/custom_app_bar.dart';
import '../../../../../core/widget/custom_snack_bar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../Auth/presentation/view_model/auth_bloc/auth_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UpdateLoading) {
          isLoading = true;
        } else if (state is UpdateSuccess) {
          customDialog(context, emailController.text);
          isLoading = false;
        } else if (state is UpdateFailure) {
          isLoading = false;
          SnackbarHelper.showCustomSnackbar(
            context: context,
            title: S.of(context).error,
            message: state.messageError,
            contentType: ContentType.failure,
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
            appBar: CustomAppBar(title: S.of(context).profile),
            body: FutureBuilder(
              future: AuthHelper().fetchUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No user data available'));
                } else {
                  final userData = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Form(
                      key: formKey,
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            S.of(context).personal_info,
                            style: AppStyles.textStyle20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextfield(
                            enableColor: themeProvider.isDarkTheme
                                ? AppColors.widgetColorDark
                                : const Color(0xffBCB8B1),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return S.of(context).enter_name;
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            hintText: userData["Username"],
                            obscureText: false,
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                            controller: usernameController,
                          ),
                          CustomTextfield(
                            enableColor: themeProvider.isDarkTheme
                                ? AppColors.widgetColorDark
                                : const Color(0xffBCB8B1),
                            validator: (value) {
                              return value != null &&
                                      !EmailValidator.validate(value)
                                  ? S.of(context).valid_email
                                  : null;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            hintText: userData["email"],
                            obscureText: false,
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                            controller: emailController,
                          ),
                          CustomTextfield(
                            enableColor: themeProvider.isDarkTheme
                                ? AppColors.widgetColorDark
                                : const Color(0xffBCB8B1),
                            hintText: userData["phone"],
                            obscureText: false,
                            controller: phoneController,
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.length != 11) {
                                return S.of(context).valid_phone;
                              } else {
                                return null;
                              }
                            },
                          ),
                          CustomTextfield(
                            enableColor: themeProvider.isDarkTheme
                                ? AppColors.widgetColorDark
                                : const Color(0xffBCB8B1),
                            validator: (value) {
                              if (value!.length < 6) {
                                return S.of(context).valid_pass;
                              } else {
                                return null;
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            hintText: "******",
                            obscureText: false,
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                            controller: passwordController,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomButton(
                            title: S.of(context).save_changes,
                            width: double.infinity,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthBloc>(context).add(
                                  UpdateEvent(
                                    email: emailController.text,
                                    username: usernameController.text,
                                    password: passwordController.text,
                                    phone: phoneController.text,
                                    role: userData["role"],
                                  ),
                                );
                              } else {
                                SnackbarHelper.showCustomSnackbar(
                                  context: context,
                                  title: S.of(context).error,
                                  message: S.of(context).check_email_or_pass,
                                  contentType: ContentType.failure,
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomButton(
                title: S.of(context).logout,
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  context.go('/signInView');
                },
                width: double.infinity,
              ),
            ),
          ),
        );
      },
    );
  }
}
