import 'dart:io';

import 'package:ctware/screens/burst_warning/pick_image.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';

class BurstWarningForm extends StatefulWidget {
  const BurstWarningForm({super.key});

  @override
  State<BurstWarningForm> createState() => _BurstWarningFormState();
}

class _BurstWarningFormState extends State<BurstWarningForm> {
  final _formKey = GlobalKey<FormState>();
  List<File> imageData = [];

  Future onPickMedia({isGallery = true}) async {
    final imageValue = await PickImage.pickMedia(
      isGallery: isGallery,
    );
    if (imageValue == null) {
      return;
    }
    setState(() {
      imageData.add(imageValue);
    });
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void showBottomChangePicture(BuildContext context) {
    final line = Container(
      height: 1,
      color: const Color.fromARGB(255, 151, 151, 151),
    );
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext builderContext) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: Responsive.width(100, context),
                      alignment: Alignment.center,
                      color: const Color.fromARGB(164, 255, 255, 255),
                      child: const Text(
                        'Lựa chọn phương thức',
                        style: TextStyle(fontSize: 13, color: Colors.black),
                      ),
                    ),
                    line,
                    InkWell(
                      onTap: () {
                        onPickMedia(isGallery: true);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: Responsive.width(100, context),
                        alignment: Alignment.center,
                        color: const Color.fromARGB(164, 255, 255, 255),
                        child: const Text(
                          'Thư viện ảnh',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ),
                    ),
                    line,
                    InkWell(
                      onTap: () {
                        onPickMedia(isGallery: false);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: Responsive.width(100, context),
                        alignment: Alignment.center,
                        color: const Color.fromARGB(164, 255, 255, 255),
                        child: const Text(
                          'Chụp ảnh',
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(164, 255, 255, 255)),
                  padding: const EdgeInsets.all(8),
                  width: Responsive.width(100, context),
                  alignment: Alignment.center,
                  child: const Text(
                    'Hủy bỏ',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget inputImageViewItem(BuildContext context) {
    return InkWell(
      onTap: () {
        showBottomChangePicture(context);
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 94, 94, 94)),
            borderRadius: BorderRadius.circular(5)),
        child: const Icon(Icons.camera_alt, color: Colors.blue),
      ),
    );
  }

  Widget renderImagePick(BuildContext context, File item) {
    return SizedBox(
      height: 100,
      width: 70,
      child: Stack(
        children: [
          Container(
              color: Color.fromARGB(200, 153, 153, 153),
              height: 100,
              width: 70,
              child: Image.file(item, fit: BoxFit.contain)),
          Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {},
                child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 5),
                    child: ClipOval(
                        child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration:
                                BoxStyle.fromBoxDecoration(color: Colors.white),
                            child: const Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 15,
                            )))),
              )),
        ],
      ),
    );
  }

  Widget imagePickView(BuildContext context) {
    const space = SizedBox(width: 10);
    final rowChidren = <Widget>[];
    for (var item in imageData) {
      rowChidren.add(renderImagePick(context, item));
      rowChidren.add(space);
    }
    if (imageData.length < 2) {
      rowChidren.add(inputImageViewItem(context));
      rowChidren.add(space);
      rowChidren.add(const Text(
        'Thêm ảnh',
        style: TextStyle(fontSize: 15),
      ));
    }
    return Row(children: rowChidren);
  }

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
            imagePickView(context),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 48),
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
