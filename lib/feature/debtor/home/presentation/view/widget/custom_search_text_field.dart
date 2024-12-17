import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/helper/AuthHelper.dart';
import 'package:loan_management/feature/creditor/home/presentation/view_model/cubit/creditor_installment_cubit.dart';
import '../../../../../../generated/l10n.dart';
import '../../view_model/cubit/debtor_installment_cubit.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final debtorInstallmentCubit =
        BlocProvider.of<DebtorInstallmentCubit>(context);
    final creditorInstallmentCubit =
        BlocProvider.of<CreditorInstallmentCubit>(context);

    return TextField(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      onChanged: (value) async {
        bool isDebtor = await AuthHelper().isDebtor();
        isDebtor
            ? debtorInstallmentCubit.searchInstallments(value)
            : creditorInstallmentCubit.searchInstallments(value);
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
