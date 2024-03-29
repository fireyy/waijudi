import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:easy_refresh/easy_refresh.dart';

class MoreController extends GetxController {
  AppController appController = Get.find();
  final int id = int.parse(Get.parameters['id'] ?? '0');
  final String name = Get.parameters['name'] ?? '';
  final RxList<VideoItem> searchResults = RxList<VideoItem>([]);
  final RxInt pageKey = 1.obs;
  final EasyRefreshController loadController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void onInit() {
    super.onInit();
  }

  getMore() async => await appController.apiClient.getMore(id: id, name: name, page: pageKey.value);

  loadData({bool isLoadMore = true}) async {
    print('====================loadMore: ${pageKey.value}, id: $id, name: $name');
    var result = await getMore();
    pageKey.value = pageKey.value + 1;
    if (isLoadMore) {
      searchResults.addAll(result.data);
      final isLastPage = result.currentPage == result.lastPage || result.lastPage == 0 || result.data.isEmpty;
      loadController.finishLoad(isLastPage ? IndicatorResult.noMore : IndicatorResult.success);
    } else {
      searchResults.value = result.data;
      loadController.finishRefresh(IndicatorResult.success);
    }
  }

  refreshData () async {
    pageKey.value = 1;
    loadController.resetFooter();
    await loadData(isLoadMore: false);
  }

  @override
  void onClose() {
    loadController.dispose();
    super.onClose();
  }
}
