import 'package:carousel_slider/carousel_slider.dart';
import 'package:ctware/views/Account.dart';
import 'package:ctware/views/Involce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Setting.dart';
import 'TestChart.dart';

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
  late final List<GlobalKey<NavigatorState>> navigatorKeys;
  late final List<GlobalKey> destinationKeys;
  late final List<AnimationController> destinationFaders;
  late final List<Widget> destinationViews;
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/bg_home.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom:
                      -150, // Adjust this value to control how much of the Card is outside
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Text(
                          'Xin chào, Nguyễn Khánh Duy',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        Divider(height: 1.0, color: Colors.black),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildMenuItem(
                                'assets/icons/ic_bill.png', 'Hóa đơn'),
                            _buildMenuItem('assets/icons/ic_notification.png',
                                'Thông báo'),
                            _buildMenuItem(
                                'assets/icons/ic_account.png', 'Tài khoản'),
                          ],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ], // Ensure that the overflow is visible
            ),
            SizedBox(
                height:
                    200), // Add extra space to prevent overlap with other content
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMenuItemIcon(context, Icons.receipt, 'Tra cứu Hóa đơn',
                    Colors.blueAccent, () {
                  // Action for 'Tra cứu Hóa đơn'
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => InvoiceListScreen(),
                      ));
                  print('Tra cứu Hóa đơn tapped');
                }),
                _buildMenuItemIcon(
                    context, Icons.receipt, 'Hợp đồng', Colors.yellowAccent,
                    () {
                  // Action for 'Hợp đồng'
                  print('Hợp đồng tapped');
                }),
                _buildMenuItemIcon(context, Icons.message, 'Gửi yêu cầu',
                    Colors.lightBlueAccent, () {
                  // Action for 'Gửi yêu cầu'
                  print('Gửi yêu cầu tapped');
                }),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => UserInfoScreen(),
                      ));

                  print('Địa điểm thanh toán tapped');
                }),
                _buildMenuItemIcon(
                    context, Icons.settings, 'Cài đặt', Colors.yellow, () {
                  // Action for 'Cài đặt'
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Setting(),
                  ));
                  print('Cài đặt tapped');
                }),
              ],
            ),
            SizedBox(height: 16),
            CarouselSlider(
              options: CarouselOptions(autoPlay: true, viewportFraction: 1),
              items: imgList
                  .map((item) => Container(
                        child: Center(
                            child: Image.asset(item,
                                fit: BoxFit.fill, width: 1000)),
                      ))
                  .toList(),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tin tức',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Tất cả >', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildNewsItem(),
                  _buildNewsItem(),
                  _buildNewsItem(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        indicatorColor: Colors.white70,
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: allDestinations.map<NavigationDestination>(
          (Destination destination) {
            bool isSelected =
                allDestinations[selectedIndex].index == destination.index;
            return NavigationDestination(
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    destination.iconPath,
                    color: isSelected ? destination.color : Colors.grey,
                    height: 20,
                  ),
                  Text(
                    destination.title,
                    style: TextStyle(
                      color: isSelected ? destination.color : Colors.grey,
                    ),
                  ),
                ],
              ),
              label: '',
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildMenuItem(String assetPath, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(assetPath),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(height: 8),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              child: Icon(icon, size: 30, color: Colors.white),
              backgroundColor: color,
            ),
            SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
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
      width: 150,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Image.asset('assets/icons/ic_logo.png', fit: BoxFit.cover),
          SizedBox(height: 8),
          Text('CAN THO WASCO', textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class Destination {
  const Destination(this.index, this.title, this.iconPath, this.color);

  final int index;
  final String title;
  final String iconPath;
  final Color color;
}
