import 'package:flutter/material.dart';

class CustomPopupMenuItem extends StatelessWidget {
  final IconData popupItemIcon;
  final String popupItemText;
  static const color = Colors.black54;

  const CustomPopupMenuItem({
    super.key,
    required this.popupItemIcon,
    required this.popupItemText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(popupItemIcon, color: color),
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Text(
            popupItemText,
            style: const TextStyle(color: color),
          ),
        ),
      ],
    );
  }
}
