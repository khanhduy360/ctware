import 'package:ctware/model/bill.dart';
import 'package:ctware/model/invoice.dart';
import 'package:ctware/provider/bill_provider.dart';
import 'package:ctware/screens/invoice_search/chart_view.dart';
import 'package:ctware/theme/base_layout.dart';
import 'package:ctware/theme/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InvoiceChartView extends StatefulWidget {
  const InvoiceChartView({super.key});

  @override
  State<InvoiceChartView> createState() => _InvoiceChartViewState();
}

class _InvoiceChartViewState extends State<InvoiceChartView> {
  late TimeConfigChart timeConfigChart;
  late MoneyConfigChart moneyConfigChart;
  late UseWaterConfigChart useWaterConfigChart;

  String selectedCol = '6 tháng';
  List<String> colItems = ['3 tháng', '6 tháng', '12 tháng'];
  late BillProvider billProvider;
  List<Bill> dropdownList = <Bill>[];
  late Bill dropdownValue;
  late List<ChartData> dataSelect;
  late List<ChartData> dataRender;
  late Future<List<Invoice>> futureInvoicesDataChart;

  bool isLoadChart = false;
  bool firstLoad = true;

  @override
  void initState() {
    billProvider = Provider.of<BillProvider>(context, listen: false);
    if (billProvider.listBill.isNotEmpty) {
      dropdownList = billProvider.listBill;
      dropdownValue = dropdownList.first;
    }
    futureInvoicesDataChart =
        billProvider.futureInvoicesDataChart(context, dropdownList.first.IDKH);
    timeConfigChart = TimeConfigChart(min: 0, max: 5, step: 1);
    super.initState();
  }

  calculateDataChart() {
    final config = ChartData.getMoneyConfigChart(dataSelect, selectedCol);
    moneyConfigChart = config['moneyConfig'];
    useWaterConfigChart = config['useWaterConfig'];
    dataRender = ChartData.renderData(dataSelect, selectedCol);
  }

  onSelectBill(Bill billChange) async {
    setState(() {
      isLoadChart = true;
      dropdownValue = billChange;
    });
    await billProvider
        .futureInvoicesDataChart(context, billChange.IDKH)
        .then((onValue) {
      if (onValue.isNotEmpty) {
        dataSelect = ChartData.converInvoiceToChartData(onValue);
        calculateDataChart();
      }
      setState(() {
        isLoadChart = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout.view(
        context: context,
        title: 'Thống kê sử dụng nước',
        body: FutureBuilder(
            future: futureInvoicesDataChart,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                if(firstLoad) {
                  dataSelect = ChartData.converInvoiceToChartData(snapshot.data!);
                  calculateDataChart();
                  firstLoad = false;
                }
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxStyle.fromBoxDecoration(radius: 15),
                        child: DropdownButton<Bill>(
                          isExpanded: true,
                          underline: Container(color: Colors.transparent),
                          value: dropdownValue,
                          items: dropdownList.map((Bill value) {
                            return DropdownMenuItem<Bill>(
                              value: value,
                              child: Text(
                                value.getSelectItem(),
                                style: TextStyle(
                                    fontWeight: value == dropdownValue
                                        ? FontWeight.bold
                                        : FontWeight.normal),
                              ),
                            );
                          }).toList(),
                          onChanged: (Bill? newValue) {
                            if (newValue != null) {
                              onSelectBill(newValue);
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
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
                                        calculateDataChart();
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: Responsive.height(5, context),
                              padding: const EdgeInsets.only(left: 15),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('VNĐ', style: TextStyle(fontSize: 15)),
                                  Text('m³', style: TextStyle(fontSize: 15)),
                                ],
                              ),
                            ),
                            Expanded(
                                child: isLoadChart
                                    ? BaseLayout.loadingView(context)
                                    : ChartView(
                                        data: dataRender,
                                        timeConfigChart: timeConfigChart,
                                        moneyConfigChart: moneyConfigChart,
                                        useWaterConfigChart:
                                            useWaterConfigChart,
                                      )),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: ChartView.colorBar,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const Text(' Tổng tiền (VNĐ)',
                                          style: TextStyle(fontSize: 12))
                                    ],
                                  ),
                                  const SizedBox(width: 15),
                                  Row(
                                    children: [
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: ChartView.colorLine,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const Text(' Sản lượng (m³)',
                                          style: TextStyle(fontSize: 12))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return BaseLayout.loadingView(context);
            }));
  }
}
