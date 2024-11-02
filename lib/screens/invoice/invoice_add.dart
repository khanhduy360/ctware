import 'package:ctware/configs/utilities.dart';
import 'package:ctware/provider/bill_provider.dart';
import 'package:ctware/provider/user_provider.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvoiceAdd extends StatefulWidget {
  const InvoiceAdd({super.key});

  @override
  State<InvoiceAdd> createState() => _InvoiceAddState();
}

class _InvoiceAddState extends State<InvoiceAdd> {
  final _formKey = GlobalKey<FormState>();
  String keyword = '';
  String secretKey = '';
  bool isProcess = false;

  onSubmit() async {
    if (isProcess) {
      return;
    }
    setState(() {
      isProcess = true;
    });
    final formState = _formKey.currentState;
    if (formState != null && formState.validate()) {
      formState.save();
      final billProvider = Provider.of<BillProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      bool success = await billProvider.futureAddBill(context, userProvider.user,
          keyword: keyword, secretKey: secretKey);
      if (success) {
        // ignore: use_build_context_synchronously
        ShowingDialog.successDialog(rootContext, onConfirmBtnTap: () {
          Navigator.pop(rootContext);
          Navigator.pop(context);
        }, title: 'Thêm Hóa đơn', message: 'Thêm Hóa đơn thành công');
      }
    }
    setState(() {
      isProcess = false;
    });
  }

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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập IDKH.';
                      }
                      return null;
                    },
                    onSaved: (value) => keyword = value ?? '',
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Nhập Mã xác nhận',
                        border: OutlineInputBorder(),
                        helperText:
                            '(*) Mã xác nhận trên Giấy báo và Biên nhận',
                        helperStyle: TextStyle(color: Colors.red)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập Mã xác nhận.';
                      }
                      return null;
                    },
                    onSaved: (value) => secretKey = value ?? '',
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
                onSubmit();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize:
                    const Size(double.infinity, 48), // Make button full width
              ),
              child: isProcess
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
                      'Thêm Hóa đơn',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
