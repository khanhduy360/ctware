import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'container/Bottombar.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
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
        title: Text("Thông tin người dùng", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          UserInfoHeader(),
          SectionTitle(title: 'Quản lý tài khoản'),
          ListTile(
            title: Text('Quản lý Hóa đơn'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: Text('Đổi mật khẩu'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          ListTile(
            title: Text('Xác thực Email'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          SectionTitle(title: 'Hỗ trợ'),
          SupportRow(
            leftTitle: 'Email',
            leftSubtitle: '',
            rightTitle: 'ctncantho@gmail.com',
            rightSubtitle: '',
          ),
          SupportRow(
            leftTitle: 'Zalo',
            leftSubtitle: '',
            rightTitle: 'CANTHOWASSCO OA Page',
            rightSubtitle: '',
          ),
          SupportRow(
            leftTitle: 'Facebook',
            leftSubtitle: '',
            rightTitle: 'CANTHOWASSCO Fanpage',
            rightSubtitle: '',
          ),
          SectionTitle(title: 'Giới thiệu'),
          ListTile(
            title: Text('Về CTWCare'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Điều khoản sử dụng'),
            onTap: () {},
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTapped: _onItemTapped,
        allDestinations: allDestinations,
      ),
    );
  }
}

class UserInfoHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                child: Text(
                  'KD',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Khánh Duy',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '0355671551',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  Text(
                    'Chưa xác thực Email',
                    style: TextStyle(fontSize: 14, color: Colors.orange),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.grey[200],
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SupportRow extends StatelessWidget {
  final String leftTitle;
  final String leftSubtitle;
  final String rightTitle;
  final String rightSubtitle;

  SupportRow({
    required this.leftTitle,
    required this.leftSubtitle,
    required this.rightTitle,
    required this.rightSubtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(leftTitle),
              subtitle: Text(leftSubtitle),
              onTap: () {},
            ),
          ),
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(rightTitle),
              subtitle: Text(rightSubtitle),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}