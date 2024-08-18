import 'package:carousel_slider/carousel_slider.dart';
import 'package:ctware/configs/extendtion/box_extendtion.dart';
import 'package:ctware/configs/responsive.dart';
import 'package:ctware/views/Account.dart';
import 'package:ctware/views/Involce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Setting.dart';
import 'TestChart.dart';
import 'container/Bottombar.dart';
import 'chart/test_chart1.dart';

final List<String> imgList = [
  'assets/images/slider1.png',
  'assets/images/slider2.png'
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Widget mainCard(context) {
    return Container(
      height: 170,
      decoration: BoxStyle.fromBoxDecoration(radius: 15),
      child: Column(
        children: [
          SizedBox(height: 30),
          Text(
            'Xin chào, Nguyễn Khánh Duy',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          Divider(height: 1.0, color: Colors.black),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMenuItem('assets/icons/ic_bill.png', 'Hóa đơn'),
              _buildMenuItem('assets/icons/ic_notification.png', 'Thông báo'),
              _buildMenuItem('assets/icons/ic_account.png', 'Tài khoản'),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget mainBody(context) {
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenuItemIcon(
                  context, Icons.receipt, 'Tra cứu Hóa đơn', Colors.blueAccent,
                  () {
                // Action for 'Tra cứu Hóa đơn'
                 Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => InvoiceListScreen()),
                      );
                print('Tra cứu Hóa đơn tapped');
              }),
              _buildMenuItemIcon(
                  context, Icons.receipt, 'Hợp đồng', Colors.yellowAccent, () {
                print('Hợp đồng tapped');
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Testchart1(),
                ));
              }),
              _buildMenuItemIcon(
                  context, Icons.message, 'Gửi yêu cầu', Colors.lightBlueAccent,
                  () {
                // Action for 'Gửi yêu cầu'
                print('Gửi yêu cầu tapped');
              }),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenuItemIcon(context, Icons.dangerous_outlined,
                  'Thông báo xì bể', Colors.redAccent, () {
                // Action for 'Thông báo xì bể'
                print('Thông báo xì bể tapped');

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarLineChart()),
                );
              }),
              _buildMenuItemIcon(context, Icons.map_outlined,
                  'Địa điểm thanh toán', Colors.orange, () {
                // Action for 'Địa điểm thanh toán'
                // Action for 'Cài đặt'
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserInfoScreen()),
                      );

                print('Địa điểm thanh toán tapped');
              }),
              _buildMenuItemIcon(
                  context, Icons.settings, 'Cài đặt', Colors.yellow, () {
                // Action for 'Cài đặt'
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Setting()),
                  );
                print('Cài đặt tapped');
              }),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 15),
          color: Colors.black,
          height: 100,
          width: MediaQuery.of(context).size.width,
          child: CarouselSlider(
            options: CarouselOptions(autoPlay: true, viewportFraction: 1),
            items: imgList
                .map((item) => Container(
                      child: Image.asset(
                        item,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ))
                .toList(),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tin tức',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Tất cả >', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        Container(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildNewsItem(),
              _buildNewsItem(),
              _buildNewsItem(),
            ],
          ),
        ),
        const SizedBox(height: 20)
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light),
            expandedHeight: Responsive.height(35, context),
            backgroundColor: Colors.white,
            elevation: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: Responsive.width(100, context),
                      child: Image(
                        image: AssetImage('assets/icons/bg_home.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                      height: Responsive.height(10, context),
                      color: Colors.white)
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(180),
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.all(20),
                child: mainCard(context),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: mainBody(context),
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

  Widget _buildMenuItem(String assetPath, String title) {
    return Column(
      children: [
        Container(
          height: 40,
          width: 40,
          child: Image(
            image: AssetImage(assetPath),
          ),
        ),
        SizedBox(height: 5),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildMenuItemIcon(BuildContext context, IconData icon, String title,
      Color color, VoidCallback onPressed) {
    return Container(
      width: (MediaQuery.of(context).size.width - 32) /
          3, // Ensure three items fit within the screen width with padding
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: color),
              height: 60,
              width: 60,
              child: Icon(icon, size: 30, color: Colors.white),
            ),
            SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
              overflow:
                  TextOverflow.visible, // Allows text to wrap to the next line
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsItem() {
    return Container(
      width: 200,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('assets/images/news1.jpg'),
                    fit: BoxFit.fill)),
            height: 150,
          ),
          SizedBox(height: 8),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Text('Kết quả thử nghiệm nước tháng 07/2024'),
          ),
        ],
      ),
    );
  }
}
