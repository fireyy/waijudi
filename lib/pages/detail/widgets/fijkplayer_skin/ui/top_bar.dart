import 'package:flutter/material.dart';
import './back_btn.dart';
import '../config.dart';

Widget buildTopBar (widget) {
  return SizedBox(
    height: barHeight,
    child: Row(
      children: <Widget>[
        buildTopBackBtn(widget),
        Expanded(
          child: Text(
            widget.playerTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    ),
  );
}