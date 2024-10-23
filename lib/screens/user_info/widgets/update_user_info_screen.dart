import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/screens/login.dart';
import 'package:ctware/services/cache_manage.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:ctware/configs/Colors.dart';
import 'package:provider/provider.dart';

class UpdateUserInfoScreen extends StatefulWidget {
  const UpdateUserInfoScreen({super.key});

  @override
  _UpdateUserInfoScreenState createState() => _UpdateUserInfoScreenState();
}

class _UpdateUserInfoScreenState extends State<UpdateUserInfoScreen> {
  bool _isEditing = false;
  String? _fullNameErr;
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
    _fullNameErr = null;
  }

  void handleSavePressed() {
    setState(() {
      _fullNameErr = null;

      if (_isEditing) {
        if (fullNameController.text.isEmpty) {
          _fullNameErr = "Vui lòng nhập họ và tên";
          return;
        }
        final userProvider = Provider.of<UserProvider>(context, listen: false);

        userProvider.setFullName(fullNameController.text);
        userProvider.setAddress(addressController.text);
        userProvider.setDisplayName(displayNameController.text);
        userProvider.updateUser(context);
      }
      _isEditing = !_isEditing;
    });
  }

  void _logout(BuildContext context) async {
    await CacheManage.removeToken();
    // ignore: use_build_context_synchronously
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const Login();
        },
      ),
      (_) => false,
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
          _isEditing
              ? TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Nhập $label',
                    errorText: label.toUpperCase().contains("HỌ VÀ TÊN") == true
                        ? _fullNameErr
                        : null,
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

  Widget _buildUserInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: _isEditing ? AppColors.txtMuted : null,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: _isEditing ? AppColors.txtMuted : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
      context: context,
      title: "Thông tin người dùng",
      backAction: true,
      actions: [
        IconButton(
          icon: Icon(
            _isEditing ? Icons.save : Icons.edit,
            color: AppColors.txtWhite,
          ),
          onPressed: handleSavePressed,
        ),
      ],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<UserProvider>(
            builder: (BuildContext context, UserProvider userProvider,
                Widget? child) {
              return Column(
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
                        onPressed: () {
                          _logout(context);
                        },
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
              );
            },
          ),
        ),
      ),
    );
  }
}
