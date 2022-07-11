import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:easy_refresh/easy_refresh.dart';

class SearchController extends GetxController {
  AppController appController = Get.find();
  final Rx<String> _searchTerm = Rx<String>('');
  final RxList<VideoItem> searchResults = RxList<VideoItem>([]);
  final RxInt pageKey = 1.obs;
  final EasyRefreshController loadController = EasyRefreshController(
    controlFinishRefresh: true, // FIXME: https://github.com/xuelongqy/flutter_easy_refresh/issues/563
    controlFinishLoad: true,
  );

  SearchController() {
    // TODO: load hot keywords
  }

  searchByName () async {
    print('====================searchByName: ${pageKey.value}, ${_searchTerm.value}');
    var result = await appController.apiClient.searchByName(_searchTerm.value, page: pageKey.value);
    pageKey.value = pageKey.value + 1;
    searchResults.addAll(result.data);
    final isLastPage = result.currentPage == result.lastPage;
    loadController.finishLoad(isLastPage ? IndicatorResult.noMore : IndicatorResult.success);
  }

  search (String name) async {
    _searchTerm.value = name;
    pageKey.value = 1;
    searchResults.clear();
    loadController.resetFooter();
    loadController.callLoad();
  }

  @override
  void onClose() {
    loadController.dispose();
    super.onClose();
  }
}