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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            rank,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: selected ? AppColors.DARK : AppColors.DARK.withOpacity(0.3),
            ),
          ),
          Visibility(
            visible: selected,
            child: Container(
              margin: const EdgeInsets.only(top: 3),
              width: 32,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.DARK,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
