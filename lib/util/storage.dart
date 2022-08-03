import 'package:get_storage/get_storage.dart';
import 'package:waijudi/models/filter.dart';
import 'package:waijudi/models/category.dart';
import 'package:waijudi/models/rank.dart';

final _storage = GetStorage();

class Storage {
  static Future<void> write(String key, dynamic value) =>
      _storage.write(key, value);
  
  static void writeInMemory(String key, dynamic value) =>
      _storage.writeInMemory(key, value);

  static T? read<T>(String key) => _storage.read<T>(key);

  static bool hasData(String key) => _storage.hasData(key);

  static Future<void> remove(String key) => _storage.remove(key);

  static set videoName(String value) => _storage.writeInMemory('videoName', value);

  static String get videoName => _storage.read('videoName');

  static Future<void> saveToken(dynamic value) => _storage.write('token', value);

  static String get token => _storage.read<String>('token') ?? '';

  static Future<void> saveFilter(dynamic value) => _storage.write('filterType', value.map((v) => v.toJson()).toList());

  static List<FilterModel> getFilter() => (_storage.read<List<dynamic>>('filterType') as List).map((d) => FilterModel.fromJson(d)).toList();

  static Future<void> saveApiUrls(List<String> value) => _storage.write('apiUrl', value);

  static List<String> get apiUrls {
    var result = _storage.read<List<dynamic>>('apiUrl') ?? [];
    var resultStr = result.map((r) => r.toString()).toList();
    return ['https://api.mdwifi.com:778', ...resultStr];
  }

  static Future<void> saveCurrentApiUrl(String value) => _storage.write('currentApiUrl', value);

  static String get currentApiUrl => _storage.read<String>('currentApiUrl') ?? 'https://api.mdwifi.com:778';

  static Future<void> saveRankType(dynamic value) => _storage.write('ranktype', value.toJson());

  static RankModel getRankType() => RankModel.fromJson(_storage.read<dynamic>('ranktype'));

  static Future<void> saveCategories(dynamic value) => _storage.write('categories', value.map((v) => v.toJson()).toList());

  static List<Category> getCategories() => (_storage.read<List<dynamic>>('categories') as List).map((d) => Category.fromJson(d)).toList();

  static Future<void> clearStorage() => _storage.erase();
}
