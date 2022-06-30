import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:waijudi/models/filter.dart';

class ListController extends GetxController {
  AppController appController = Get.find();
  final PagingController<int, VideoItem> _pagingController =
      PagingController(firstPageKey: 1);
  PagingController<int, VideoItem> get pagingController => _pagingController;
  Rx<FilterParams> filterParams = Rx<FilterParams>(FilterParams());
  RxList<FilterModel> filters = RxList<FilterModel>([]);
  RxMap<String, dynamic> filterMap = RxMap<String, dynamic>();

  ListController() {
    getType();
    _pagingController.addPageRequestListener((pageKey) {
      searchByFilter(pageKey);
    });
  }

  getType () async {
    filters.value = await appController.apiClient.getType();
    filters.forEach((element) {
      filterMap.addAll({
        element.name: element.list.first.id
      });
    });
  }

  searchByFilter (pageKey) async {
    print('====================searchByFilter: $pageKey, ${filterParams.value}');
    filterParams.value.page = pageKey;
    var result = await appController.apiClient.searchByFilter(filterParams.value);
    final isLastPage = result.currentPage == result.lastPage;
    if (isLastPage) {
      _pagingController.appendLastPage(result.data);
    } else {
      final nextPageKey = result.currentPage + 1;
      _pagingController.appendPage(result.data, nextPageKey);
    }
  }

  filter (Map<String, dynamic> data) async {
    print('==================filter: $data');
    var params = filterParams.value.toJson();
    filterParams.value = FilterParams.fromJson({
      ...params,
      ...data
    });
    _pagingController.refresh();
  }

  @override
  void onClose() {
    _pagingController.dispose();
    super.onClose();
  }
}