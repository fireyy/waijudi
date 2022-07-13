import 'package:get_storage/get_storage.dart';
import 'package:waijudi/models/filter.dart';

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

  static Future<void> saveFilter(dynamic value) => _storage.write('filterType', value.toJson());

  static List<FilterModel> getFilter() => (_storage.read<List<dynamic>>('filterType') as List).map((d) => FilterModel.fromJson(d)).toList();

  static Future<void> clearStorage() => _storage.erase();
}
