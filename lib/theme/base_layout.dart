import 'package:flutter/material.dart';

class BaseLayout {
  static const marginLayoutBase = 10.0;

  static Widget view({
    required BuildContext context,
    required String title,
    List<Widget>? actions,
    bool backAction = true,
    required Widget body,
  }) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          leading: backAction ? IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ) : null,
          actions: actions,
        ),
        body: body);
  }
}
