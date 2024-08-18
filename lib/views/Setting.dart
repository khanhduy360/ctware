import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'container/Bottombar.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool _switchValue = false; // Initial switch value
  String mess = "Truned Off"; // Initial message
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Trang chủ', 'assets/icons/ic_home.png', Colors.teal),
    Destination(1, 'Tin tức', 'assets/icons/ic_news.png', Colors.cyan),
    Destination(2, 'Thông báo', 'assets/icons/ic_notify.png', Colors.orange),
    Destination(3, 'Tài khoản', 'assets/icons/ic_user.png', Colors.blue),
  ];
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  // Function to change the message based on the switch value
  void changeMessage() {
    setState(() {
      if (_switchValue) {
        mess = "Truned On";
      } else {
        mess = "Truned Off";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cài đặt", style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(
          //         'assets/images/LoginScreen.png'), // Đường dẫn đến hình nền
          //     fit: BoxFit.fitHeight, // Hiển thị hình nền theo tỷ lệ
          //   ),
          // ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: [
                SwitchListTile(
                  title: Text('Thông báo'), // The title of the ListTile
                  // subtitle:
                  //     Text('Ấn vào để bật / tắt'), // Optional subtitle
                  secondary:
                      Icon(Icons.lightbulb_outline), // Optional leading icon
                  value: _switchValue, // The current value of the switch
                  onChanged: (newValue) {
                    // Callback when the switch is toggled
                    setState(() {
                      _switchValue = newValue;
                      changeMessage(); // Call the function to update the message
                    });
                  },
                  activeColor: Colors.blue,
                  inactiveTrackColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: selectedIndex,
          onItemTapped: _onItemTapped,
          allDestinations: allDestinations,
        ),
    )


    ;
  }
}
