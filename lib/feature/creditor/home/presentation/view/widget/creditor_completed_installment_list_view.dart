import 'package:flutter/material.dart';
import '../../../../../../core/widget/animated_list_view.dart';

class CreditorCompletedInstallmentListView extends StatelessWidget {
  const CreditorCompletedInstallmentListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return AnimatedInstallmentItem(
          delay: index * 200,
          installment: "Ash",
          onTap: () {
            // context.push(
            //   "/details_view",
            //   extra: displayedInstallments[index],
            // );
          },
        );
      },
    );
  }
}
