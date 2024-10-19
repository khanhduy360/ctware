import 'package:ctware/theme/base_layout.dart';
import 'package:flutter/material.dart';

class InvoiceAdd extends StatefulWidget {
  const InvoiceAdd({super.key});

  @override
  State<InvoiceAdd> createState() => _InvoiceAddState();
}

class _InvoiceAddState extends State<InvoiceAdd> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
      context: context,
      title: 'Thêm Hóa đơn liên kết',
      body: Padding(
        padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Nhập IDKH',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Nhập Mã xác nhận',
                        border: OutlineInputBorder(),
                        helperText:
                            '(*) Mã xác nhận trên Giấy báo và Biên nhận',
                        helperStyle: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            TextButton(
              onPressed: () {
                // Handle link press
              },
              child: const Text(
                'Hướng dẫn liên kết',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(double.infinity, 48), // Make button full width
              ),
              child: const Text(
                'Thêm Hóa đơn',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
