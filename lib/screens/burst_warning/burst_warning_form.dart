import 'package:ctware/theme/base_layout.dart';
import 'package:flutter/material.dart';

class BurstWarningForm extends StatefulWidget {
  const BurstWarningForm({super.key});

  @override
  State<BurstWarningForm> createState() => _BurstWarningFormState();
}

class _BurstWarningFormState extends State<BurstWarningForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
      context: context,
      title: 'Thông báo xì bể',
      body: Padding(
        padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Tiêu đề',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      labelText: 'Mô tả vị trí xì bể',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize:
                    const Size(double.infinity, 48),
              ),
              child: const Text(
                'Gửi',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
