import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';

class CustomAppBarAction extends StatelessWidget {
  final VoidCallback action;
  final IconData icon;

  const CustomAppBarAction(this.action, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      enableFeedback: false,
      icon: Icon(
        icon,
        size: 21,
        color: AppColors.GREEN,
      ),
      onPressed: action,
    );
  }
}