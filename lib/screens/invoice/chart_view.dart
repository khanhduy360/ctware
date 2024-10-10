import 'package:ctware/model/invoice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rss_dart/util/helpers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData({
    required this.month,
    required this.year,
    required this.vnd,
    required this.useWater,
  });

  final int month;
  final int year;
  final double vnd;
  final double useWater;

  String getTime() {
    return '$month/$year';
  }

  static List<ChartData> converInvoiceToChartData(List<Invoice> listInvoice) {
    List<ChartData> rs = [];
    for(var invoice in listInvoice) {
      rs.add(ChartData(
        month: invoice.THANG,
        year: invoice.NAM,
        vnd: invoice.TONGCONG.toDouble(),
        useWater: invoice.M3TT.toDouble()
      ));
    }
    if(rs.length < 12) {
      final lastValue = rs.last;
      var currentMonth = lastValue.month;
      var currentYear = lastValue.year;
      for (var i = rs.length; i < 12; i++) {
        if(currentMonth < 1) {
          currentMonth = 12;
          currentYear--;
        }
        rs.add(ChartData(month: currentMonth, year: currentYear, vnd: 0, useWater: 0));
      }
    }
    return rs;
  }

  static Map getMoneyConfigChart(List<ChartData> listData, month) {
    // default config
    final moneyConfig = MoneyConfigChart(min: 0, max: 5000000, step: 500000);
    final useWaterConfig = UseWaterConfigChart(min: 0, max: 200, step: 20);
    RegExp regExp = RegExp(r'\d+');
    final numMonth = parseInt(regExp.stringMatch(month)) ?? 0;
    final listBreak = <ChartData>[];
    for (var i = 0; i < numMonth; i++) {
        listBreak.add(listData[i]);
    }
    double maxMoney = listBreak.reduce((a, b) => a.vnd > b.vnd ? a : b).vnd;
    maxMoney = ((maxMoney + 99999) / 100000).floor() * 100000;
    moneyConfig.max = maxMoney;
    double stepMoney = (maxMoney / 10).ceil().toDouble();
    moneyConfig.step = stepMoney;
    double maxUserWater = listBreak.reduce((a, b) => a.useWater > b.useWater ? a : b).useWater;
    maxUserWater = ((maxUserWater + 99) / 100).floor() * 100;
    useWaterConfig.max = maxUserWater;
    double stepUserWater = (maxUserWater / 10).ceil().toDouble();
    useWaterConfig.step = stepUserWater;
    return {'moneyConfig': moneyConfig, 'useWaterConfig': useWaterConfig};
  }

  static List<ChartData> renderData(List<ChartData> listData, month) {
    RegExp regExp = RegExp(r'\d+');
    final numMonth = parseInt(regExp.stringMatch(month)) ?? 0;
    return listData.sublist(0, numMonth).reversed.toList();
  }
}

/// min: giá trị nhỏ nhất của trục
/// max: giá trị lớn nhất của trục
/// step: khoản cách giữa tọa độ trong trục

class TimeConfigChart {
  TimeConfigChart({required this.min, required this.max, required this.step});

  double min, max, step;
}

class MoneyConfigChart {
  MoneyConfigChart({required this.min, required this.max, required this.step});

  double min, max, step;
}

class UseWaterConfigChart {
  UseWaterConfigChart({required this.min, required this.max, required this.step});

  double min, max, step;
}

// Render Chart
class ChartView extends StatelessWidget {
  const ChartView(
      {super.key,
      required this.data,
      required this.timeConfigChart,
      required this.moneyConfigChart,
      required this.useWaterConfigChart});

  final List<ChartData> data;
  final TimeConfigChart timeConfigChart;
  final MoneyConfigChart moneyConfigChart;
  final UseWaterConfigChart useWaterConfigChart;

  static Color colorBar = const Color.fromARGB(255, 218, 168, 4);
  static Color colorLine = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        // Trục x: trục thời gian
        primaryXAxis: CategoryAxis(
          minimum: timeConfigChart.min,
          maximum: timeConfigChart.max,
          interval: timeConfigChart.step,
          labelStyle: const TextStyle(fontSize: 8),
          labelRotation: 50,
        ),
        // Trục y1: trục tiền
        primaryYAxis: NumericAxis(
          minimum: moneyConfigChart.min,
          maximum: moneyConfigChart.max,
          interval: moneyConfigChart.step,
          labelStyle: const TextStyle(fontSize: 10),
          numberFormat: NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0),
        ),
        axes: [
          // Trục y2: trục khối nước
          NumericAxis(
              opposedPosition: true,
              name: 'y1Axis',
              majorGridLines: const MajorGridLines(width: 0),
              labelFormat: '{value}',
              minimum: useWaterConfigChart.min,
              maximum: useWaterConfigChart.max,
              labelStyle: const TextStyle(fontSize: 10),
              interval: useWaterConfigChart.step)
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.getTime(),
              yValueMapper: (ChartData data, _) => data.vnd,
              name: 'Số tiền(VNĐ)',
              color: colorBar),
          LineSeries<ChartData, String>(
              dataSource: data,
              yAxisName: 'y1Axis',
              xValueMapper: (ChartData data, _) => data.getTime(),
              yValueMapper: (ChartData data, _) => data.useWater,
              name: 'Số khối(m³)',
              color: colorLine)
        ]);
  }
}
