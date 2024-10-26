import 'package:ctware/configs/utilities.dart';
import 'package:ctware/model/bill.dart';
import 'package:ctware/model/request_types.dart';
import 'package:ctware/provider/bill_provider.dart';
import 'package:ctware/provider/request_types_provider.dart';
import 'package:ctware/services/users_service.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/dialog.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendRequestAdd extends StatefulWidget {
  const SendRequestAdd({super.key});

  @override
  State<SendRequestAdd> createState() => _SendRequestAddState();
}

class _SendRequestAddState extends State<SendRequestAdd> {
  final _formKey = GlobalKey<FormState>();
  late BillProvider billProvider;
  late RequestTypesProvider requestTypesProvider;
  List<Bill> dropdownListBill = <Bill>[];
  late Bill dropdownValueBill;
  List<RequestTypes> dropdownListRequestTypes = <RequestTypes>[];
  late RequestTypes dropdownValueRequestTypes;
  late Future<bool> initFuture;

  String reqContent = '';
  String res2Name = '';
  String res2Tel = '';

  late bool isSubmitProcess = false;

  @override
  void initState() {
    super.initState();
    billProvider = Provider.of<BillProvider>(context, listen: false);
    requestTypesProvider =
        Provider.of<RequestTypesProvider>(context, listen: false);
    initFuture = loadDataPost();
  }

  Future<bool> loadDataPost() async {
    if (billProvider.listBill.isEmpty) {
      await billProvider.futureBills(context);
    }
    dropdownListBill = billProvider.listBill;
    if (dropdownListBill.isNotEmpty) {
      dropdownValueBill = dropdownListBill.first;
    }
    if (requestTypesProvider.listRequestTypes.isEmpty) {
      // ignore: use_build_context_synchronously
      await requestTypesProvider.futureRequestTypes(context);
    }
    dropdownListRequestTypes = requestTypesProvider.listRequestTypes;
    if (dropdownListRequestTypes.isNotEmpty) {
      dropdownValueRequestTypes = dropdownListRequestTypes.first;
    }
    return dropdownListBill.isNotEmpty && dropdownListRequestTypes.isNotEmpty;
  }

  Future submit() async {
    if (isSubmitProcess) {
      return;
    }
    setState(() {
      isSubmitProcess = true;
    });
    final formState = _formKey.currentState;
    if (formState != null) {
      formState.save();
    }
    final usersService = UsersService(context: context);
    await usersService
        .sendRequestsApi(
            idkh: dropdownValueBill.IDKH,
            reqType: dropdownValueRequestTypes.reqType,
            reqContent: reqContent,
            res2Name: res2Name,
            res2Tel: res2Tel)
        .then((value) {
      if (value) {
        ShowingDialog.successDialog(rootContext,
        onConfirmBtnTap: () {
          Navigator.pop(rootContext);
          Navigator.pop(context);
        },
            message:
                'Quý khách đã gửi thông báo thành công. Công ty sẽ sớm cử nhân viên kiểm tra và khắc phục sự cố. Cảm hơn Quý khách.');
        onLoadRequestList();
      }
    });
    setState(() {
      isSubmitProcess = false;
    });
  }

  Future onLoadRequestList() async {}

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
        context: context,
        title: 'Gửi yêu cầu mới',
        body: Padding(
          padding: const EdgeInsets.all(BaseLayout.marginLayoutBase),
          child: FutureBuilder(
              future: initFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!) {
                  return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxStyle.fromBoxDecoration(radius: 5),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Chọn khách hàng gửi yêu cầu',
                                    style: TextStyle(color: Colors.blue)),
                                DropdownButton<Bill>(
                                  value: dropdownValueBill,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: const Color.fromARGB(94, 0, 0, 0),
                                  ),
                                  onChanged: (Bill? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        dropdownValueBill = newValue;
                                      });
                                    }
                                  },
                                  isExpanded: true,
                                  items: dropdownListBill
                                      .map<DropdownMenuItem<Bill>>(
                                          (Bill value) {
                                    return DropdownMenuItem<Bill>(
                                      value: value,
                                      child: Text(
                                        value.getSelectItem(),
                                        style: TextStyle(
                                            fontWeight:
                                                value == dropdownValueBill
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 3),
                                const Text('Loại yêu cầu',
                                    style: TextStyle(color: Colors.blue)),
                                DropdownButton<RequestTypes>(
                                  value: dropdownValueRequestTypes,
                                  icon: const Icon(Icons.arrow_drop_down),
                                  iconSize: 24,
                                  elevation: 16,
                                  style: const TextStyle(color: Colors.black),
                                  underline: Container(
                                    height: 2,
                                    color: const Color.fromARGB(94, 0, 0, 0),
                                  ),
                                  onChanged: (RequestTypes? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        dropdownValueRequestTypes = newValue;
                                      });
                                    }
                                  },
                                  isExpanded: true,
                                  items: dropdownListRequestTypes
                                      .map<DropdownMenuItem<RequestTypes>>(
                                          (RequestTypes value) {
                                    return DropdownMenuItem<RequestTypes>(
                                      value: value,
                                      child: Text(
                                        value.reqDescription ?? '',
                                        style: TextStyle(
                                            fontWeight: value ==
                                                    dropdownValueRequestTypes
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 3),
                                const Text('Nội dung yêu cầu',
                                    style: TextStyle(color: Colors.blue)),
                                const SizedBox(height: 2),
                                TextFormField(
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder()),
                                  onSaved: (value) => reqContent = value ?? '',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxStyle.fromBoxDecoration(radius: 5),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                    '(Tùy chọn) Khi có kết quả, vui lòng liên hệ'),
                                const SizedBox(height: 10),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Ông/Bà',
                                    border: OutlineInputBorder(),
                                  ),
                                  onSaved: (value) => res2Name = value ?? '',
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  decoration: const InputDecoration(
                                    labelText: 'Điện thoại',
                                    border: OutlineInputBorder(),
                                  ),
                                  onSaved: (value) => res2Tel = value ?? '',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
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
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return BaseLayout.loadingView(context);
              }),
        ));
  }
}
