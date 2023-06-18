import 'package:flutter/material.dart';

class Iconbuttons extends StatelessWidget {
  const Iconbuttons(
      {super.key,
      required this.icon,
      required this.iconId,
      required this.style});
  final Widget icon;
  final String iconId;
  final ButtonStyle style;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: icon,
      style: style,
    );
  }
}
