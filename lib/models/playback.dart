import 'package:flutter/material.dart';

class Playback {
  int vodId;
  String dramaId;
  int isEnd;
  int vodTime;
  int vodTimed;
  int vodLineId;
  String createtime;
  String updatetime;
  int id;
  String videoName;
  String videoPic;
  String vodRemarks;
  int proportion;

  Playback({
    this.vodId = 0,
    this.dramaId = '',
    this.isEnd = 0,
    this.vodTime = 0,
    this.vodTimed = 0,
    this.vodLineId = 0,
    this.createtime = '',
    this.updatetime = '',
    this.id = 0,
    this.videoName = '',
    this.videoPic = '',
    this.vodRemarks = '',
    this.proportion = 0,
  });

  Playback.fromJson(Map jsonMap)
    : vodId = jsonMap['vod_id'].toInt(),
      dramaId = jsonMap['drama_id'].toString(),
      isEnd = jsonMap['is_end'].toInt(),
      vodTime = jsonMap['vod_time'].toInt(),
      vodTimed = jsonMap['vod_timed'].toInt(),
      vodLineId = jsonMap['vod_line_id'].toInt(),
      createtime = jsonMap['createtime'].toString(),
      updatetime = jsonMap['updatetime'].toString(),
      id = jsonMap['id'].toInt(),
      videoName = jsonMap['video_name'].toString(),
      videoPic = jsonMap['video_pic'].toString(),
      vodRemarks = jsonMap['vod_remarks'].toString(),
      proportion = jsonMap['proportion'].toInt();
}

class CheckboxParams {
  void Function(int, bool) onChecked;
  bool isChecked;
  bool isShowCheckbox;
  void Function(String) onDismissed;
  
  CheckboxParams({
    required this.onChecked,
    this.isChecked = false,
    this.isShowCheckbox = false,
    required this.onDismissed,
  });
}