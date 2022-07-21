import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';

class ItemRank extends StatelessWidget {
  final String rank;
  final bool selected;
  final Function(String) onSelect;

  const ItemRank(this.rank, this.selected, {Key? key, required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(rank),
      child: Text(
        rank,
        style: TextStyle(
          fontSize: selected ? 20 : 16,
          fontWeight: FontWeight.bold,
          color: selected ? AppColors.DARK : AppColors.DARK.withOpacity(0.3),
        ),
      ),
    );
  }
}
