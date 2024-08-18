import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddInvolce.dart';
import 'container/Bottombar.dart';

class InvoiceLookUp extends StatefulWidget {
  @override
  State<InvoiceLookUp> createState() => _InvoiceLookUpState();
}

class _InvoiceLookUpState extends State<InvoiceLookUp> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tra cứu hóa đơn', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddInvoiceScreen()),
              );
              // Handle add action
            },
          ),
        ],
      ),
      body: Container(

        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: [
            InvoiceCard(
              idkh: '65642',
              sodanbo: '877026A',
              name: 'NGUYỄN VĂN A',
              address: 'SỐ 10-U, ĐƯỜNG SỐ 10, KDC CTY8, P. HƯNG THẠNH. - KDC CTY 8',
            ),
            InvoiceCard(
              idkh: '65642',
              sodanbo: '877026A',
              name: 'NGUYỄN VĂN A',
              address: 'SỐ 10-U, ĐƯỜNG SỐ 10, KDC CTY8, P. HƯNG THẠNH. - KDC CTY 8',
            ),
            // Add more InvoiceCard widgets here
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

class InvoiceCard extends StatelessWidget {
  final String idkh;
  final String sodanbo;
  final String name;
  final String address;

  InvoiceCard({required this.idkh, required this.sodanbo, required this.name, required this.address});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
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
                  icon: Icon(Icons.speed, color: Colors.blue,),
                  label: Text('Ghi chỉ số Online', style: TextStyle(color: Colors.blue),),
                ),
                ElevatedButton.icon(
                  onPressed: () {

                    // Handle delete action
                  },
                  icon: Icon(Icons.delete, color: Colors.red,),
                  label: Text('Xóa', style: TextStyle(color: Colors.red),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
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