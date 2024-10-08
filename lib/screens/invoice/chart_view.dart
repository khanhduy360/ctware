import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  ChartData(this.time, this.vnd, this.useWater);

  final String time;
  final double vnd;
  final double useWater;
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

  static Color colorBar = Colors.blue;
  static Color colorLine = Colors.red;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        // Trục x: trục thời gian
        primaryXAxis: CategoryAxis(
          minimum: timeConfigChart.min,
          maximum: timeConfigChart.max,
          interval: timeConfigChart.step,
          labelRotation: 50,
        ),
        // Trục y1: trục tiền
        primaryYAxis: NumericAxis(
          minimum: moneyConfigChart.min,
          maximum: moneyConfigChart.max,
          interval: moneyConfigChart.step,
          numberFormat: NumberFormat.currency(locale: 'vi_VN', symbol: '', decimalDigits: 0),
        ),
        axes: [
          // Trục y2: trục khối nước
          NumericAxis(
              opposedPosition: true,
              name: 'y1Axis',
              majorGridLines: MajorGridLines(width: 0),
              labelFormat: '{value}',
              minimum: useWaterConfigChart.min,
              maximum: useWaterConfigChart.max,
              interval: useWaterConfigChart.step)
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <CartesianSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.time,
              yValueMapper: (ChartData data, _) => data.vnd,
              name: 'Số tiền(VNĐ)',
              color: colorBar),
          LineSeries<ChartData, String>(
              dataSource: data,
              yAxisName: 'y1Axis',
              xValueMapper: (ChartData data, _) => data.time,
              yValueMapper: (ChartData data, _) => data.useWater,
              name: 'Số khối(cm³)',
              color: colorLine)
        ]);
  }
}
