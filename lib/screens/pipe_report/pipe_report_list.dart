import 'package:ctware/model/pipe_report.dart';
import 'package:ctware/services/users_service.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';

class PipeReportList extends StatefulWidget {
  const PipeReportList({super.key});

  @override
  State<PipeReportList> createState() => _PipeReportListState();
}

class _PipeReportListState extends State<PipeReportList> {
  late UsersService usersService;
  List<PipeReport> pipeRpList = [];

  @override
  void initState() {
    super.initState();
    usersService = UsersService(context: context);
  }

  onRefreshList() async {
    await usersService.getListPipeReport().then((value) {
      if(value.isNotEmpty) {
        setState(() {
          pipeRpList = value;
        });
      }
    });
  }

  Widget pipeItemCard(BuildContext context, PipeReport item) {
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
                color: Colors.redAccent,
                child: Text(
                  item.TIEUDE,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
            Container(
                width: Responsive.width(100, context),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nội dung: ${item.NOIDUNG}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Ngày gửi: ${item.getNGAYGUI()}',
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

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
        context: context,
        title: 'Danh sách đã gửi',
        body: FutureBuilder(
            future: usersService.getListPipeReport(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                pipeRpList = snapshot.data ?? [];
                return RefreshIndicator(
                  onRefresh: () async {
                    await onRefreshList();
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(BaseLayout.marginLayoutBase),
                      child: Column(
                        children: pipeRpList
                            .map((item) => pipeItemCard(context, item))
                            .toList(),
                      ),
                    ),
                  ),
                );
              }
              return BaseLayout.loadingView(context);
            }));
  }
}
