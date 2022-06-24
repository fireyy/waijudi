import 'package:waijudi/model/videoitem.dart';

class Categroy {
  int id;
  String name;
  List<VideoItem>? video;

  Categroy.fromJson(Map jsonMap)
    : id = (jsonMap['id'] == '' ? 0 : jsonMap['id']).toInt(),
      name = jsonMap['name'].toString(),
      video = jsonMap['video'] != null ? (jsonMap['video'] as List<dynamic>)
        .map<VideoItem>((value) => VideoItem.fromJson(value))
        .toList() : [];
}