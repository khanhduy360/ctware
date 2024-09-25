import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';

class ContractListView extends StatelessWidget {
  const ContractListView({super.key});

  Widget contractItem(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(BaseLayout.marginLayoutBase),
      decoration: BoxStyle.fromBoxDecoration(radius: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Responsive.width(100, context),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 27, 149, 31),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Số hợp đồng:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Hợp đồng:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Ngày ký:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Số điện thoại:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'IDKH:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 168, 166, 166),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Họ tên:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 168, 166, 166),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Địa chỉ:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 168, 166, 166),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Color.fromARGB(255, 237, 236, 236)),
            child: Row(
              children: [
                Icon(Icons.file_present, color: Colors.blue,),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text('Xem hợp đồng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
        context: context,
        title: 'Danh sách Hợp đồng',
        body: SingleChildScrollView(
          child: Column(
            children: [
              contractItem(context),
              contractItem(context),
              contractItem(context),
              contractItem(context),
            ],
          ),
        ));
  }
}
