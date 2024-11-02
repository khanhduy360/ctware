import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ctware/configs/utilities.dart';
import 'package:ctware/model/advertise_slide.dart';
import 'package:ctware/model/news.dart';
import 'package:ctware/model/news_item.dart';
import 'package:ctware/provider/news_provider.dart';
import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/screens/bank_location/bl_list_view.dart';
import 'package:ctware/screens/notification/notification_view.dart';
import 'package:ctware/screens/pipe_report/pipe_report_form.dart';
import 'package:ctware/screens/contract/contract_list_view.dart';
import 'package:ctware/screens/invoice/invoice_list.dart';
import 'package:ctware/screens/invoice_search/invoice_search_view.dart';
import 'package:ctware/screens/news/news_list_view.dart';
import 'package:ctware/screens/news/news_web_view.dart';
import 'package:ctware/screens/send_request/send_request_add.dart';
import 'package:ctware/screens/send_request/send_request_list.dart';
import 'package:ctware/screens/setting/setting.dart';
import 'package:ctware/screens/user_info/user_info.dart';
import 'package:ctware/screens/user_info/widgets/update_user_info_screen.dart';
import 'package:ctware/services/common_service.dart';
import 'package:ctware/theme/bottom_bar.dart';
import 'package:ctware/theme/style.dart';
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
    rootContext = context;
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
      Navigator(
        key: _navigatorKeys[2],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (_) => const NotificationView());
        },
      ),
      Navigator(
        key: _navigatorKeys[3],
        onGenerateRoute: (settings) {
          return MaterialPageRoute(builder: (_) => const UserInfoScreen());
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final currentContext = _navigatorKeys[selectedIndex].currentContext;
        if (currentContext != null && Navigator.canPop(currentContext)) {
          Navigator.pop(currentContext);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body:
            IndexedStack(index: selectedIndex, children: mainPageList(context)),
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: selectedIndex,
          onItemTapped: _onItemTapped,
          allDestinations: allDestinations,
        ),
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

  late NewsProvider newsProvider;
  late List<AdvertiseSlide> advertiseSlideList;
  late Future<List<AdvertiseSlide>> futureAdvertiseSlide;
  late Future<List<News>> futureNews;

  @override
  void initState() {
    super.initState();
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
          Consumer<UserProvider>(builder:
              (BuildContext context, UserProvider userProvider, Widget? child) {
            return Text(
              'Xin chào, ${userProvider.getDisplayName() ?? userProvider.getFullName() ?? "User"}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            );
          }),
          const SizedBox(height: 5),
          const Divider(height: 1.0, color: Colors.black),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMenuItem(
                  assetPath: 'assets/icons/ic_bill.png',
                  title: 'Hóa đơn',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InvoiceList()),
                    );
                  }),
              _buildMenuItem(
                  assetPath: 'assets/icons/ic_notification.png',
                  title: 'Thông báo',
                  onTap: () {}),
              _buildMenuItem(
                  assetPath: 'assets/icons/ic_account.png',
                  title: 'Tài khoản',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UpdateUserInfoScreen()),
                    );
                  }),
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
                      builder: (context) => const InvoiceSearchView()),
                );
              }),
              _buildMenuItemIcon(context, Iconsax.clipboard_text, 'Hợp đồng',
                  const Color.fromARGB(255, 255, 196, 0), () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ContractListView(),
                ));
              }),
              _buildMenuItemIcon(context, Iconsax.message, 'Gửi yêu cầu',
                  const Color.fromARGB(255, 0, 163, 233), () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SendRequestList(),
                ));
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
                  MaterialPageRoute(builder: (context) => const PipeReportForm()),
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
          height: 220,
          child: FutureBuilder(
              future: futureNews,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.isNotEmpty) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: newsProvider
                        .getNewsItemHot()
                        .map((item) => _buildNewsItem(item))
                        .toList(),
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
        ),
        const SizedBox(height: 20)
      ]),
    );
  }

  Widget _buildMenuItem(
      {required String assetPath,
      required String title,
      required Function()? onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 40,
            width: 40,
            child: Image(
              image: AssetImage(assetPath),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildMenuItemIcon(BuildContext context, IconData icon, String title,
      Color color, VoidCallback onPressed) {
    return SizedBox(
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
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15),
              overflow:
                  TextOverflow.visible, // Allows text to wrap to the next line
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsItem(NewsItem item) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsWebView(
                      title: item.title ?? '',
                      url: item.link ?? '',
                    )));
      },
      child: Container(
        decoration: BoxStyle.fromBoxDecoration(radius: 10),
        width: 200,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                placeholder: (context, url) => const Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator())),
                imageUrl: item.imgUrl ?? '',
                height: 150,
                width: Responsive.width(100, context),
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Text(item.title ?? '',
                  maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
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
