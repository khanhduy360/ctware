import 'package:flutter/material.dart';

class BaseLayout {
  static const marginLayoutBase = 10.0;

  static Widget view({
    required BuildContext context,
    required String title,
    List<Widget>? actions,
    bool backAction = true,
    required Widget body,
    bool? resizeToAvoidBottomInset
  }) {
    return Scaffold(
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          leading: backAction
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : null,
          actions: actions,
        ),
        body: body);
  }

  static Widget loadingView(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(BaseLayout.marginLayoutBase),
        child: const SizedBox(
            height: 50, width: 50, child: CircularProgressIndicator()));
  }

  static Widget emptyView(BuildContext context, {String? message}) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(BaseLayout.marginLayoutBase),
      child: Column(
        children: [
          Expanded(child: Container()),
          Center(child: Text(message ?? 'Không có dữ liệu để hiển thị', style: const TextStyle(fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}
