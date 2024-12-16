import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loan_management/core/widget/custom_app_bar.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/feature/Auth/presentation/view/widget/custom_text_field.dart';
import 'package:loan_management/feature/settings/presentation/view_model/update_bloc/update_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constant/app_colors.dart';
import '../../../../../core/constant/app_theme.dart';
import '../../../../../core/widget/show_snack_bar.dart';
import '../../../../../generated/l10n.dart';

class UpdatePhoneView extends StatelessWidget {
  const UpdatePhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final phoneController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isLoading = false;
    return BlocProvider(
      create: (context) => UpdateBloc(),
      child: BlocConsumer<UpdateBloc, UpdateState>(
        listener: (context, state) {
          if (state is UpdatePhoneLoading) {
            isLoading = true;
          } else if (state is UpdatePhoneSuccess) {
            isLoading = false;
            showSnackBar(context, S.of(context).success);
            context.pop();
          } else if (state is UpdatePhoneFailure) {
            isLoading = false;
            showSnackBar(context, state.errMessage);
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
                            showSnackBar(context, S.of(context).value_empty);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
