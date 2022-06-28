import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';

class CustomAppBarAction extends StatelessWidget {
  final VoidCallback action;
  final IconData icon;

  const CustomAppBarAction(this.action, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        width: 50,
        height: 50,
        child: TextButton(
          onPressed: action,
          style: TextButton.styleFrom(
             backgroundColor: AppColors.WHITE,
             padding: EdgeInsets.zero,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(32),
             )),
          child: Stack(
            children: <Widget>[
              Icon(
                icon,
                size: 21,
                color: AppColors.GREEN,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
