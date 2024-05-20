import 'package:ctware/views/LoginByZalo.dart';
import 'package:ctware/views/Register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatelessWidget {
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

              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(image: AssetImage('assets/images/logo.png'), fit: BoxFit.fill, height: 150, width: 150,),

                    SizedBox(width: 30),
                    Column(
                      children: [
                        Text(
                          'Chào mừng đến với',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico',
                              color: Colors.blue
                          ),
                        ),
                        Text(
                          'CTWARE',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pacifico',
                            color: Colors.blue
                          ),
                        ),
                        Text(
                          'Ứng dụng cho khách hàng',
                          style: TextStyle(
                            fontSize: 15,

                              fontFamily: 'ProductSans'
                          ),
                        ),
                        Text(
                          'sử dụng nước',
                          style: TextStyle(
                              fontSize: 15,

                              fontFamily: 'ProductSans'
                          ),
                        ),
                      ],
                    )

                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Tài khoản/Email',
                    prefixIcon: Icon(Icons.account_circle, color: Colors.blue,),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    prefixIcon: Icon(Icons.lock,  color: Colors.blue,),
                    suffixIcon: Icon(Icons.visibility),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: Text('Quên mật khẩu?'),
                ),
                SizedBox(height: 225),
                //Container(child: SizedBox(height: 150,), alignment: Alignment.topCenter,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => LoginByZalo(),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Màu sắc giống với hình
                    minimumSize:
                        Size(double.infinity, 50), // Kích thước giống với hình
                  ),
                  child: Text('Đăng nhập', style: TextStyle(
                    color: Colors.white, fontSize: 20
                  ),),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Register()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // Đặt màu nền trong suốt
                    elevation: 0, // Loại bỏ hiệu ứng đổ bóng
                    // Màu sắc giống với hình
                    minimumSize:
                    Size(double.infinity, 50), // Kích thước giống với hình
                    side: BorderSide(color: Colors.blue, width: 2), // Màu viền giống với hình
                  ),
                  child: Text('Đăng ký', style: TextStyle(
                      color: Colors.blue, fontSize: 20
                  ),),
                ),
              ],
            ),
          ),
        ));
  }
}
