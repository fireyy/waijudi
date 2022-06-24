import 'package:waijudi/model/categroy.dart';

class SearchResult {
  int total;
  int perPage;
  int currentPage;
  int lastPage;
  List<Categroy> data;

  SearchResult.fromJson(Map jsonMap)
      : total = jsonMap['total'].toInt(),
        perPage = jsonMap['per_page'].toInt(),
        currentPage = jsonMap['current_page'].toInt(),
        lastPage = jsonMap['last_page'].toInt(),
        data = (jsonMap['data'] as List<dynamic>)
          .map<Categroy>((value) => Categroy.fromJson(value))
          .toList();
}