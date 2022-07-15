import 'package:flutter/material.dart';
import 'dart:ui';

double speed = 1.0;
const double barHeight = 50.0;
final double barFillingHeight =
    MediaQueryData.fromWindow(window).padding.top + barHeight;
final double barGap = barFillingHeight - barHeight;

abstract class ShowConfigAbs {
  late bool nextBtn;
  late bool speedBtn;
  late bool drawerBtn;
  late bool lockBtn;
  late bool topBar;
  late bool autoNext;
  late bool bottomPro;
  late bool stateAuto;
  late bool isAutoPlay;
}