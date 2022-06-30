import 'package:waijudi/models/section.dart';
import 'package:waijudi/models/videoitem.dart';

class SearchResult {
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  List<Section> data;

  SearchResult.fromJson(Map jsonMap)
      : total = jsonMap['total'].toInt(),
        perPage = jsonMap['per_page'].toInt(),
        currentPage = jsonMap['current_page'].toInt(),
        lastPage = jsonMap['last_page'].toInt(),
        data = (jsonMap['data'] as List<dynamic>)
          .map<Section>((value) => Section.fromJson(value))
          .toList();
}

class SearchResultWithVideoItem {
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  List<VideoItem> data = [];

  SearchResultWithVideoItem({this.total = 0, this.perPage = 0, this.currentPage = 1, this.lastPage = 0});

  SearchResultWithVideoItem.fromJson(Map jsonMap)
      : total = jsonMap['total'].toInt(),
        perPage = int.parse(jsonMap['per_page']),
        currentPage = jsonMap['current_page'].toInt(),
        lastPage = jsonMap['last_page'].toInt(),
        data = (jsonMap['data'] as List<dynamic>)
          .map<VideoItem>((value) => VideoItem.fromJson(value))
          .toList();
}