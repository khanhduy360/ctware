import 'package:ctware/model/bill.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';

class GcsForm extends StatefulWidget {
  const GcsForm({super.key, required this.bill});

  final Bill bill;

  @override
  State<GcsForm> createState() => _GcsFormState();
}

class _GcsFormState extends State<GcsForm> {
  bool isSubmitProcess = false;

  Widget inputImageViewItem(BuildContext context) {
    return InkWell(
      onTap: () {
        //showBottomChangePicture(context);
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 94, 94, 94)),
            borderRadius: BorderRadius.circular(5)),
        child: const Icon(Icons.camera_alt, color: Colors.blue),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
      context: context,
      title: 'Ghi chỉ số Online',
      body: Padding(
        padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
        child: Column(
          children: [
            Container(
              decoration: BoxStyle.fromBoxDecoration(radius: 5),
              child: Column(
                children: [
                  Text('Thông tin Khách hàng'),
                  Text('Họ tên:'),
                  Text('Địa chỉ:'),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text('IDKH'),
                          Text('10'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Danh bộ'),
                          Text('167 A'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Loại KH/NK'),
                          Text('D'),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxStyle.fromBoxDecoration(radius: 5),
              child: Column(children: [
                Text('Thông tin ghi chỉ số'),
                Text('Quý khách nhập Chỉ số mới cho kỳ'),
                Row(
                    children: [
                      Column(
                        children: [
                          Text('Chỉ số củ'),
                          Text('10'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Chỉ số mới'),
                          Text('167 A'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('M3TT'),
                          Text('D'),
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      inputImageViewItem(context),
                      Text('Thêm ảnh')
                    ],
                  ),
                  Row(
                    children: [
                      Text('(*)'),
                      Text('là bắt buộc nhập')
                    ],
                  ),
                  ElevatedButton(
                  onPressed: () {
                    //submit();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: isSubmitProcess
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 4,
                            ),
                          ),
                        )
                      : const Text(
                          'Gửi',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                )
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
