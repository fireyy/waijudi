import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchController extends GetxController {
  AppController appController = Get.find();
  final PagingController<int, VideoItem> _pagingController =
      PagingController(firstPageKey: 0);
  PagingController<int, VideoItem> get pagingController => _pagingController;
  final Rx<String> _searchTerm = Rx<String>('');

  SearchController() {
    _pagingController.addPageRequestListener((pageKey) {
      searchByName(pageKey);
    });
  }

  searchByName (pageKey) async {
    print('====================searchByName: $pageKey, ${_searchTerm.value}');
    var result = await appController.apiClient.searchByName(_searchTerm.value, page: pageKey);
    final isLastPage = result.currentPage == result.lastPage;
    if (isLastPage) {
      _pagingController.appendLastPage(result.data);
    } else {
      final nextPageKey = result.currentPage + 1;
      _pagingController.appendPage(result.data, nextPageKey);
    }
  }

  search (String name) async {
    _searchTerm.value = name;
    _pagingController.refresh();
  }

  @override
  void onClose() {
    _pagingController.dispose();
    super.onClose();
  }
}