import 'package:waijudi/models/videoitem.dart';

class Section {
  int id;
  String name;
  List<VideoItem> video = [];

  Section({this.id = 0, this.name = ''});

  Section.fromJson(Map jsonMap)
    : id = (jsonMap['id'] == '' ? 0 : jsonMap['id']).toInt(),
      name = jsonMap['name'].toString(),
      video = jsonMap['video'] != null ? (jsonMap['video'] as List<dynamic>)
        .map<VideoItem>((value) => VideoItem.fromJson(value))
        .toList() : [];
}