import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:waijudi/models/playback.dart';
import 'package:easy_refresh/easy_refresh.dart';

class HistoryController extends GetxController {
  AppController appController = Get.find();
  final RxList<Playback> searchResults = RxList<Playback>([]);
  final RxInt pageKey = 1.obs;
  final EasyRefreshController loadController = EasyRefreshController(
    controlFinishRefresh: true, // FIXME: https://github.com/xuelongqy/flutter_easy_refresh/issues/563
    controlFinishLoad: true,
  );

  HistoryController() {
    // TODO: load hot keywords
  }

  fetchData () async {
    print('====================searchByName: ${pageKey.value}');
    var result = await appController.apiClient.getPlaybackRecord(pageKey.value);
    return result;
  }

  loadData () async {
    var result = await fetchData();
    pageKey.value = pageKey.value + 1;
    searchResults.addAll(result.data);
    final isLastPage = result.currentPage == result.lastPage;
    loadController.finishLoad(isLastPage ? IndicatorResult.noMore : IndicatorResult.success);
  }

  refreshData () async {
    pageKey.value = 1;
    searchResults.clear();
    loadController.resetFooter();
    var result = await fetchData();
    searchResults.addAll(result.data);
    loadController.finishRefresh(IndicatorResult.success);
  }

  @override
  void onClose() {
    loadController.dispose();
    super.onClose();
  }
}