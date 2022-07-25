import 'package:flutter/material.dart';
import 'package:waijudi/util/colors.dart';

List<Widget> buildEpisodeList(videoSourceTabs, curTabIdx, curActiveIdx, onPressed) {
  List<Widget> list = [];
  videoSourceTabs!.video!.asMap().keys.forEach((int tabIdx) {
    List<Widget> playListBtns = videoSourceTabs!.video![tabIdx]!.list!
        .asMap()
        .keys
        .map<Widget>((int activeIdx) {
      return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(
                tabIdx == curTabIdx && activeIdx == curActiveIdx
                    ? AppColors.LIGHT_GREEN
                    : AppColors.LIGHT_GREY),
          ),
          onPressed: () => onPressed(tabIdx, activeIdx),
          child: Text(
            videoSourceTabs!.video![tabIdx]!.list![activeIdx]!.name!,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }).toList();
    //
    list.add(
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Wrap(
            direction: Axis.horizontal,
            children: playListBtns,
          ),
        ),
      ),
    );
  });
  return list;
}