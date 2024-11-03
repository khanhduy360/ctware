import 'dart:io';

import 'package:ctware/model/bill.dart';
import 'package:ctware/model/bill_info.dart';
import 'package:ctware/screens/pipe_report/pick_image.dart';
import 'package:ctware/screens/pipe_report/pick_image_full_screen.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';

class GcsForm extends StatefulWidget {
  const GcsForm({super.key, required this.bill, required this.billInfo});
  final Bill bill;
  final BillInfo billInfo;

  @override
  State<GcsForm> createState() => _GcsFormState();
}

class _GcsFormState extends State<GcsForm> {
  final _formKey = GlobalKey<FormState>();
  bool isSubmitProcess = false;
  String csm = '';
  String m3tt = '';
  File? imageData;

  onChangedForm(value) {
    if (num.tryParse(value) == null) {
      setState(() {
        m3tt = '';
      });
      return;
    }
    csm = value ?? '';
    int cs = int.parse(csm) - widget.billInfo.CSMOI;
    setState(() {
      m3tt = cs.toString();
    });
  }

  submit() {
    if (isSubmitProcess) {
      return;
    }
    setState(() {
      isSubmitProcess = true;
    });
    final formState = _formKey.currentState;
    if (formState != null && formState.validate()) {}
    setState(() {
      isSubmitProcess = false;
    });
  }

  onDeleteImage() {
    setState(() {
      imageData = null;
    });
  }

  Widget renderImagePick(BuildContext context, File item) {
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
                  onDeleteImage();
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

  Widget renderImageView(BuildContext context) {
    if (imageData != null) {
      return renderImagePick(context, imageData!);
    }
    return inputImageViewItem(context);
  }

  Future onPickMedia({isGallery = true}) async {
    final imageValue = await PickImage.pickMedia(
      isGallery: isGallery,
    );
    if (imageValue == null) {
      return;
    }
    setState(() {
      imageData = imageValue;
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
                      color: Colors.white,
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
                        color: Colors.white,
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
                        color: Colors.white,
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
                      color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    const textStyleHead = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const textStyleLable = TextStyle(fontSize: 14);
    const textStyleLableRed = TextStyle(fontSize: 14, color: Colors.red);
    const textStyleLable2 = TextStyle(fontSize: 14, color: Colors.blue);
    const textStyleValue = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
    return BaseLayout.view(
      context: context,
      title: 'Ghi chỉ số Online',
      body: Padding(
        padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxStyle.fromBoxDecoration(radius: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thông tin Khách hàng', style: textStyleHead),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Họ tên:',
                          style: textStyleLable,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                            child: Text(
                          widget.bill.TENKH ?? '',
                          style: textStyleValue,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Địa chỉ:', style: textStyleLable),
                        const SizedBox(width: 5),
                        Flexible(
                            child: Text(
                          widget.bill.DIACHI ?? '',
                          style: textStyleValue,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text('IDKH', style: textStyleLable),
                            Text(widget.bill.IDKH.toString(),
                                style: textStyleValue),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Danh bộ', style: textStyleLable),
                            Text(widget.bill.SODB ?? '', style: textStyleValue),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Loại KH/NK', style: textStyleLable),
                            Text(widget.billInfo.MALKHDB ?? '',
                                style: textStyleValue),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxStyle.fromBoxDecoration(radius: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Thông tin ghi chỉ số', style: textStyleHead),
                    const SizedBox(height: 5),
                    const Text('Quý khách nhập Chỉ số mới cho kỳ',
                        style: textStyleLable),
                    const SizedBox(height: 2),
                    Form(
                      key: _formKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text('Chỉ số củ', style: textStyleLable2),
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text(widget.billInfo.CSMOI.toString(),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Row(
                                children: [
                                  Text('Chỉ số mới ', style: textStyleLable2),
                                  Text('(*)', style: textStyleLableRed),
                                ],
                              ),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    errorStyle: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 10,
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Vui lòng nhập';
                                    }
                                    if (num.tryParse(value) == null) {
                                      return 'Chỉ số không hợp lệ';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    onChangedForm(value);
                                  },
                                  onSaved: (value) => csm = value ?? '',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('M3TT', style: textStyleLable2),
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Text(m3tt,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        renderImageView(context),
                        const SizedBox(width: 10),
                        const Text('Thêm ảnh')
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Text(
                          '(*) ',
                          style: textStyleLableRed,
                        ),
                        Text('là bắt buộc nhập', style: textStyleLable)
                      ],
                    ),
                  ],
                ),
              ),
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
