import 'package:get/get.dart';
import 'package:waijudi/models/line.dart';
import 'package:waijudi/models/drama.dart';

import 'package:waijudi/controller.dart';

class DetailController extends GetxController {
  AppController appController = Get.find();
  final int videoId = int.parse(Get.parameters['id'] ?? '0');
  RxMap<String, List<Map<String, dynamic>>> videoList = RxMap<String, List<Map<String, dynamic>>>({
    "video": []
  });
  RxList<Map<String, dynamic>> list = RxList<Map<String, dynamic>>([]);
  
  DetailController() {
    loadVideo();
  }

  getVodDecrypt (String url) async {
    return await appController.apiClient.vodDecrypt(url);
  }

  loadVideo() async {
    try {
      var lines = await appController.apiClient.getLine(videoId);
      for (var line in lines) {
        var drama = await appController.apiClient.getDramaDetail(id: videoId, lineId: line.vodLineId);
        var dUrl = await getVodDecrypt(drama.first.vodDramaUrl);
        list.add({
          'name': line.name,
          'list': drama.map((d) => {
            'name': d.dramaName,
            'url': drama.indexOf(d) == 0 ? dUrl : d.vodDramaUrl
          }).toList()
        });
      }
      videoList['video'] = list;
    } catch (error) {
      Get.log(error.toString());
    }
  }
}
