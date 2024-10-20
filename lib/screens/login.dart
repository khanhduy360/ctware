import 'package:ctware/configs/utilities.dart';
import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/screens/home.dart';
import 'package:ctware/services/auth_service.dart';
import 'package:ctware/views_use_demo/Register.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    rootContext = context;
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
                ElevatedButton(
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
                    backgroundColor: Colors.blue, // Màu sắc giống với hình
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
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Home(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
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
