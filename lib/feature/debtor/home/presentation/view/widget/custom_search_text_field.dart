import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import '../../../../../../generated/l10n.dart';
import '../../view_model/cubit/installment_cubit.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final installmentCubit = BlocProvider.of<InstallmentCubit>(context);
    return TextField(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      onChanged: (value) {
        installmentCubit.searchInstallments(value);
      },
      decoration: InputDecoration(
        hintText: S.of(context).Search_for_installment,
        hintStyle: AppStyles.textStyle18gray,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
          size: 25,
        ),
      ),
    );
  }
}
