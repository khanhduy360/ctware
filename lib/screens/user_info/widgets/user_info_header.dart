import 'package:ctware/configs/Colors.dart';
import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/screens/user_info/widgets/update_user_info_screen.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UpdateUserInfoScreen()),
        );
      },
      child: Container(
        decoration: BoxStyle.fromBoxDecoration(),
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _UserInfoTile(),
          ],
        ),
      ),
    );
  }
}

class _UserInfoTile extends StatelessWidget {
  const _UserInfoTile();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.txtPrimary,
      ),
      title: Consumer<UserProvider>(
        builder:
            (BuildContext context, UserProvider userProvider, Widget? child) {
          return Row(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color.fromARGB(255, 132, 177, 255)),
                child: Center(
                  child: Text(
                    getFirstChar(userProvider.getDisplayName() ?? userProvider.getFullName()),
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProvider.getDisplayName() ?? userProvider.getFullName() ?? "User",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userProvider.getTel() ?? "Tel",
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Text(
                    userProvider.isEmailVerified() &&
                            userProvider.getEmail() != null
                        ? userProvider.getEmail()!
                        : 'Chưa xác thực Email',
                    style: TextStyle(fontSize: 14, color: userProvider.isEmailVerified() ? AppColors.txtPrimary : AppColors.txtDanger),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

String getFirstChar(String? firstName) {
  if (firstName == null) {
    return "U";
  }
  return firstName[0];
}
