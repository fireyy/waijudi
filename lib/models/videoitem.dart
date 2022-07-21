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
  String? createtime;
  String? typeName;
  int? stateId;
  int? rid;

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
    this.vodBlurb = '',
    this.vodActor = '',
    this.createtime = '',
    this.typeName = '',
    this.stateId = 0,
    this.rid = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type_id': typeId,
      'name': name,
      'vod_sub': vodSub,
      'is_vip': isVip,
      'playback_times': playbackTimes,
      'vod_pic': vodPic,
      'vod_douban_score': vodDoubanScore,
      'vod_remarks': vodRemarks,
      'vod_blurb': vodBlurb,
      'vod_actor': vodActor,
      'createtime': createtime,
      'type_name': typeName,
      'state_id': stateId,
      'rid': rid,
    };
  }

  VideoItem.fromJson(Map jsonMap)
    : id = jsonMap['id'].toInt(),
      typeId = jsonMap['type_id'].toInt(),
      name = jsonMap['name'].toString(),
      vodSub = jsonMap['vod_sub'].toString(),
      isVip = jsonMap['is_vip'].toInt(),
      playbackTimes = jsonMap['playback_times'].toInt(),
      vodPic = jsonMap['vod_pic'].toString(),
      vodDoubanScore = (jsonMap['vod_douban_score'] ?? '').toString(),
      vodRemarks = (jsonMap['vod_remarks'] ?? '').toString(),
      vodBlurb = (jsonMap['vod_blurb'] ?? '').toString(),
      vodActor = (jsonMap['vod_actor'] ?? '').toString(),
      createtime = (jsonMap['createtime'] ?? jsonMap['create_time'] ?? '').toString(),
      typeName = (jsonMap['type_name'] ?? '').toString(),
      stateId = jsonMap['state_id'] ?? 0,
      rid = jsonMap['rid'] ?? 0;
}