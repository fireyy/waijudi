import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:easy_refresh/easy_refresh.dart';

class SearchController extends GetxController {
  AppController appController = Get.find();
  final Rx<String> _searchTerm = Rx<String>('');
  final RxList<VideoItem> searchResults = RxList<VideoItem>([]);
  final RxInt pageKey = 1.obs;
  RxBool isLoading = false.obs;
  final EasyRefreshController loadController = EasyRefreshController(
    controlFinishLoad: true,
  );
  final RxList<String> hotKeywords = RxList<String>([]);

  SearchController() {
    getHotKeywords();
  }

  getHotKeywords () async {
    hotKeywords.value = await appController.apiClient.getHotKeywords();
  }

  searchByName ({ bool isLoadMore = true }) async {
    print('====================searchByName: ${pageKey.value}, ${_searchTerm.value}');
    var result = await appController.apiClient.searchByName(_searchTerm.value, page: pageKey.value);
    pageKey.value = pageKey.value + 1;
    searchResults.addAll(result.data);
    final isLastPage = result.currentPage == result.lastPage || result.lastPage == 0 || result.data.isEmpty;
    if (isLoadMore) loadController.finishLoad(isLastPage ? IndicatorResult.noMore : IndicatorResult.success);
  }

  search (String name) async {
    isLoading.value = true;
    _searchTerm.value = name;
    pageKey.value = 1;
    searchResults.clear();
    loadController.resetFooter();
    // loadController.callLoad();
    await searchByName(isLoadMore: false);
    isLoading.value = false;
  }

  @override
  void onClose() {
    loadController.dispose();
    super.onClose();
  }
}