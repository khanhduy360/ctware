import 'package:ctware/configs/utilities.dart';
import 'package:ctware/model/bill.dart';
import 'package:ctware/provider/bill_provider.dart';
import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/screens/invoice/gcs_form.dart';
import 'package:ctware/screens/invoice/invoice_add.dart';
import 'package:ctware/services/users_service.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({super.key});

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  late BillProvider billProvider;

  late Future<List<Bill>> futureBills;
  late Future<bool> futureGetConfigGCS;

  @override
  void initState() {
    super.initState();
    billProvider = Provider.of<BillProvider>(context, listen: false);
    futureBills = billProvider.futureBills(context);
    futureGetConfigGCS = billProvider.futureGetConfigGCS(context);
  }

  onRefreshList() async {
    await billProvider.futureBills(context);
    // ignore: use_build_context_synchronously
    await billProvider.futureGetConfigGCS(context);
  }

  Widget onInitView(BuildContext context) {
    if (billProvider.listBill.isEmpty) {
      return FutureBuilder(
          future: futureBills,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return BaseLayout.emptyView(context);
              }
              return listBillView(context);
            }
            return BaseLayout.loadingView(context);
          });
    }
    return listBillView(context);
  }

  Widget listBillView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        onRefreshList();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
          child: Consumer<BillProvider>(builder:
              (BuildContext context, BillProvider billProvider, Widget? child) {
            return Column(
              children: billProvider.listBill
                  .map((item) => InvoiceCard(
                      bill: item, isGCSOnline: billProvider.configGCS))
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
      title: 'Danh sách Hóa đơn',
      actions: [
        IconButton(
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InvoiceAdd()),
            );
          },
        ),
      ],
      body: onInitView(context),
    );
  }
}

class InvoiceCard extends StatelessWidget {
  final Bill bill;
  final bool isGCSOnline;
  const InvoiceCard({super.key, required this.bill, required this.isGCSOnline});

  onDeleteBill(BuildContext context) {
    ShowingDialog.comfirmDialog(rootContext,
        title: 'Thông báo',
        message: 'Bạn có muốn xóa liên kết với khách hàng này?',
        yesEvent: () async {
      ShowingDialog.loadingDialog(rootContext);
      final billProvider = Provider.of<BillProvider>(context, listen: false);
      await billProvider.futureDeleteBill(context, bill);
      // Pop loading
      // ignore: use_build_context_synchronously
      Navigator.pop(rootContext);
      // Pop confirm
      // ignore: use_build_context_synchronously
      Navigator.pop(rootContext);
    });
  }

  onCheckGCS(BuildContext context) async {
    final userService = UsersService(context: context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user != null) {
      await userService
          .checkKhachHangGCSApi(
              idkh: bill.IDKH.toString(),
              uId: userProvider.user!.accID.toString())
          .then((value) {
        if (value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GcsForm(bill: bill)),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bill.TENKH ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text('IDKH: ${bill.IDKH.toString()}'),
            Text('Số danh bộ: ${bill.SODB ?? ''}'),
            Text('Địa chỉ: ${bill.DIACHI ?? ''}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isGCSOnline
                    ? ElevatedButton.icon(
                        onPressed: () {
                          onCheckGCS(context);
                        },
                        icon: const Icon(
                          Icons.speed,
                          color: Colors.blue,
                        ),
                        label: const Text(
                          'Ghi chỉ số Online',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(width: 15),
                ElevatedButton.icon(
                  onPressed: () {
                    onDeleteBill(context);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: const Text(
                    'Xóa',
                    style: TextStyle(color: Colors.red),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
