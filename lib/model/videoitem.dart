class VideoItem {
  int id;
  int typeId;
  String name;
  String vodSub;
  int isVip;
  int playbackTimes;
  String vodPic;
  String vodDoubanScore;
  String vodRemarks;

  VideoItem.fromJson(Map jsonMap)
    : id = jsonMap['id'].toInt(),
      typeId = jsonMap['type_id'].toInt(),
      name = jsonMap['name'].toString(),
      vodSub = jsonMap['vod_sub'].toString(),
      isVip = jsonMap['is_vip'].toInt(),
      playbackTimes = jsonMap['playback_times'].toInt(),
      vodPic = jsonMap['vod_pic'].toString(),
      vodDoubanScore = jsonMap['vod_douban_score'].toString(),
      vodRemarks = jsonMap['vod_remarks'].toString();  
}