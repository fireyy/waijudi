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
  String? vodBlurb;
  String? vodActor;

  VideoItem({
    this.id = 0,
    this.typeId = 0,
    this.name = '',
    this.vodSub = '',
    this.isVip = 0,
    this.playbackTimes = 0,
    this.vodPic = '',
    this.vodDoubanScore = '',
    this.vodRemarks = '',
    this.vodBlurb,
    this.vodActor,
  });

  VideoItem.fromJson(Map jsonMap)
    : id = jsonMap['id'].toInt(),
      typeId = jsonMap['type_id'].toInt(),
      name = jsonMap['name'].toString(),
      vodSub = jsonMap['vod_sub'].toString(),
      isVip = jsonMap['is_vip'].toInt(),
      playbackTimes = jsonMap['playback_times'].toInt(),
      vodPic = jsonMap['vod_pic'].toString(),
      vodDoubanScore = (jsonMap['vod_douban_score'] ?? '').toString(),
      vodRemarks = jsonMap['vod_remarks'].toString(),
      vodBlurb = (jsonMap['vod_blurb'] ?? '').toString(),
      vodActor = (jsonMap['vod_actor'] ?? '').toString();  
}