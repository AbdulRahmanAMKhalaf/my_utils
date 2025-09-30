import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,

    required this.isText,
    required this.onPressed,
    this.alignment = Alignment.center,
    this.text,
    this.icon,
    this.iconColor,
    this.iconSize, 
  });

  final void Function()? onPressed;
  final bool isText;
  final String? text;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: isText
          ? Text(text!)
          : Icon(icon, color: iconColor, size: iconSize),
    );
  }
}
