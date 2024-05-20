import 'package:ctware/views/Register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'Chart.dart';

class LoginByZalo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Chào mừng tới với CTWCARE'),
      // ),
        resizeToAvoidBottomInset: false,
        body: Container(

          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/LoginScreen.png'), // Đường dẫn đến hình nền
              fit: BoxFit.fitHeight, // Hiển thị hình nền theo tỷ lệ
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Màu sắc giống với hình
                    minimumSize:
                    Size(double.infinity, 50), // Kích thước giống với hình
                  ),
                  child: Text('Đăng nhập bằng Zalo', style: TextStyle(
                      color: Colors.white, fontSize: 20
                  ),),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => BarChartSample4(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Đặt màu nền trong suốt
                    elevation: 0, // Loại bỏ hiệu ứng đổ bóng
                    // Màu sắc giống với hình
                    minimumSize:
                    Size(double.infinity, 50), // Kích thước giống với hình
                    side: BorderSide(color: Colors.blue, width: 2), // Màu viền giống với hình
                  ),
                  child: Text('Đăng nhập bằng SMS', style: TextStyle(
                      color: Colors.blue, fontSize: 20
                  ),),
                ),
              ],
            ),
          ),
        ));
  }
}
