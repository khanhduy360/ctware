import 'package:ctware/views_use_demo/OTPRegister.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureTextPass = true;
  bool _obscureTextPassConfirm = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureTextPass = !_obscureTextPass;
    });
  }

  void _togglePasswordConfirmVisibility() {
    setState(() {
      _obscureTextPassConfirm = !_obscureTextPassConfirm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/LoginScreen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                title: Text('Đăng ký tài khoản'),
                backgroundColor: Colors.transparent, // Làm AppBar trong suốt
                elevation: 0, // Xóa bóng của AppBar
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.blue),
                  onPressed: () {
                    Navigator.pop(context); // Quay lại màn hình trước đó
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Tài khoản (*)',
                          labelStyle: TextStyle(fontSize: 18),
                          prefixIcon: Icon(Icons.account_circle, color: Colors.blue),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Họ và tên',
                          labelStyle: TextStyle(fontSize: 18),
                          prefixIcon: Icon(Icons.person, color: Colors.blue, size: 30),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Điện thoại',
                          labelStyle: TextStyle(fontSize: 18),
                          prefixIcon: Icon(Icons.phone, color: Colors.blue, size: 30),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(fontSize: 18),
                          prefixIcon: Icon(Icons.email, color: Colors.blue, size: 30),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        obscureText: _obscureTextPass,
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu (*)',
                          labelStyle: TextStyle(fontSize: 18),
                          prefixIcon: Icon(Icons.lock, color: Colors.blue),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureTextPass ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        obscureText: _obscureTextPassConfirm,
                        decoration: InputDecoration(
                          labelText: 'Xác nhận mật khẩu (*)',
                          labelStyle: TextStyle(fontSize: 18),
                          prefixIcon: Icon(Icons.lock, color: Colors.blue),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureTextPassConfirm ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: _togglePasswordConfirmVisibility,
                          ),
                        ),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => OTPRegister()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          elevation: 0,
                          minimumSize: Size(double.infinity, 50),
                          side: BorderSide(color: Colors.blue, width: 2),
                        ),
                        child: Text(
                          'Đăng ký',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
