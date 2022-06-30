class Filter {
  String id;
  String name;

  Filter({this.id = '', this.name = ''});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  Filter.fromJson(Map jsonMap)
    : id = jsonMap['id'].toString(),
      name = jsonMap['name'].toString();
}

class FilterModel {
  String name;
  List<Filter> list = [];

  FilterModel({this.name = ''});

  FilterModel.fromJson(Map jsonMap)
    : name = jsonMap['name'].toString(),
      list = (jsonMap['list'] as List).map((d) => Filter.fromJson(d)).toList();
}

class FilterParams {
  String ranking;
  int area;
  int year;
  int type;
  int vodStatus;
  int cate;
  int page;
  int pageSize;

  FilterParams({
    this.ranking = '最近更新',
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
      'vod_status': vodStatus,
      'cate': cate,
      'page': page,
      'pageSize': pageSize,
    };
  }

  FilterParams.fromJson(Map jsonMap)
      : ranking = jsonMap['ranking'].toString(),
        area = int.parse('${jsonMap['area']}'),
        year = int.parse('${jsonMap['year']}'),
        type = int.parse('${jsonMap['type']}'),
        vodStatus = int.parse('${jsonMap['vod_status']}'),
        cate = int.parse('${jsonMap['cate']}'),
        page = jsonMap['page'].toInt(),
        pageSize = jsonMap['pageSize'].toInt();
}