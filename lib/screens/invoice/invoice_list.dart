import 'package:ctware/theme/base_layout.dart';
import 'package:flutter/material.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({super.key});

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
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
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AddInvoiceScreen()),
            // );
          },
        ),
      ],
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(BaseLayout.marginLayoutBase),
          child: Column(
            children: [
              InvoiceCard(
                idkh: '65642',
                sodanbo: '877026A',
                name: 'NGUYỄN VĂN A',
                address:
                    'SỐ 10-U, ĐƯỜNG SỐ 10, KDC CTY8, P. HƯNG THẠNH. - KDC CTY 8',
              ),
              InvoiceCard(
                idkh: '65642',
                sodanbo: '877026A',
                name: 'NGUYỄN VĂN A',
                address:
                    'SỐ 10-U, ĐƯỜNG SỐ 10, KDC CTY8, P. HƯNG THẠNH. - KDC CTY 8',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InvoiceCard extends StatelessWidget {
  final String idkh;
  final String sodanbo;
  final String name;
  final String address;

  const InvoiceCard(
      {super.key,
      required this.idkh,
      required this.sodanbo,
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
            Text('Số danh bộ: $sodanbo'),
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
