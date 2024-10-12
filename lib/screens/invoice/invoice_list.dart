import 'package:ctware/model/bill.dart';
import 'package:ctware/provider/bill_provider.dart';
import 'package:ctware/screens/invoice/invoice_add.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({super.key});

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  late BillProvider billProvider;
  List<Bill> listBill = [];

  @override
  void initState() {
    super.initState();
    billProvider = Provider.of<BillProvider>(context, listen: false);
    if (billProvider.listBill.isNotEmpty) {
      listBill = billProvider.listBill;
    }
  }

  Widget listBillView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
      child: SingleChildScrollView(
        child: Column(
          children: listBill
              .map((bill) => InvoiceCard(
                  idkh: bill.IDKH.toString(),
                  sodanhbo: bill.SODB ?? '',
                  name: bill.TENKH ?? '',
                  address: bill.DIACHI ?? ''))
              .toList(),
        ),
      ),
    );
  }

  Widget mainView(BuildContext context) {
    if (listBill.isNotEmpty) {
      return SingleChildScrollView(
        child: listBillView(context),
      );
    }
    return FutureBuilder(
        future: billProvider.futureBills(context),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            listBill = snapshot.data ?? [];

            return listBillView(context);
          }
          return BaseLayout.loadingView(context);
        });
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
      body: mainView(context),
    );
  }
}

class InvoiceCard extends StatelessWidget {
  final String idkh;
  final String sodanhbo;
  final String name;
  final String address;

  const InvoiceCard(
      {super.key,
      required this.idkh,
      required this.sodanhbo,
      required this.name,
      required this.address});

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
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text('IDKH: $idkh'),
            Text('Số danh bộ: $sodanhbo'),
            Text('Địa chỉ: $address'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle ghi chỉ số online action
                  },
                  icon: const Icon(
                    Icons.speed,
                    color: Colors.blue,
                  ),
                  label: const Text(
                    'Ghi chỉ số Online',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle delete action
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
