import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';

class CustomAppBarAction extends StatelessWidget {
  final VoidCallback action;
  final IconData icon;

  const CustomAppBarAction(this.action, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 30,
      child: IconButton(
        padding: EdgeInsets.zero,
        enableFeedback: false,
        splashRadius: 1,
        icon: Icon(
          icon,
          size: 24,
          color: AppColors.DARK,
        ),
        onPressed: action,
      )
    );
  }
}