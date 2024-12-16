import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loan_management/core/constant/app_styles.dart';
import 'package:loan_management/core/helper/AuthHelper.dart';
import 'package:loan_management/core/widget/custom_button.dart';
import 'package:loan_management/core/widget/custom_scaffold.dart';
import 'package:loan_management/feature/settings/presentation/view/widget/profile_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/widget/custom_app_bar.dart';
import '../../../../../generated/l10n.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(title: S.of(context).profile),
      body: FutureBuilder(
        future: AuthHelper().fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
                child: Text(
              S.of(context).no_data,
              style: AppStyles.textStyle20notBold,
            ));
          } else {
            final userData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  ProfileWidget(
                    title: "${S.of(context).Username}:",
                    subTitle: userData[0]["Username"],
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onTap: () {
                      context.push('/UpdateUsername');
                    },
                  ),
                  ProfileWidget(
                    title: "${S.of(context).email}:",
                    subTitle: userData[0]["email"],
                  ),
                  ProfileWidget(
                    title: "${S.of(context).phone}:",
                    subTitle: userData[0]["phone"],
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.grey,
                      size: 30,
                    ),
                    onTap: () {
                      context.push("/UpdatePhone");
                    },
                  ),
                  ProfileWidget(
                    title: "${S.of(context).role}:",
                    subTitle: userData[0]["role"],
                  ),
                  ProfileWidget(
                    title: "${S.of(context).created_at}:",
                    subTitle: dateTimeFormat(userData[0]["created_at"]),
                  ),
                ],
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
            await Supabase.instance.client.auth.signOut();
            context.go('/signInView');
          },
          width: double.infinity,
        ),
      ),
    );
  }
}

String dateTimeFormat(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formattedDate = DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
  return formattedDate;
}
