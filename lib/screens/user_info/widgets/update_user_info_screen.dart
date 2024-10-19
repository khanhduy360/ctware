import 'package:ctware/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:ctware/configs/Colors.dart';
import 'package:provider/provider.dart';

class UpdateUserInfoScreen extends StatefulWidget {
  const UpdateUserInfoScreen({super.key});

  @override
  _UpdateUserInfoScreenState createState() => _UpdateUserInfoScreenState();
}

class _UpdateUserInfoScreenState extends State<UpdateUserInfoScreen> {
  bool isEditing = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    fullNameController.text = userProvider.getFullName() ?? "";
    addressController.text = userProvider.getAddress() ?? "";
    displayNameController.text = userProvider.getDisplayName() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder:
          (BuildContext context, UserProvider userProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Thông tin người dùng",
              style: TextStyle(color: AppColors.txtWhite),
            ),
            backgroundColor: AppColors.bgPrimary,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.txtWhite,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isEditing ? Icons.save : Icons.edit,
                  color: AppColors.txtWhite,
                ),
                onPressed: () {
                  setState(() {
                    if (isEditing) {
                      userProvider.setFullName(fullNameController.text);
                      userProvider.setAddress(addressController.text);
                      userProvider.setDisplayName(displayNameController.text);

                      userProvider.updateUser(context);
                    }
                    isEditing = !isEditing;
                  });
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserInfoRow(
                      "Tên tài khoản", userProvider.getUsername() ?? ""),
                  _buildEditableRow("Họ và tên", fullNameController),
                  _buildEditableRow("Địa chỉ", addressController),
                  _buildEditableRow("Tên hiển thị", displayNameController),
                  _buildUserInfoRow("Email", userProvider.getEmail() ?? ""),
                  _buildUserInfoRow("Điện thoại", userProvider.getTel() ?? ""),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.bgDanger,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () async {},
                        child: const Text(
                          "Đăng xuất",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableRow(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          isEditing
              ? TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Nhập $label',
                  ),
                )
              : Text(
                  controller.text,
                  style: const TextStyle(fontSize: 16),
                ),
        ],
      ),
    );
  }
}
