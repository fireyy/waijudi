class Category {
  int id;
  String name;

  Category({this.id = 0, this.name = ''});

  Category.fromJson(Map jsonMap)
    : id = (jsonMap['id'] == '' ? 0 : jsonMap['id']).toInt(),
      name = jsonMap['name'].toString();
}