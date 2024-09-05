import 'dart:async';

import 'package:ctware/screens/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Thời gian chờ là 2 giây trước khi chuyển sang trang chính
    Timer(const Duration(seconds: 2), () {
      // Chuyển sang màn hình chính
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Login(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/LoginScreen.png'),
            fit: BoxFit.fitHeight,),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo hoặc hình ảnh splash screen
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.asset('assets/images/logo.png')
                  ), // Đảm bảo bạn đã thêm hình ảnh vào thư mục assets
                  const SizedBox(height: 20),
                  // Văn bản hoặc các thành phần khác
                ],
              ),
            ),
          ),
      ),
    );
  }
}

