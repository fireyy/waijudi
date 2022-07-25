import 'package:get/get.dart';
import 'package:waijudi/models/video_detail.dart';
import 'package:waijudi/models/line.dart';
import 'package:waijudi/controller.dart';

class DetailController extends GetxController {
  AppController appController = Get.find();
  final int videoId = int.parse(Get.parameters['id'] ?? '0');
  RxMap<String, List<Map<String, dynamic>>> videoList = RxMap<String, List<Map<String, dynamic>>>({
    "video": []
  });
  RxList<LineModel> lineList = RxList<LineModel>([]);
  Rx<VideoDetail> videoDetail = Rx<VideoDetail>(VideoDetail());
  
  DetailController() {
    loadVideo();
  }

  getVodDecrypt (String url) async {
    return await appController.apiClient.vodDecrypt(url);
  }

  loadVideo() async {
    try {
      var lines = await appController.apiClient.getLine(videoId);
      lineList.value = lines;
      var result = await appController.apiClient.getVideoById(videoId);
      videoDetail.value = result;
      List<Map<String, dynamic>> list = [];
      for (var line in lines) {
        var drama = await appController.apiClient.getDramaDetail(id: videoId, lineId: line.vodLineId);
        var video = drama.firstWhere((value) => value.dramaName == videoDetail.value.dramaId, orElse: () => drama.first);
        var index = drama.indexOf(video);
        var dUrl = await getVodDecrypt(video.vodDramaUrl);
        list.add({
          'name': line.name,
          'list': drama.map((d) => {
            'name': d.dramaName,
            'url': drama.indexOf(d) == index ? dUrl : d.vodDramaUrl
          }).toList()
        });
      }
      videoList['video'] = list;
    } catch (error) {
      // Get.log(error.toString());
      // rethrow;
    }
  }

  void addPlaybackRecord (Map<String, dynamic> params) {
    appController.apiClient.addPlaybackRecord(params);
  }
}
