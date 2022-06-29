import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';

class OrganicButton extends StatelessWidget {

  final VoidCallback action;
  final String label;
  final IconData icon;
  const OrganicButton(this.action, this.label, this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: action,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        backgroundColor: AppColors.WHITE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.DARK,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.LIGHT_GREEN,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              icon,
              color: AppColors.WHITE,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
