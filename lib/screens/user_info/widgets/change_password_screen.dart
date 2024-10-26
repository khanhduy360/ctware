import 'package:ctware/configs/colors.dart';
import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/services/cache_manage.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({
    super.key,
  });

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  late TextEditingController _currentPassController;
  late TextEditingController _newPassController;
  late TextEditingController _confirmPassController;
  late bool _isEditing;
  late bool _isObscuredCurrPass;
  late bool _isObscuredNewPass;
  late bool _isObscuredConfirmPass;
  late int _step = 1;

  String? _newPassErr;
  String? _confirmPassErr;
  String? _currPassErr;

  @override
  void initState() {
    super.initState();
    _currentPassController = TextEditingController();
    _newPassController = TextEditingController();
    _confirmPassController = TextEditingController();
    _isEditing = false;
    _isObscuredCurrPass = true;
    _isObscuredNewPass = true;
    _isObscuredConfirmPass = true;
    _step = 1;
    _newPassErr = null;
    _confirmPassErr = null;
    _currPassErr = null;
  }

  @override
  void dispose() {
    _currentPassController.dispose();
    super.dispose();
  }

  void resetInputFields() {
    _currentPassController.text = "";
    _newPassController.text = "";
    _confirmPassController.text = "";
  }

  String? _validateInputField(String val, String emptyErr) {
    if (val.isEmpty) {
      return "Vui lòng nhập $emptyErr";
    }

    if (val.length < 6) {
      return "Mật khẩu phải từ 6 ký tự";
    }
    return null;
  }

  void handleContinuePressed() async {
    if (_isEditing == false) return;
    _currPassErr = null;
    String currentPass = await CacheManage.getCurrenPass();
    setState(() {
      if (currentPass == _currentPassController.text) {
        _step = 2;
      } else {
        _currPassErr = "Mật khẩu không chính xác";
      }
    });
  }

  void handleChangePassPressed() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (_newPassController.text.isEmpty ||
        _confirmPassController.text.isEmpty) {
      return;
    }
    setState(() {
      _newPassErr =
          _validateInputField(_newPassController.text, "mật khẩu mới");
      _confirmPassErr =
          _validateInputField(_confirmPassController.text, "lại mật khẩu");

      if (_newPassErr != null || _confirmPassErr != null) {
        return;
      }
      if (_newPassController.text != _confirmPassController.text) {
        _confirmPassErr = "Nhập lại không trùng khớp";
        return;
      }

      userProvider
          .changePassword(context,
              currPass: _currentPassController.text,
              newPass: _newPassController.text)
          .then((res) {
        if (res) {
          resetInputFields();
          setState(() {
            _step = 3;
          });
        }
      });
    });
  }

  Widget _buildCurrentPasswordField() {
    return Column(
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
          obscureText: _isObscuredCurrPass,
          onChanged: (val) => {
            setState(() {
              _isEditing = val.isEmpty ? false : true;
            })
          },
          decoration: InputDecoration(
              labelText: "Mật khẩu hiện tại",
              errorText: _currPassErr,
              prefixIcon: const Icon(
                Icons.lock,
                color: AppColors.bgPrimary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _isObscuredCurrPass == false
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isObscuredCurrPass = !_isObscuredCurrPass;
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
              onPressed: handleContinuePressed,
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
    );
  }

  Widget _buildNewPasswordFields() {
    return Consumer<UserProvider>(
      builder:
          (BuildContext context, UserProvider userProvider, Widget? child) {
        return Column(
          children: [
            const Text(
              'Nhập mật khẩu mới',
              style: TextStyle(
                  color: AppColors.txtPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _newPassController,
              obscureText: _isObscuredNewPass,
              onChanged: (val) => {
                setState(() {
                  _isEditing = val.isEmpty ? false : true;
                })
              },
              decoration: InputDecoration(
                  labelText: "Mật khẩu mới",
                  errorText: _newPassErr,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColors.bgPrimary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscuredNewPass == false
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscuredNewPass = !_isObscuredNewPass;
                      });
                    },
                  )),
            ),
            const SizedBox(height: 30),
            const Text(
              'Nhập lại mật khẩu mới',
              style: TextStyle(
                  color: AppColors.txtPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _confirmPassController,
              obscureText: _isObscuredConfirmPass,
              onChanged: (val) => {
                setState(() {
                  _isEditing = val.isEmpty ? false : true;
                })
              },
              decoration: InputDecoration(
                  labelText: "Nhập lại mật khẩu mới",
                  errorText: _confirmPassErr,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: AppColors.bgPrimary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscuredConfirmPass == false
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscuredConfirmPass = !_isObscuredConfirmPass;
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
                    backgroundColor: _newPassController.text.isEmpty ||
                            _confirmPassController.text.isEmpty
                        ? AppColors.bgGrey
                        : AppColors.bgPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: handleChangePassPressed,
                  child: const Text(
                    "Đổi mật khẩu",
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
    );
  }

  Widget _buildCompletedChange() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: _step == 3
              ? Lottie.asset(
                  'assets/lottie/checkmark_animation.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                )
              : Container(),
        ),
        const SizedBox(height: 20),
        const Text(
          'Đổi mật khẩu thành công.',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.bgPrimary),
        ),
        const SizedBox(height: 10),
        const Text(
          'Hãy sử dụng mật khẩu mới cho lần đăng nhập tiếp theo.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const Spacer(),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: AppColors.bgPrimary,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Hoàn thành',
              style: TextStyle(fontSize: 18, color: AppColors.bgWhite),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
      context: context,
      title: 'Đổi mật khẩu',
      backAction: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(
          builder: (context) {
            switch (_step) {
              case 2:
                return _buildNewPasswordFields();
              case 3:
                return _buildCompletedChange();
              default:
                return _buildCurrentPasswordField();
            }
          },
        ),
      ),
    );
  }
}
