import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';

class LineButton extends StatelessWidget {
  final String label;
  final VoidCallback action;
  final bool selected;
  const LineButton(this.label, this.action, this.selected, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: action,
      style: AppColors.lineButton,
      child: Text(label, style: TextStyle(color: selected ? AppColors.GREEN : Colors.black)),
    );
  }
}
