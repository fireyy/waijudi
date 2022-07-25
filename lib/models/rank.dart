import './category.dart';

class RankModel {
  List<String> rank;
  List<Category> type;

  RankModel({this.rank = const [], this.type = const []});

  toJson() => {
    'rank': rank,
    'type': type.map((v) => v.toJson()).toList(),
  };

  RankModel.fromJson(Map jsonMap)
    : rank = (jsonMap['rank'] as List).map((d) => d.toString()).toList(),
      type = (jsonMap['type'] as List).map((d) => Category.fromJson(d)).toList();
}