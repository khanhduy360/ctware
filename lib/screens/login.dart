import 'dart:io';

import 'package:ctware/configs/utilities.dart';
import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/screens/home.dart';
import 'package:ctware/services/auth_service.dart';
import 'package:ctware/services/cache_manage.dart';
import 'package:ctware/theme/dialog.dart';
import 'package:ctware/views_use_demo/Register.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  late String _account = '', _password = '';
  late bool _isLoginProcess = false;
  late TextEditingController inputAccountController;
  // Local auth
  final LocalAuthentication auth = LocalAuthentication();
  List<BiometricType> availableBiometrics = [];
  bool canCheckBiometrics = false;

  Future<void> _checkBiometrics() async {
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      availableBiometrics = <BiometricType>[];
    }
  }

  initView() async {
    inputAccountController = TextEditingController();
    String? accountCache = await CacheManage.loadKeywordLogin();
    await _checkBiometrics().then((onValue) {
      setState(() {
        if (accountCache != null) {
          _account = accountCache;
          inputAccountController.text = _account;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    rootContext = context;
    initView();
  }

  @override
  void dispose() {
    super.dispose();
    inputAccountController.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _loginProcess() async {
    final formState = _formKey.currentState;
    final authService = AuthService(context: context);
    if (formState != null && formState.validate()) {
      formState.save();
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await authService
          .loginApi(account: _account, password: _password)
          .then((value) {
        if (value != null) {
          userProvider.setUser(value);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Home(),
          ));
        }
      });
    }
    setState(() {
      _isLoginProcess = false;
    });
  }

  _loginProcessWithLocalAuth() async {
    final authService = AuthService(context: context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final setting = await CacheManage.getSetting();
    if (setting == null || !setting['localAuth']) {
      ShowingDialog.errorDialog(context,
          errMes:
              'Vui lòng đăng nhập bằng mật khẩu và vào Cài đặt để bật Xác thực bằng khuôn mặt / vân tay.',
          title: 'Thông báo');
      return;
    }
    final isAuth = await auth.authenticate(
        localizedReason: 'Thực hiện xác thực',
        options: const AuthenticationOptions(biometricOnly: false));
    if (isAuth) {
      String currentPass = await CacheManage.getCurrentPass();
      final status = await authService.loginApi(
          account: _account, password: currentPass, localAuth: true);
      if (status != null) {
        userProvider.setUser(status);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Home(),
        ));
      } else {
        // ignore: use_build_context_synchronously
        ShowingDialog.errorDialog(context,
            errMes:
                'Không thể đăng nhập bằng khuôn mặt / vân tay.\n Vui lòng đăng nhập bằng mật khẩu.',
            title: 'Thông báo');
      }
    }
  }

  Widget getAuthIcon() {
    if (!canCheckBiometrics) {
      return const SizedBox();
    }
    IconData? iconData;
    // Default icon auth for platform
    if (Platform.isAndroid) {
      iconData = Icons.fingerprint;
    } else if (Platform.isIOS) {
      iconData = Iconsax.emoji_happy;
    }
    if (availableBiometrics.contains(BiometricType.face)) {
      iconData = Iconsax.emoji_happy;
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      iconData = Icons.fingerprint;
    }
    return InkWell(
      onTap: () async {
        await _loginProcessWithLocalAuth();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue)),
        height: 50,
        width: 50,
        margin: const EdgeInsets.only(left: 5),
        child: Icon(iconData, size: 40, color: Colors.blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/LoginScreen.png'), // Đường dẫn đến hình nền
              fit: BoxFit.fitHeight, // Hiển thị hình nền theo tỷ lệ
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.fill,
                      height: 120,
                      width: 120,
                    ),
                    Column(
                      children: [
                        Text(
                          'Chào mừng đến với',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pacifico',
                              color: Colors.blue),
                        ),
                        Text(
                          'CTWARE',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pacifico',
                              color: Colors.blue),
                        ),
                        Text(
                          'Ứng dụng cho khách hàng',
                          style: TextStyle(
                              fontSize: 15, fontFamily: 'ProductSans'),
                        ),
                        Text(
                          'sử dụng nước',
                          style: TextStyle(
                              fontSize: 15, fontFamily: 'ProductSans'),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: inputAccountController,
                          decoration: const InputDecoration(
                            labelText: 'Tài khoản/Email/Số điện thoại',
                            labelStyle: TextStyle(fontSize: 18),
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                          style: const TextStyle(fontSize: 20),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập tài khoản, email, số điện thoại.';
                            }
                            return null;
                          },
                          onSaved: (value) => _account = value ?? '',
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            labelStyle: const TextStyle(fontSize: 18),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.blue,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          style: const TextStyle(fontSize: 20),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu.';
                            }
                            return null;
                          },
                          onSaved: (value) => _password = value ?? '',
                        ),
                      ],
                    )),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Quên mật khẩu?',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_isLoginProcess) {
                            return;
                          }
                          setState(() {
                            _isLoginProcess = true;
                          });
                          _loginProcess();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor:
                              Colors.blue, // Màu sắc giống với hình
                          minimumSize: const Size(
                              double.infinity, 50), // Kích thước giống với hình
                        ),
                        child: _isLoginProcess
                            ? const SizedBox(
                                height: 25,
                                width: 25,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 4,
                                  ),
                                ),
                              )
                            : const Text(
                                'Đăng nhập',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                      ),
                    ),
                    getAuthIcon()
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Home(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor:
                        Colors.transparent, // Đặt màu nền trong suốt
                    elevation: 0, // Loại bỏ hiệu ứng đổ bóng
                    // Màu sắc giống với hình
                    minimumSize: const Size(
                        double.infinity, 50), // Kích thước giống với hình
                    side: const BorderSide(
                        color: Colors.blue,
                        width: 2), // Màu viền giống với hình
                  ),
                  child: const Text(
                    'Đăng nhập bằng Số điện thoại',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor:
                        Colors.transparent, // Đặt màu nền trong suốt
                    elevation: 0, // Loại bỏ hiệu ứng đổ bóng
                    // Màu sắc giống với hình
                    minimumSize: const Size(
                        double.infinity, 50), // Kích thước giống với hình
                    side: const BorderSide(
                        color: Colors.blue,
                        width: 2), // Màu viền giống với hình
                  ),
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
