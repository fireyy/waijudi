import 'package:waijudi/util/utils.dart';

enum FilterType {
  ranking,
  area,
  type,
  year,
  vodStatus,
  cate,
}

FilterType getFilterTypeFromString(String str) {
  for (FilterType element in FilterType.values) {
     if (element.toString() == lowerCamelCase(str)) {
        return element;
     }
  }
  return FilterType.ranking;
}

class Filter {
  String id;
  String name;

  Filter({this.id = '', this.name = ''});

  Filter.fromJson(Map jsonMap)
    : id = jsonMap['id'].toString(),
      name = jsonMap['name'].toString();
}

class FilterModel {
  FilterType name;
  List<Filter> list = [];

  FilterModel({this.name = FilterType.ranking});

  FilterModel.fromJson(Map jsonMap)
    : name = getFilterTypeFromString(jsonMap['name'].toString()),
      list = (jsonMap['list'] as List).map((d) => Filter.fromJson(d)).toList();
}

class FilterModel2 {
  String ranking;
  int area;
  int year;
  int type;
  int vodStatus;
  int cate;
  int page;
  int pageSize;

  FilterModel2({
    this.ranking = '',
    this.area = 0,
    this.year = 0,
    this.type = 0,
    this.vodStatus = 0,
    this.cate = 0,
    this.page = 1,
    this.pageSize = 20,
  });

  Map<String, dynamic> toJson() {
    return {
      'ranking': ranking,
      'area': area,
      'year': year,
      'type': type,
      'vodStatus': vodStatus,
      'cate': cate,
      'page': page,
      'pageSize': pageSize,
    };
  }

  FilterModel2.fromJson(Map jsonMap)
      : ranking = jsonMap['ranking'].toString(),
        area = jsonMap['area'].toInt(),
        year = jsonMap['year'].toInt(),
        type = jsonMap['type'].toInt(),
        vodStatus = jsonMap['vod_status'].toInt(),
        cate = jsonMap['cate'].toInt(),
        page = jsonMap['page'].toInt(),
        pageSize = jsonMap['pageSize'].toInt();
}