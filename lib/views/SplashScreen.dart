import 'dart:async';

import 'package:ctware/views/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Thời gian chờ là 2 giây trước khi chuyển sang trang chính
    Timer(Duration(seconds: 2), () {
      // Chuyển sang màn hình chính
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Login(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo hoặc hình ảnh splash screen
            Image.asset('assets/icons/ic_launcher.png'), // Đảm bảo bạn đã thêm hình ảnh vào thư mục assets
            SizedBox(height: 20),
            // Văn bản hoặc các thành phần khác

          ],
        ),
      ),
    );
  }
}

