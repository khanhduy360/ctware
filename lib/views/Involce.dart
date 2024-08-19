import 'dart:async';

import 'package:ctware/configs/extendtion/box_extendtion.dart';
import 'package:ctware/configs/month_year_picker_custom.dart';
import 'package:ctware/configs/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AddInvolce.dart';
import 'InvolceLookUp.dart';
import 'container/Bottombar.dart';
import 'package:intl/intl.dart';

class InvoiceListScreen extends StatefulWidget {
  const InvoiceListScreen({super.key});

  @override
  State<InvoiceListScreen> createState() => _InvoiceListScreenState();
}

class _InvoiceListScreenState extends State<InvoiceListScreen> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Trang chủ', 'assets/icons/ic_home.png', Colors.teal),
    Destination(1, 'Tin tức', 'assets/icons/ic_news.png', Colors.cyan),
    Destination(2, 'Thông báo', 'assets/icons/ic_notify.png', Colors.orange),
    Destination(3, 'Tài khoản', 'assets/icons/ic_user.png', Colors.blue),
  ];
  int selectedIndex = 0;
  String dropdownValue = '65642 - NGUYỄN VĂN A';
  DateTime? fromMonthSelected;
  DateTime? toMonthSelected;
  // ignore: non_constant_identifier_names
  final TAG_FROM_MONTH = 'key_tag_button_1';
  // ignore: non_constant_identifier_names
  final TAG_TO_MONTH = 'key_tag_button_2';

  @override
  void initState() {
    super.initState();
    fromMonthSelected = DateTime.now();
    toMonthSelected = DateTime.now();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Future<void> _onPressedDatePicker(String tag) async {
    DateTime? initialDate = tag == TAG_FROM_MONTH ? fromMonthSelected : toMonthSelected;
    final selected = await showMonthYearPicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2030),
      locale: const Locale('vi', 'VN'),
      initialMonthYearPickerMode: MonthYearPickerMode.month
    );
    if (selected != null) {
      setState(() {
        if(tag == TAG_FROM_MONTH) {
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

  Widget _buttonDatePicket(context, {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tra cứu Hóa đơn',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddInvoiceScreen()),
              );
              // Handle add action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
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
                        child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.transparent,
                          ),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            }
                          },
                          isExpanded: true,
                          items: <String>[
                            '65642 - NGUYỄN VĂN A',
                            'Tài khoản 2',
                            'Tài khoản 3',
                            'Tài khoản 4'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Divider(color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Từ tháng:',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
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
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
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
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InvoiceLookUp()),
                  );
                  // Handle button press
                },
                child: Text(
                  'Tra cứu',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white, width: 2.0), // Make border blue and 2.0 in width
                  minimumSize: Size(double.infinity, 48), // Make button full width
                  backgroundColor: Colors.transparent, // Make background transparent
                ),

                )
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // Ensure the row takes the full height of its parent
              children: [
                Container(
                  width: 5.0,
                  height: 100, // Width of the green side stripe
                  color: Colors.green,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Kỳ 04-2024',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              '49.655 đ',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Danh bộ', style: TextStyle(fontSize: 16),),
                                Text(
                                  '877026A',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('CS Cũ', style: TextStyle(fontSize: 16),),
                                Text(
                                  '25',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('CS Mới', style: TextStyle(fontSize: 16),),
                                Text(
                                  '30',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('M3TT', style: TextStyle(fontSize: 16),),
                                Text(
                                  '5',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Đã thanh toán',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                              ),
                            ),
                            Text(
                              '17/04/2024',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: selectedIndex,
        onItemTapped: _onItemTapped,
        allDestinations: allDestinations,
      ),
    );
  }
}
