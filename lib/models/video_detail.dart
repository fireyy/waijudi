import 'package:waijudi/models/filter.dart';

class VideoDetail {
  int id;
  int typeId;
  String name;
  String vodSub;
  String vodLogogram;
  String vodLetter;
  String vodRemarks;
  int totals;
  int serial;
  String vodDirector;
  String vodActor;
  String screenwriter;
  String vodDoubanScore;
  String vodDoubanId;
  int stateId;
  int status;
  int isVip;
  int yearId;
  int areaId;
  String vodPic;
  String vodBlurb;
  int playbackTimes;
  int collectionTimes;
  String vodContent;
  String createtime;
  String updatetime;
  int isPicture;
  String nameReversal;
  String vodClass;
  String viewingRights;
  int vodLineId;
  String dramaId;
  int vodTimed;
  int isEnd;
  String vodDramaUrl;
  int isCollection;
  String typeName;
  Filter? area;
  Filter? year;

  VideoDetail({
    this.id = 0,
    this.typeId = 0,
    this.name = '',
    this.vodSub = '',
    this.vodLogogram = '',
    this.vodLetter = '',
    this.vodRemarks = '',
    this.totals = 0,
    this.serial = 0,
    this.vodDirector = '',
    this.vodActor = '',
    this.screenwriter = '',
    this.vodDoubanScore = '',
    this.vodDoubanId = '',
    this.stateId = 0,
    this.status = 0,
    this.isVip = 0,
    this.yearId = 0,
    this.areaId = 0,
    this.vodPic = '',
    this.vodBlurb = '',
    this.playbackTimes = 0,
    this.collectionTimes = 0,
    this.vodContent = '',
    this.createtime = '',
    this.updatetime = '',
    this.isPicture = 0,
    this.nameReversal = '',
    this.vodClass = '',
    this.viewingRights = '',
    this.vodLineId = 0,
    this.dramaId = '',
    this.vodTimed = 0,
    this.isEnd = 0,
    this.vodDramaUrl = '',
    this.isCollection = 0,
    this.typeName = '',
    this.area,
    this.year,
  });

  factory VideoDetail.fromJson(Map jsonMap) {
    return VideoDetail(
      id: jsonMap['id'],
      typeId: jsonMap['type_id'],
      name: jsonMap['name'],
      vodSub: jsonMap['vod_sub'],
      vodLogogram: jsonMap['vod_logogram'],
      vodLetter: jsonMap['vod_letter'],
      vodRemarks: jsonMap['vod_remarks'],
      totals: jsonMap['totals'],
      serial: jsonMap['serial'],
      vodDirector: jsonMap['vod_director'] ?? '',
      vodActor: jsonMap['vod_actor'] ?? '',
      screenwriter: jsonMap['screenwriter'] ?? '',
      vodDoubanScore: jsonMap['vod_douban_score'],
      vodDoubanId: jsonMap['vod_douban_id'],
      stateId: jsonMap['state_id'],
      status: jsonMap['status'],
      isVip: jsonMap['is_vip'],
      yearId: jsonMap['year_id'],
      areaId: jsonMap['area_id'],
      vodPic: jsonMap['vod_pic'],
      vodBlurb: jsonMap['vod_blurb'] ?? '',
      playbackTimes: jsonMap['playback_times'],
      collectionTimes: jsonMap['collection_times'],
      vodContent: jsonMap['vod_content'] ?? '',
      createtime: jsonMap['createtime'],
      updatetime: jsonMap['updatetime'],
      isPicture: jsonMap['is_picture'],
      nameReversal: jsonMap['name_reversal'] ?? '',
      vodClass: jsonMap['vod_class'],
      viewingRights: jsonMap['viewing_rights'],
      vodLineId: jsonMap['vod_line_id'] ?? 0,
      dramaId: jsonMap['drama_id'] ?? '',
      vodTimed: jsonMap['vod_timed'],
      isEnd: jsonMap['is_end'],
      vodDramaUrl: jsonMap['vod_drama_url'] ?? '',
      isCollection: jsonMap['is_collection'],
      typeName: jsonMap['type_name'],
      area: Filter.fromJson(jsonMap['area']),
      year: Filter.fromJson(jsonMap['year']),
    );
  }
}