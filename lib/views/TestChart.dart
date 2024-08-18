import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'container/Bottombar.dart';

class BarLineChart extends StatefulWidget {

  @override
  State<BarLineChart> createState() => _BarLineChartState();
}

class _BarLineChartState extends State<BarLineChart> {
  static const List<Destination> allDestinations = <Destination>[
    Destination(0, 'Trang chủ', 'assets/icons/ic_home.png', Colors.teal),
    Destination(1, 'Tin tức', 'assets/icons/ic_news.png', Colors.cyan),
    Destination(2, 'Thông báo', 'assets/icons/ic_notify.png', Colors.orange),
    Destination(3, 'Tài khoản', 'assets/icons/ic_user.png', Colors.blue),
  ];
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thống kê sử dụng nước',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarLineChartWidget(),
        ),
      ),
      bottomNavigationBar:   CustomBottomNavigationBar(
      selectedIndex: selectedIndex,
      onItemTapped: _onItemTapped,
      allDestinations: allDestinations,
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
  String _selectedFilterUser = 'Nguyễn Văn A';
  List<BarChartGroupData> _barGroups = [];
  List<FlSpot> _lineSpots = [];


  @override
  void initState() {
    super.initState();
    _updateChartData();
  }

  void _updateChartData() {
    final jsonData12 = '''[
      {"time": 1, "cost": 130, "value": 6},
      {"time": 2, "cost": 250, "value": 11},
      {"time": 3, "cost": 55, "value": 3},
      {"time": 4, "cost": 500, "value": 22},
      {"time": 5, "cost": 500, "value": 22},
      {"time": 6, "cost": 55, "value": 3},
      {"time": 7, "cost": 130, "value": 6},
      {"time": 8, "cost": 500, "value": 22},
      {"time": 9, "cost": 250, "value": 11},
      {"time": 10, "cost": 130, "value": 6},
      {"time": 11, "cost": 130, "value": 6},
      {"time": 12, "cost": 55, "value": 3}
    ]''';

    // final jsonData6 = '''[
    //   {"time": 1, "cost": 130, "value": 6},
    //   {"time": 2, "cost": 250, "value": 11},
    //   {"time": 3, "cost": 55, "value": 3},
    //   {"time": 4, "cost": 500, "value": 22},
    //   {"time": 5, "cost": 500, "value": 22},
    //   {"time": 6, "cost": 55, "value": 3}
    //
    // ]''';
    // final jsonData3 = '''[
    //   {"time": 1, "cost": 130, "value": 6},
    //   {"time": 2, "cost": 250, "value": 11},
    //   {"time": 3, "cost": 55, "value": 3},
    //
    // ]''';

    final data12 = json.decode(jsonData12);
    // final data6 = json.decode(jsonData6);
    // final data3 = json.decode(jsonData3);

    setState(() {
      // if(_selectedFilter.contains('6 Tháng')){
      //   _barGroups = _buildBarGroups(data6);
      //   _lineSpots = _buildLineSpots(data6);
      // } else if (_selectedFilter.contains('3 Tháng')){
      //   _barGroups = _buildBarGroups(data3);
      //   _lineSpots = _buildLineSpots(data3);
      // } else {
      _barGroups = _buildBarGroups(data12);
      _lineSpots = _buildLineSpots(data12);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              DropdownButton<String>(
                value: _selectedFilterUser,
                items: ['Nguyễn Văn A', 'Nguyễn Văn B', 'Nguyễn Văn C']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedFilterUser = newValue;
                      //_updateChartData();
                    });
                  }
                },
              ),
            ],
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.5,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 600, // Set height for BarChart
                    width: 300,
                    child: BarChart(
                      BarChartData(
                        barGroups: _barGroups,
                        titlesData: _buildBarTitlesData(),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        gridData: FlGridData(show: false),
                        barTouchData: BarTouchData(enabled: false),
                      ),
                    ),
                  ),
                  Container(
                    height: 600, // Set height for LineChart
                    width: 350,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [_buildLineChartData()],
                        titlesData: _buildLineTitlesData(),
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        lineTouchData: LineTouchData(enabled: false),
                        minX: -2,
                        maxX: 14,
                        minY: -2.5,
                        maxY: 25, // Adjust based on your data range
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }

  List<BarChartGroupData> _buildBarGroups(List<dynamic> data) {
    return data.map<BarChartGroupData>((item) {
      return BarChartGroupData(
        barsSpace: 4, // Giảm khoảng cách giữa các cột
        x: item['time'],
        barRods: [
          BarChartRodData(
            toY: item['cost'].toDouble(),
            color: Colors.blue,
            width: 8, // Thu nhỏ chiều rộng cột
          ),
        ],
      );
    }).toList();
  }

  List<FlSpot> _buildLineSpots(List<dynamic> data) {
    return data.map<FlSpot>((item) {
      return FlSpot(item['time'].toDouble(), item['value'].toDouble());
    }).toList();
  }

  FlTitlesData _buildBarTitlesData() {
    return FlTitlesData(
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 10,
            );
            int month = value.toInt();
            if (month >= 1 && month <= 12) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 8, // Increase spacing between titles
                angle: -0.5, // Rotate titles to avoid overlapping
                child: Text(month.toString(), style: style),
              );
            }
            return Container();
          },
          reservedSize: 60,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            );
            if (value % 100 == 0) {
              // Adjust this condition to fit your data scale
              return Text(value.toInt().toString(), style: style);
            }
            return Container();
          },
          reservedSize: 50,
        ),
      ),
    );
  }

  FlTitlesData _buildLineTitlesData() {
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
              fontWeight: FontWeight.normal,
              fontSize: 12,
            );
            if (value % 5 == 0) {
              // Adjust this condition to fit your data scale
              return Text(value.toInt().toString(), style: style);
            }
            return Container();
          },
          reservedSize: 20,
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 12,
            );
            int month = value.toInt();
            if (month >= 1 && month <= 12) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 12, // Increase spacing between titles
                angle: -0.5, // Rotate titles to avoid overlapping
                child: Text(month.toString(), style: style),
              );
            }
            return Container();
          },
          reservedSize: 20,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
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
