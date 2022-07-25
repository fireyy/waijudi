import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waijudi/util/storage.dart';
import 'package:waijudi/models/filter.dart';
import 'package:waijudi/models/rank.dart';
import 'package:waijudi/models/category.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('plugins.flutter.io/path_provider_macos');
  void setUpMockChannels(MethodChannel channel) {
    TestDefaultBinaryMessengerBinding.instance?.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall? methodCall) async {
        if (methodCall?.method == 'getApplicationDocumentsDirectory') {
          return '.';
        }
      },
    );
  }

  setUpAll(() async {
    setUpMockChannels(channel);
  });

  setUp(() async {
    await GetStorage.init();
    Storage.clearStorage();
  });
  test('storage write and read', () async {
    expect(false, Storage.hasData('test'));
    await Storage.write('test', 'a');
    expect(true, Storage.hasData('test'));
    expect('a', Storage.read('test'));
    await Storage.remove('test');
    expect(false, Storage.hasData('test'));
  });

  test('storage token test', () async {
    expect('', Storage.token);
    await Storage.saveToken('thisistoken');
    expect('thisistoken', Storage.token);
  });

  test('storage videoName test', () async {
    Storage.videoName = 'thisisvideoname';
    expect('thisisvideoname', Storage.videoName);
  });

  test('storage saveFilter test', () async {
    var filter = [
      FilterModel(
        name: 'typename',
        list: [Filter(id: '1', name: 'valuename')],
      )
    ];
    await Storage.saveFilter(filter);
    var filter2 = Storage.getFilter();
    expect(filter.first.name, filter2.first.name);
  });

  test('storage apiUrl test', () async {
    var urls = ['http://www.baidu.com', 'http://www.google.com'];
    await Storage.saveApiUrls(urls);
    expect(urls, Storage.apiUrls);
  });

  test('storage saveRankType test', () async {
    var rank = RankModel(
      rank: ['typename'],
      type: [Category(id: 1, name: 'valuename')],
    );
    await Storage.saveRankType(rank);
    var rank2 = Storage.getRankType();
    expect(rank.rank.first, rank2.rank.first);
    expect(rank.type.first.id, rank2.type.first.id);
  });
}