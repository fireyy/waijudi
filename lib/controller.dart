import 'package:get/get.dart';
import 'package:waijudi/util/api_client.dart';
import 'package:waijudi/models/videoitem.dart';

class AppController extends GetxController{

  ApiClient apiClient = ApiClient();
  final Rx<VideoItem> _video = Rx<VideoItem>(VideoItem());
  setVideo(VideoItem value) => _video.value = value;
  VideoItem get video {
    return _video.value;
  }

  goToDetail(VideoItem item) {
    setVideo(item);
    Get.toNamed('/detail/${item.id}');
  }

}