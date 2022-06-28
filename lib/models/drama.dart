class Drama {
  int id;
  int vodId;
  int vodLineId;
  String vodDramaUrl;
  String dramaName;
  String dramaCode;
  String createtime;
  String updatetime;
  String hd;
  String viewingRights;
  String vodTimed;
  String isEnd;

  Drama({
    this.id = 0,
    this.vodId = 0,
    this.vodLineId = 0,
    this.vodDramaUrl = '',
    this.dramaName = '',
    this.dramaCode = '',
    this.createtime = '',
    this.updatetime = '',
    this.hd = '',
    this.viewingRights = '',
    this.vodTimed = '',
    this.isEnd = '',
  });

  Drama.fromJson(Map jsonMap)
    : id = jsonMap['id'].toInt(),
      vodId = jsonMap['vod_id'].toInt(),
      vodLineId = jsonMap['vod_line_id'].toInt(),
      vodDramaUrl = jsonMap['vod_drama_url'].toString(),
      dramaName = jsonMap['drama_name'].toString(),
      dramaCode = jsonMap['drama_code'].toString(),
      createtime = jsonMap['createtime'].toString(),
      updatetime = jsonMap['updatetime'].toString(),
      hd = (jsonMap['hd'] ?? '').toString(),
      viewingRights = jsonMap['viewing_rights'].toString(),
      vodTimed = (jsonMap['vod_timed'] ?? '').toString(),
      isEnd = (jsonMap['is_end'] ?? '').toString();
}