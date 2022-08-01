import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/models/section.dart';
import 'package:waijudi/widgets/list_videos.dart';

class ListSections extends StatelessWidget {
  final Section data;
  final Function(int, String) handleMore;
  const ListSections(this.data, {Key? key, required this.handleMore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 25,
            right: 25,
            bottom: 10,
          ),
          child: GestureDetector(
            onTap: () {
              handleMore(data.id, data.name);
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(data.name, style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.DARK,
                  )),
                ),
                Text('更多»', style: TextStyle(
                  fontSize: 14,
                  color: AppColors.DARK,
                )),
              ],
            )
          ),
        ),
        VideoList(data.video)
      ]
    );
  }
}