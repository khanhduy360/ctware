import 'package:ctware/model/user_requests.dart';
import 'package:ctware/screens/send_request/send_request_add.dart';
import 'package:ctware/services/users_service.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';

class SendRequestList extends StatefulWidget {
  const SendRequestList({super.key});

  @override
  State<SendRequestList> createState() => _SendRequestListState();
}

class _SendRequestListState extends State<SendRequestList> {
  late UsersService usersService;
  List<UserRequests> userRequestsList = [];

  @override
  void initState() {
    super.initState();
    usersService = UsersService(context: context);
  }

  onRefreshList() async {
    await usersService.getUserRequests().then((value) {
      if (value.isNotEmpty) {
        setState(() {
          userRequestsList = value;
        });
      }
    });
  }

  Widget requestsItemCard(BuildContext context, UserRequests item) {
    return Container(
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
    );
  }

  Widget requestListView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await onRefreshList();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
          child: Column(
            children: userRequestsList
                .map((item) => requestsItemCard(context, item))
                .toList(),
          ),
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
        body: FutureBuilder(
            future: usersService.getUserRequests(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                userRequestsList = snapshot.data ?? [];
                return requestListView(context);
              }
              return BaseLayout.loadingView(context);
            }));
  }
}
