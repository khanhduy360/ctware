import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvoiceListScreen extends StatefulWidget {
  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách Hóa đơn'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Handle add action
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          InvoiceCard(
            idkh: '65642',
            sodanbo: '877026A',
            name: 'NGUYỄN VĂN KHỞI',
            address: 'SỐ 10-U, ĐƯỜNG SỐ 10, KDC CTY8, P. HƯNG THẠNH. - KDC CTY 8',
          ),
          // Add more InvoiceCard widgets here
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Tin tức',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Tài khoản',
          ),
        ],
        currentIndex: 0, // Set the current index
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle bottom navigation bar tap
        },
      ),
    );
  }
}

class InvoiceCard extends StatelessWidget {
  final String idkh;
  final String sodanbo;
  final String name;
  final String address;

  InvoiceCard({required this.idkh, required this.sodanbo, required this.name, required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text('IDKH: $idkh'),
            Text('Số danh bộ: $sodanbo'),
            Text('Địa chỉ: $address'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle ghi chỉ số online action
                  },
                  icon: Icon(Icons.speed),
                  label: Text('Ghi chỉ số Online'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle delete action
                  },
                  icon: Icon(Icons.delete),
                  label: Text('Xóa'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}