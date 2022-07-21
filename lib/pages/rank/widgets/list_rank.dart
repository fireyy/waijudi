import 'package:flutter/material.dart';

import 'item_rank.dart';

class ListRanks extends StatelessWidget {
  final List<String> ranks;
  final String selectedRank;
  final Function(String) onSelect;

  const ListRanks({Key? key, required this.ranks, required this.selectedRank, required this.onSelect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...(
            ranks.map((rank) => ItemRank(rank, rank == selectedRank, onSelect: onSelect))
          )
        ],
      ),
    );
  }
}
