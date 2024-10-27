import 'dart:io';

import 'package:ctware/screens/pipe_report/pick_image.dart';
import 'package:ctware/screens/pipe_report/pick_image_full_screen.dart';
import 'package:ctware/screens/pipe_report/pipe_report_list.dart';
import 'package:ctware/services/users_service.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/dialog.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PipeReportForm extends StatefulWidget {
  const PipeReportForm({super.key});

  @override
  State<PipeReportForm> createState() => _PipeReportFormState();
}

class _PipeReportFormState extends State<PipeReportForm> {
  final _formKey = GlobalKey<FormState>();
  List<File> imageData = [];
  String title = '';
  String content = '';
  late bool isSubmitProcess = false;

  void checkGPSPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ShowingDialog.errorDialog(context,
          errMes: 'Dịch vụ GPS không khả dụng', title: 'GPS');
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Nếu chưa cấp quyền, yêu cầu cấp quyền
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ShowingDialog.errorDialog(context,
            errMes: 'Quyền truy cập vị trí bị từ chối', title: 'GPS');
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkGPSPermission();
  }

  Future submit() async {
    if (isSubmitProcess) {
      return;
    }
    setState(() {
      isSubmitProcess = true;
    });
    final formState = _formKey.currentState;
    if (formState != null && formState.validate()) {
      formState.save();
      final userService = UsersService(context: context);
      await userService
          .sendPipeReportApi(title, content, imageData)
          .then((value) {
        if (value) {
          ShowingDialog.successDialog(context,
          title: 'Thông báo xì bể',
              message:
                  'Quý khách đã gửi thông báo thành công. Công ty sẽ sớm cử nhân viên kiểm tra và khắc phục sự cố. Cảm hơn Quý khách.');
        }
      });
    }
    setState(() {
      isSubmitProcess = false;
    });
  }

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

  onDeleteImage(int index) {
    setState(() {
      imageData.removeAt(index);
    });
  }

  Widget renderImagePick(BuildContext context, File item, int index) {
    return SizedBox(
      height: 100,
      width: 70,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PickImageFullScreen(imageFile: item)),
              );
            },
            child: Container(
                color: const Color.fromARGB(200, 153, 153, 153),
                height: 100,
                width: 70,
                child: Image.file(item, fit: BoxFit.contain)),
          ),
          Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  onDeleteImage(index);
                },
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
    int index = 0;
    for (var item in imageData) {
      rowChidren.add(renderImagePick(context, item, index));
      rowChidren.add(space);
      index++;
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
      resizeToAvoidBottomInset: false,
      title: 'Thông báo xì bể',
      actions: [
        IconButton(
            icon: const Icon(
              Icons.list,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PipeReportList(),
              ));
            },
          ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Tiêu đề',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập tiêu đề.';
                        }
                        return null;
                      },
                      onSaved: (value) => title = value ?? '',
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        labelText: 'Mô tả vị trí xì bể',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập nội dung.';
                        }
                        return null;
                      },
                      onSaved: (value) => content = value ?? '',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              imagePickView(context),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  submit();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: isSubmitProcess
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
                        'Gửi',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
