import 'package:ctware/theme/base_layout.dart';
import 'package:flutter/material.dart';

class SendRequestAdd extends StatefulWidget {
  const SendRequestAdd({super.key});

  @override
  State<SendRequestAdd> createState() => _SendRequestAddState();
}

class _SendRequestAddState extends State<SendRequestAdd> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
        context: context,
        title: 'Gửi yêu cầu mới',
        body: Padding(
          padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
          child: SingleChildScrollView(
            child: Column(
              children: [
                
              ],
            ),
          ),
        ));
  }
}
