import 'package:get/get.dart';
import 'package:waijudi/models/line.dart';
import 'package:waijudi/models/drama.dart';
import 'package:fijkplayer/fijkplayer.dart';

import 'package:waijudi/controller.dart';

class DetailController extends GetxController {
  AppController appController = Get.find();
  final int videoId = int.parse(Get.parameters['id'] ?? '0');
  final RxList<LineModel> lines = RxList<LineModel>([]);
  final RxList<Drama> drama = RxList<Drama>([]);
  final Rx<String> _videoUrl = Rx<String>('');
  String get videoUrl => _videoUrl.value;
  final FijkPlayer player = FijkPlayer();
  final RxBool _isPlay = RxBool(false);
  bool get isPlay => _isPlay.value;

  watch () {
    _isPlay.value = true;
    player.setDataSource(videoUrl, autoPlay: true);
  }
  
  DetailController() {
    loadVideo();
  }

  selectLine (int lineId) {
    loadDramaDetail(lineId);
  }

  loadDramaDetail(int lineId) async {
    try {
      drama.value = await appController.apiClient.getDramaDetail(id: videoId, lineId: lineId);
      await getVodDecrypt(drama.first.vodDramaUrl);
    } catch (error) {
      print(error.toString());
    }
  }

  getVodDecrypt (String url) async {
    _videoUrl.value = await appController.apiClient.vodDecrypt(url);
  }

  selectEpisode (int index) {
    var url = drama.elementAt(index).vodDramaUrl;
    getVodDecrypt(url);
  }

  loadVideo() async {
    try {
      lines.value = await appController.apiClient.getLine(videoId);
      await loadDramaDetail(lines.first.vodLineId);
    } catch (error) {
      print(error.toString());
    }
  }
}
