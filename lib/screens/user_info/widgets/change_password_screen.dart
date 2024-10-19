import 'package:ctware/configs/Colors.dart';
import 'package:ctware/services/cache_manage.dart';
import 'package:flutter/material.dart';

class UpdatePasswordScreen extends StatefulWidget {
  UpdatePasswordScreen({
    super.key,
  });

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  late TextEditingController _currentPassController;
  bool _isEditing = false;
  bool _isObscured = false;
  int _step = 1;

  @override
  void initState() {
    super.initState();
    _currentPassController = TextEditingController();
  }

  @override
  void dispose() {
    _currentPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Đổi mật khẩu',
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
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Vui lòng nhập mật khẩu cũ',
                style: TextStyle(
                    color: AppColors.txtPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _currentPassController,
                obscureText: _isObscured,
                onChanged: (val) => {
                  setState(() {
                    _isEditing = val.isEmpty ? false : true;
                  })
                },
                decoration: InputDecoration(
                    labelText: "Mật khẩu hiện tại",
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: AppColors.bgPrimary,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscured == false
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )),
              ),
              const SizedBox(height: 24),
              Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          _isEditing ? AppColors.bgPrimary : AppColors.bgGrey,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      if (_isEditing == false) return;

                      String currentPass = await CacheManage.getCurrenPass();
                      if (currentPass == _currentPassController.text) {
                        _step = 2;
                      }
                    },
                    child: const Text(
                      "Tiếp tục",
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
  }
}
