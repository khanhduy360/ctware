import 'dart:io';

import 'package:ctware/theme/base_layout.dart';
import 'package:flutter/material.dart';

class PickImageFullScreen extends StatelessWidget {
  const PickImageFullScreen({super.key, required this.imageFile});

  final File imageFile;

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
      context: context,
      title: 'Thông báo xì bể',
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
          child: Image.file(imageFile),
        ),
      ),
    );
  }
}
