import 'package:carousel_slider/carousel_slider.dart';
import 'package:ctware/model/advertise_slide.dart';
import 'package:ctware/model/news.dart';
import 'package:ctware/provider/news_provider.dart';
import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/screens/bank_location/bl_list_view.dart';
import 'package:ctware/screens/news/news_list_view.dart';
import 'package:ctware/services/common_service.dart';
import 'package:ctware/theme/bottom_bar.dart';
import 'package:ctware/theme/style.dart';
import 'package:ctware/views/Account.dart';
import 'package:ctware/views/Involce.dart';
import 'package:ctware/views/Setting.dart';
import 'package:ctware/views/TestChart.dart';
import 'package:ctware/views/chart/test_chart1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Trang chủ', 'assets/icons/ic_home.png', Colors.teal),
    Destination(1, 'Tin tức', 'assets/icons/ic_news.png', Colors.cyan),
    Destination(2, 'Thông báo', 'assets/icons/ic_notify.png', Colors.orange),
    Destination(3, 'Tài khoản', 'assets/icons/ic_user.png', Colors.blue),
  ];

  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  List<Widget> mainPageList(BuildContext context) {
    return <Widget>[
      Navigator(
        key: _navigatorKeys[0],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
              builder: (_) => HomePage(
                    onNavigateToNew: () {
                      _onItemTapped(1);
                    },
                  ));
        },
      ),
      Navigator(
        key: _navigatorKeys[1],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (_) => const NewsListView());
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: selectedIndex, children: mainPageList(context)),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTapped: _onItemTapped,
        allDestinations: allDestinations,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.onNavigateToNew});

  final VoidCallback onNavigateToNew;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> imgList = [
    'assets/images/slider1.png',
    'assets/images/slider2.png'
  ];

  late UserProvider userProvider;
  late NewsProvider newsProvider;
  late List<AdvertiseSlide> advertiseSlideList;
  late Future<List<AdvertiseSlide>> futureAdvertiseSlide;
  late Future<List<News>> futureNews;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    final commonService = CommonService(context: context);
    futureAdvertiseSlide = commonService.getAdvertiseSlideApi();
    newsProvider = Provider.of<NewsProvider>(context, listen: false);
    futureNews = newsProvider.futureNews(context);
  }

  void _onTapAdvertiseSlide(AdvertiseSlide advertiseSlide) async {
    await launchUrl(Uri.parse(advertiseSlide.LINK ?? ''));
  }

  Widget mainCard(context) {
    return Container(
      height: 150,
      decoration: BoxStyle.fromBoxDecoration(radius: 15),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text(
            'Xin chào, ${userProvider.user?.accFullName}',
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 5),
          const Divider(height: 1.0, color: Colors.black),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMenuItem('assets/icons/ic_bill.png', 'Hóa đơn'),
              _buildMenuItem('assets/icons/ic_notification.png', 'Thông báo'),
              _buildMenuItem('assets/icons/ic_account.png', 'Tài khoản'),
            ],
          ),
        ],
      ),
    );
  }

  Widget mainBody(context) {
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenuItemIcon(
                  context,
                  Iconsax.empty_wallet_time,
                  'Tra cứu Hóa đơn',
                  const Color.fromARGB(255, 42, 108, 224), () {
                // Action for 'Tra cứu Hóa đơn'
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InvoiceListScreen()),
                );
              }),
              _buildMenuItemIcon(context, Iconsax.clipboard_text, 'Hợp đồng',
                  const Color.fromARGB(255, 255, 196, 0), () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Testchart1(),
                ));
              }),
              _buildMenuItemIcon(context, Iconsax.message, 'Gửi yêu cầu',
                  const Color.fromARGB(255, 0, 163, 233), () {
                // Action for 'Gửi yêu cầu'
              }),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMenuItemIcon(
                  context, Icons.warning_rounded, 'Thông báo xì bể', Colors.red,
                  () {
                // Action for 'Thông báo xì bể'
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BarLineChart()),
                );
              }),
              _buildMenuItemIcon(
                  context,
                  Icons.maps_home_work_outlined,
                  'Địa điểm thanh toán',
                  const Color.fromARGB(255, 209, 77, 11), () {
                // Action for 'Địa điểm thanh toán'
                // Action for 'Cài đặt'
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BankLocationListView()),
                );
              }),
              _buildMenuItemIcon(context, Icons.settings, 'Cài đặt',
                  const Color.fromARGB(255, 250, 137, 8), () {
                // Action for 'Cài đặt'
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Setting()),
                );
              }),
            ],
          ),
        ),
        FutureBuilder(
            future: futureAdvertiseSlide,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return Container(
                  margin: const EdgeInsets.only(top: 30, bottom: 15),
                  color: Colors.black,
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: CarouselSlider(
                    options:
                        CarouselOptions(autoPlay: true, viewportFraction: 1),
                    items: snapshot.data!
                        .map((item) => InkWell(
                              onTap: () {
                                _onTapAdvertiseSlide(item);
                              },
                              child:
                                  ImageFromBase64.toImage(item.HINHANH ?? ''),
                            ))
                        .toList(),
                  ),
                );
              }
              return const SizedBox(
                  height: 100,
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                    strokeWidth: 3,
                  )));
            }),
        Container(
          padding: const EdgeInsets.all(16.0),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tin tức',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              InkWell(
                  onTap: () {
                    widget.onNavigateToNew();
                  },
                  child: const Text('Tất cả >',
                      style: TextStyle(color: Colors.blue))),
            ],
          ),
        ),
        SizedBox(
          height: 200,
          child: FutureBuilder(
            future: futureNews,
            builder: (context, snapshot) {
              if(snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
                print('------------------------');
              }
              return ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildNewsItem(),
                  _buildNewsItem(),
                  _buildNewsItem(),
                ],
              );
            }
          ),
        ),
        const SizedBox(height: 20)
      ]),
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
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage('assets/images/news1.jpg'),
                    fit: BoxFit.fill)),
            height: 150,
          ),
          const SizedBox(height: 8),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: const Text('Kết quả thử nghiệm nước tháng 07/2024'),
          ),
        ],
      ),
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
                      child: const Image(
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
              preferredSize: const Size.fromHeight(180),
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.all(20),
                child: mainCard(context),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: mainBody(context),
          ),
        ],
      ),
    );
  }
}