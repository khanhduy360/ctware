import 'package:ctware/configs/extendtion/box_extendtion.dart';
import 'package:ctware/configs/responsive.dart';
import 'package:ctware/views/chart/chart_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Testchart1 extends StatefulWidget {
  const Testchart1({super.key});

  @override
  State<Testchart1> createState() => _Testchart1State();
}

class _Testchart1State extends State<Testchart1> {
  late List<ChartData> dataSelect;
  late List<ChartData> data1;
  late List<ChartData> data2;
  late List<ChartData> data3;
  late TimeConfigChart timeConfigChart;
  late MoneyConfigChart moneyConfigChart;
  late UseWaterConfigChart useWaterConfigChart;

  String selectedInvoice = 'Hóa đơn 1';
  List<String> invoiceItems = ['Hóa đơn 1', 'Hóa đơn 2', 'Hóa đơn 3'];
  String selectedCol = '6 tháng';
  List<String> colItems = ['3 tháng', '6 tháng', '12 tháng'];

  @override
  void initState() {
    // Mock
    data1 = [
      ChartData('1/2024', 12000, 4),
      ChartData('2/2024', 22000, 2),
      ChartData('3/2024', 2000, 7),
      ChartData('4/2024', 42000, 6),
      ChartData('5/2024', 9000, 7),
      ChartData('6/2024', 32000, 5),
      ChartData('7/2024', 12000, 5),
      ChartData('8/2024', 2000, 3),
      ChartData('9/2024', 9000, 8),
      ChartData('10/2024', 13000, 7),
      ChartData('11/2024', 25000, 7),
      ChartData('12/2024', 31000, 5),
    ];
    data2 = [
      ChartData('1/2024', 19000, 1),
      ChartData('2/2024', 42000, 6),
      ChartData('3/2024', 22000, 5),
      ChartData('4/2024', 12000, 2),
      ChartData('5/2024', 9000, 7),
      ChartData('6/2024', 15000, 4),
      ChartData('7/2024', 22000, 7),
      ChartData('8/2024', 3000, 3),
      ChartData('9/2024', 2000, 3),
      ChartData('10/2024', 3000, 2),
      ChartData('11/2024', 4000, 1),
      ChartData('12/2024', 32000, 5),
    ];
    data3 = [
      ChartData('1/2024', 12000, 2),
      ChartData('2/2024', 22000, 2),
      ChartData('3/2024', 9000, 9),
      ChartData('4/2024', 26000, 5),
      ChartData('5/2024', 7000, 8),
      ChartData('6/2024', 36000, 4),
      ChartData('7/2024', 43000, 5),
      ChartData('8/2024', 22000, 5),
      ChartData('9/2024', 12000, 6),
      ChartData('10/2024', 13000, 3),
      ChartData('11/2024', 22000, 7),
      ChartData('12/2024', 26000, 7),
    ];
    timeConfigChart = TimeConfigChart(min: 0, max: 5, step: 1);
    moneyConfigChart = MoneyConfigChart(min: 0, max: 50000, step: 5000);
    useWaterConfigChart = UseWaterConfigChart(min: 0, max: 10, step: 1);
    dataSelect = data1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 152, 201, 240),
          title: const Text('Thống kê sử dụng nước'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxStyle.fromBoxDecoration(radius: 15),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedInvoice,
                  items: invoiceItems.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontWeight: value == selectedInvoice
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      // Event click chọn hóa đơn
                      selectedInvoice = newValue ?? '';
                      if (selectedInvoice == 'Hóa đơn 1') {
                        dataSelect = data1;
                      }
                      if (selectedInvoice == 'Hóa đơn 2') {
                        dataSelect = data2;
                      }
                      if (selectedInvoice == 'Hóa đơn 3') {
                        dataSelect = data3;
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    const Text('Thời gian: '),
                    DropdownButton<String>(
                      value: selectedCol,
                      items: colItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(
                                fontWeight: value == selectedCol
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          //Event click chọn tháng
                          selectedCol = newValue ?? '';
                          if (selectedCol == '3 tháng') {
                            timeConfigChart.max = 2;
                          }
                          if (selectedCol == '6 tháng') {
                            timeConfigChart.max = 5;
                          }
                          if (selectedCol == '12 tháng') {
                            timeConfigChart.max = 11;
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                height: Responsive.height(5, context),
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('VNĐ', style: TextStyle(fontSize: 15)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: ChartView.colorBar,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(' Tổng tiền (VNĐ)',
                                style: TextStyle(fontSize: 15))
                          ],
                        ),
                        const SizedBox(width: 15),
                        Row(
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: ChartView.colorLine,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Text(' Sản lượng (m³)',
                                style: TextStyle(fontSize: 15))
                          ],
                        )
                      ],
                    ),
                    Text('cm³', style: TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              Expanded(
                  child: ChartView(
                data: dataSelect,
                timeConfigChart: timeConfigChart,
                moneyConfigChart: moneyConfigChart,
                useWaterConfigChart: useWaterConfigChart,
              )),
            ],
          ),
        ));
  }
}
