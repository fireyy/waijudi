import 'package:flutter/material.dart';
import 'package:waijudi/models/videoitem.dart';

import 'item_videos.dart';

class HomeList extends StatelessWidget {
  final List<VideoItem> videoItems;

  const HomeList(this.videoItems, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Text('data');
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 25,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        childAspectRatio: 270 / 383,
      ),
      itemCount: videoItems.length,
      itemBuilder: (BuildContext context, int index) {
        return ListItem(videoItems.elementAt(index));
      }
    );
  }
}
