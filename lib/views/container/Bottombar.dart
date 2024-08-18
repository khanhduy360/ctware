import 'package:flutter/material.dart';

class Destination {
  const Destination(this.index, this.title, this.iconPath, this.color);

  final int index;
  final String title;
  final String iconPath;
  final Color color;
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final List<Destination> allDestinations;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.allDestinations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: allDestinations.map((Destination destination) {
        bool isSelected = allDestinations[selectedIndex].index == destination.index;
        return BottomNavigationBarItem(
          icon: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                destination.iconPath,
                color: isSelected ? destination.color : Colors.grey,
                height: 20,
              ),
              SizedBox(height: 4), // Điều chỉnh khoảng cách giữa icon và text
              Text(
                destination.title,
                style: TextStyle(
                  fontSize: 12, // Điều chỉnh kích thước font chữ
                  color: isSelected ? destination.color : Colors.grey,
                ),
              ),
            ],
          ),
          label: '',
        );
      }).toList(),
    );
  }
}
