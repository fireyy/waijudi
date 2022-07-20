import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:waijudi/models/filter.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:waijudi/util/storage.dart';

class ListController extends GetxController {
  AppController appController = Get.find();
  final RxList<VideoItem> searchResults = RxList<VideoItem>([]);
  final EasyRefreshController loadController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  Rx<FilterParams> filterParams = Rx<FilterParams>(FilterParams());
  RxList<FilterModel> filters = RxList<FilterModel>([]);
  RxMap<String, dynamic> filterMap = RxMap<String, dynamic>();
  bool isInitialized = true;
  RxBool isLoading = false.obs;
  final ScrollController scrollController = ScrollController();

  ListController() {
    getType();
  }

  getType () async {
    if (Storage.hasData('filterType')) {
      filters.value = Storage.getFilter();
    } else {
      filters.value = await appController.apiClient.getType();
      await Storage.saveFilter(filters);
    }
    for (var filter in filters) {
      filterMap.addAll({
        filter.name: filter.list.first.id
      });
    }
    searchByFilter();
  }

  searchByFilter () async {
    print('====================searchByFilter: ${filterParams.value.page}, ${filterParams.value}');
    if (isInitialized) isLoading.value = true;
    var result = await appController.apiClient.searchByFilter(filterParams.value);
    filterParams.value.page = filterParams.value.page + 1;
    searchResults.addAll(result.data);
    final isLastPage = result.currentPage == result.lastPage || result.lastPage == 0 || result.data.isEmpty;
    if (!isInitialized) {
      loadController.finishLoad(isLastPage ? IndicatorResult.noMore : IndicatorResult.success);
    } else {
      isInitialized = false;
    }
    isLoading.value = false;
  }

  filter (Map<String, dynamic> data) async {
    print('==================filter: $data');
    var params = filterParams.value.toJson();
    filterMap.value = {
      ...filterMap,
      ...data,
    };
    filterParams.value = FilterParams.fromJson({
      ...params,
      ...data,
      'page': 1,
    });
    searchResults.clear();
    loadController.resetFooter();
    isInitialized = true;
    searchByFilter();
  }

  goToTop () {
    scrollController.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void onClose() {
    loadController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}