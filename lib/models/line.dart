class LineModel {
  int vodLineId;
  String name;
  String vodDramaUrl;
  bool isEncryption;

  LineModel({
    this.vodLineId = 0,
    this.name = '',
    this.vodDramaUrl = '',
    this.isEncryption = false,
  });

  LineModel.fromJson(Map jsonMap)
    : vodLineId = jsonMap['vod_line_id'].toInt(),
      name = jsonMap['name'].toString(),
      vodDramaUrl = jsonMap['vod_drama_url'].toString(),
      isEncryption = jsonMap['is_encryption'].toString() == '1';
}
