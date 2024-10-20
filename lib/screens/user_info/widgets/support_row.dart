import 'package:ctware/configs/Colors.dart';
import 'package:flutter/material.dart';

class SupportRow extends StatelessWidget {
  final String leftTitle;
  final String rightTitle;
  final String icon;

  const SupportRow({
    super.key,
    required this.leftTitle,
    required this.rightTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Text(
            leftTitle,
            style: const TextStyle(fontSize: 16),
          ),
          Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 8),
                alignment: Alignment.centerRight,
                child: Text(
                            rightTitle,
                            style: const TextStyle(fontSize: 14, color: AppColors.txtPrimary),
                          ),
              )),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: SizedBox(
                height: 20,
                width: 20,
                child: Image.asset(
                  icon,
                  fit: BoxFit.fill,
                )),
          )
        ],
      ),
    );
  }
}
