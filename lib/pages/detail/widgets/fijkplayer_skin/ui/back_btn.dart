import 'package:flutter/material.dart';

Widget buildTopBackBtn(widget) {
  return IconButton(
    icon: const Icon(Icons.arrow_back_ios),
    padding: const EdgeInsets.only(
      left: 10.0,
      right: 10.0,
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    color: Colors.white,
    onPressed: () {
      // 判断当前是否全屏，如果全屏，退出
      if (widget.player.value.fullScreen) {
        widget.player.exitFullScreen();
      } else {
        if (widget.pageContent == null) return null;
        widget.player.stop();
        Navigator.pop(widget.pageContent!);
      }
    },
  );
}