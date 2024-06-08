import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarLineChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bar and Line Chart'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarLineChartWidget(),
        ),
      ),
    );
  }
}

class BarLineChartWidget extends StatefulWidget {
  @override
  _BarLineChartWidgetState createState() => _BarLineChartWidgetState();
}

class _BarLineChartWidgetState extends State<BarLineChartWidget> {
  String _selectedFilter = '12 tháng';
  List<BarChartGroupData> _barGroups = [];
  List<FlSpot> _lineSpots = [];

  @override
  void initState() {
    super.initState();
    _updateChartData();
  }

  void _updateChartData() {
    setState(() {
      switch (_selectedFilter) {
        case '3 tháng':
          _barGroups = _buildBarGroups(3);
          _lineSpots = _buildLineSpots(3);
          break;
        case '6 tháng':
          _barGroups = _buildBarGroups(6);
          _lineSpots = _buildLineSpots(6);
          break;
        case '12 tháng':
          _barGroups = _buildBarGroups(12);
          _lineSpots = _buildLineSpots(12);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: _selectedFilter,
          items: ['3 tháng', '6 tháng', '12 tháng'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedFilter = newValue;
                _updateChartData();
              });
            }
          },
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1.7,
            child: Stack(
              children: <Widget>[
                BarChart(
                  BarChartData(
                    barGroups: _barGroups,
                    titlesData: _buildTitlesData(),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    barTouchData: BarTouchData(enabled: false),
                  ),
                ),
                LineChart(
                  LineChartData(
                    lineBarsData: [_buildLineChartData()],
                    titlesData: _buildTitlesData(),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                    lineTouchData: LineTouchData(enabled: false),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildBarGroups(int months) {
    return List.generate(months, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: (i + 1) * 100000.0,
            color: Colors.blue,
            width: 15,
          ),
        ],
      );
    });
  }

  List<FlSpot> _buildLineSpots(int months) {
    return List.generate(months, (i) {
      return FlSpot(i.toDouble(), (i + 1) * 2.0);
    });
  }

  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            );
            if (value.toInt() >= 1 && value.toInt() <= 10) {
              return Text(value.toInt().toString(), style: style);
            }
            return Container();
          },
          reservedSize: 40,
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            );
            int month = value.toInt() + 1;
            if (month >= 1 && month <= 12) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 12, // Tăng khoảng cách giữa các tiêu đề
                angle: -0.5, // Xoay các tiêu đề để tránh chồng chéo
                child: Text(month.toString(), style: style),
              );
            }
            return Container();
          },
          reservedSize: 40,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            );
            if (value % 200000 == 0) {
              return Text(value.toInt().toString(), style: style);
            }
            return Container();
          },
          reservedSize: 40,
        ),
      ),
    );
  }

  LineChartBarData _buildLineChartData() {
    return LineChartBarData(
      spots: _lineSpots,
      isCurved: true,
      color: Colors.red,
      barWidth: 4,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }
}
