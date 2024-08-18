import 'package:flutter/material.dart';

import 'container/Bottombar.dart';

class AddInvoiceScreen extends StatefulWidget {
  @override
  _AddInvoiceScreenState createState() => _AddInvoiceScreenState();
}

class _AddInvoiceScreenState extends State<AddInvoiceScreen> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Trang chủ', 'assets/icons/ic_home.png', Colors.teal),
    Destination(1, 'Tin tức', 'assets/icons/ic_news.png', Colors.cyan),
    Destination(2, 'Thông báo', 'assets/icons/ic_notify.png', Colors.orange),
    Destination(3, 'Tài khoản', 'assets/icons/ic_user.png', Colors.blue),
  ];
  int selectedIndex = 0;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Hóa đơn liên kết', style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
            // Handle back button press
          },
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Nhập IDKH',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nhập Mã xác nhận',
                border: OutlineInputBorder(),
                helperText: '(*) Mã xác nhận trên Giấy báo và Biên nhận',
              ),
            ),
            SizedBox(height: 32),

            SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Handle link press
              },
              child: Text(
                'Hướng dẫn liên kết',
                style: TextStyle(color: Colors.blue),
              ),
            ),
      Spacer(), // Đẩy các widget phía trên lên trên cùng
      ElevatedButton(
        onPressed: () {
          // Handle button press
        },
        child: Text('Thêm Hóa đơn', style: TextStyle(color: Colors.blue, fontSize: 20), ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 48), // Make button full width
        ),)
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTapped: _onItemTapped,
        allDestinations: allDestinations,
      ),
    );
  }
}