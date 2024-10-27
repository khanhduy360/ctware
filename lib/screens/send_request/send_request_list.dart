import 'package:ctware/model/user_requests.dart';
import 'package:ctware/provider/send_request_provider.dart';
import 'package:ctware/screens/send_request/send_reponse_view.dart';
import 'package:ctware/screens/send_request/send_request_add.dart';
import 'package:ctware/services/users_service.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendRequestList extends StatefulWidget {
  const SendRequestList({super.key});

  @override
  State<SendRequestList> createState() => _SendRequestListState();
}

class _SendRequestListState extends State<SendRequestList> {
  late UsersService usersService;
  late SendRequestProvider sendRequestProvider;
  late Future<List<UserRequests>> futureUserRequests;

  @override
  void initState() {
    super.initState();
    usersService = UsersService(context: context);
    sendRequestProvider =
        Provider.of<SendRequestProvider>(context, listen: false);
    futureUserRequests = sendRequestProvider.futureUserRequests(context);
  }

  onRefreshList() async {
    await sendRequestProvider.futureUserRequests(context);
  }

  Widget onInitView(BuildContext context) {
    if (sendRequestProvider.userRequestsList.isEmpty) {
      return FutureBuilder(
          future: futureUserRequests,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return BaseLayout.emptyView(context);
              }
              return requestListView(context);
            }
            return BaseLayout.loadingView(context);
          });
    }
    return requestListView(context);
  }

  Widget requestsItemCard(BuildContext context, UserRequests item) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SendReponseView(userRequests: item),
        ));
      },
      child: Container(
        decoration: BoxStyle.fromBoxDecoration(radius: 5),
        margin: const EdgeInsets.only(bottom: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Column(
            children: [
              Container(
                  width: Responsive.width(100, context),
                  padding: const EdgeInsets.all(10),
                  color: Colors.green,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Loại yêu cầu: ${item.RequestType}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Khách hàng: ${item.IDKH} - ${item.TENKH}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  )),
              Container(
                  width: Responsive.width(100, context),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Khu vực tiếp nhận: ${item.TENKV}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Nội dung: ${item.ReqContent}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Ngày gửi: ${item.getReqDate()}',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget requestListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefreshList();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
          child: Consumer<SendRequestProvider>(builder: (BuildContext context,
              SendRequestProvider sendRequestProvider, Widget? child) {
            return Column(
              children: sendRequestProvider.userRequestsList
                  .map((item) => requestsItemCard(context, item))
                  .toList(),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
        context: context,
        title: 'Gửi yêu cầu',
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SendRequestAdd(),
              ));
            },
          ),
        ],
        body: onInitView(context));
  }
}
