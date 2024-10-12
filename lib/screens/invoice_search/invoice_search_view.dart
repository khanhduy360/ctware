import 'dart:async';

import 'package:ctware/model/bill.dart';
import 'package:ctware/model/invoice.dart';
import 'package:ctware/provider/bill_provider.dart';
import 'package:ctware/screens/invoice_search/invoice_chart_view.dart';
import 'package:ctware/services/common_service.dart';
import 'package:ctware/services/statistic_service.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/month_year_picker_custom.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class InvoiceSearchView extends StatefulWidget {
  const InvoiceSearchView({super.key});

  @override
  State<InvoiceSearchView> createState() => _InvoiceSearchViewState();
}

class _InvoiceSearchViewState extends State<InvoiceSearchView> {
  int selectedIndex = 0;
  late DateTime fromMonthSelected;
  late DateTime toMonthSelected;
  // ignore: non_constant_identifier_names
  final TAG_FROM_MONTH = 'key_tag_button_1';
  // ignore: non_constant_identifier_names
  final TAG_TO_MONTH = 'key_tag_button_2';
  late BillProvider billProvider;
  List<Bill> dropdownList = <Bill>[];
  late Bill dropdownValue;
  late String urlVNPAY;
  bool isLoadInvoice = false;
  bool showPayment = false;
  late List<Invoice> listInvoiceRs = [];
  final List<Color> colorTTTT = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.orange,
    Colors.orange,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    fromMonthSelected = DateTime.now();
    toMonthSelected = DateTime.now();
    billProvider = Provider.of<BillProvider>(context, listen: false);
    if (billProvider.listBill.isNotEmpty) {
      dropdownList = billProvider.listBill;
      dropdownValue = dropdownList.first;
    }
    final commonService = CommonService(context: context);
    commonService.getVNPAYLink().then((onValue) {
      urlVNPAY = onValue;
    });
  }

  bool checkPayment(List<Invoice> listInvoice) {
    for (var invoice in listInvoice) {
      if (invoice.TRANGTHAIHOADON == 5 && invoice.HETNO == false) {
        return true;
      }
    }
    return false;
  }

  searchInvoice() {
    setState(() {
      isLoadInvoice = true;
    });
    final statisticService = StatisticService(context: context);
    statisticService
        .traCuuApi(
      idkh: dropdownValue.IDKH,
      fromDate: fromMonthSelected.toUtc().toIso8601String(),
      toDate: toMonthSelected.toUtc().toIso8601String(),
    )
        .then((onValue) {
      setState(() {
        listInvoiceRs = onValue;
        showPayment = checkPayment(listInvoiceRs);
        isLoadInvoice = false;
      });
      if(showPayment) {
        urlVNPAY = urlVNPAY.replaceAll('{0}', dropdownValue.IDKH.toString());
        urlVNPAY = urlVNPAY.replaceAll('{1}', dropdownValue.getPhoneNumber());
      }
    });
  }

  Future<void> _onPressedDatePicker(String tag) async {
    DateTime? initialDate =
        tag == TAG_FROM_MONTH ? fromMonthSelected : toMonthSelected;
    final selected = await showMonthYearPicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2019),
        lastDate: DateTime(2030),
        locale: const Locale('vi', 'VN'),
        initialMonthYearPickerMode: MonthYearPickerMode.month);
    if (selected != null) {
      setState(() {
        if (tag == TAG_FROM_MONTH) {
          fromMonthSelected = selected;
        } else {
          toMonthSelected = selected;
        }
      });
    }
  }

  String formatDate(DateTime? date) {
    return DateFormat('MM/yyyy').format(date ?? DateTime.now());
  }

  Widget _buttonDatePicket(
    context, {
    required String label,
    required String tag,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 40,
      width: Responsive.width(35, context),
      decoration: BoxStyle.fromBoxDecoration(radius: 15),
      child: FloatingActionButton(
        heroTag: tag,
        onPressed: () {
          _onPressedDatePicker(tag);
        },
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              const Icon(
                Icons.calendar_today,
                size: 20,
                color: Colors.black,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget listBillResult(BuildContext context, Invoice invoice) {
    return Container(
      height: 140,
      margin: const EdgeInsets.all(BaseLayout.marginLayoutBase),
      decoration: BoxStyle.fromBoxDecoration(radius: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                width: 5.0,
                color: colorTTTT[invoice.TRANGTHAIHOADON],
                height: Responsive.height(100, context)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Kỳ ${invoice.KYHOADON}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        '${invoice.getTongTien()} đ',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Danh bộ',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            invoice.SODB ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'CS Cũ',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            invoice.CSCU.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'CS Mới',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            invoice.CSMOI.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'M3TT',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            invoice.M3TT.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        invoice.TRANGTHAI ?? '',
                        style: TextStyle(
                            color: colorTTTT[invoice.TRANGTHAIHOADON],
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      Text(
                        invoice.getNPHHD(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget mainView(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: DropdownButton<Bill>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        onChanged: (Bill? newValue) {
                          if (newValue != null) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          }
                        },
                        isExpanded: true,
                        items: dropdownList
                            .map<DropdownMenuItem<Bill>>((Bill value) {
                          return DropdownMenuItem<Bill>(
                            value: value,
                            child: Text(value.getSelectItem(), style: TextStyle(
                            fontWeight: value == dropdownValue
                                ? FontWeight.bold
                                : FontWeight.normal),),
                          );
                        }).toList(),
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Từ tháng:',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            _buttonDatePicket(
                              context,
                              label: formatDate(fromMonthSelected),
                              tag: TAG_FROM_MONTH,
                            )
                          ],
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Đến tháng:',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            _buttonDatePicket(
                              context,
                              label: formatDate(toMonthSelected),
                              tag: TAG_TO_MONTH,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              OutlinedButton(
                onPressed: () {
                  searchInvoice();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                      color: Colors.white,
                      width: 2.0), // Make border blue and 2.0 in width
                  minimumSize:
                      const Size(double.infinity, 48), // Make button full width
                  backgroundColor:
                      Colors.transparent, // Make background transparent
                ),
                child: const Text(
                  'Tra cứu',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              showPayment
                  ? Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ElevatedButton(
                        onPressed: () {
                          launchUrlString(urlVNPAY);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Thanh toán trực tuyến',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Expanded(
            child: isLoadInvoice
                ? BaseLayout.loadingView(context)
                : SingleChildScrollView(
                    child: Column(
                      children: listInvoiceRs
                          .map(
                              (toElement) => listBillResult(context, toElement))
                          .toList(),
                    ),
                  ))
      ],
    );
  }

  Widget loadWidget(BuildContext context) {
    if (billProvider.listBill.isEmpty) {
      return FutureBuilder(
          future: billProvider.futureBills(context),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              dropdownList = snapshot.data ?? [];
              dropdownValue = dropdownList.first;
              return mainView(context);
            }
            return BaseLayout.loadingView(context);
          });
    }
    return mainView(context);
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
      context: context,
      title: 'Tra cứu Hóa đơn',
      actions: [
        IconButton(
            icon: const Icon(
              Icons.bar_chart_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const InvoiceChartView(),
              ));
            },
          ),
      ],
      body: loadWidget(context),
    );
  }
}
