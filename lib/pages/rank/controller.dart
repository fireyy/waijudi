import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:waijudi/models/rank.dart';
import 'package:waijudi/models/category.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:easy_refresh/easy_refresh.dart';

class RankController extends GetxController {
  AppController appController = Get.find();
  Rx<RankModel> categories = Rx<RankModel>(RankModel());
  final Rx<Category> _selectedCategory = Rx<Category>(Category());
  Category get selectedCategory => _selectedCategory.value;
  final Rx<String> _selectedRank = Rx<String>('');
  String get selectedRank => _selectedRank.value;
  RxList<VideoItem> resultData = RxList<VideoItem>([]);
  final RxInt pageKey = 1.obs;
  RxBool isLoading = false.obs;
  final EasyRefreshController loadController = EasyRefreshController(
    controlFinishLoad: true,
  );

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  loadCategories() async {
    isLoading.value = true;
    RankModel dataCategories = await appController.apiClient.getRankType();
    categories.value = dataCategories;
    _selectedCategory.value = dataCategories.type.first;
    _selectedRank.value = dataCategories.rank.first;
    await loadRankList(isLoadMore: false);
    isLoading.value = false;
  }

  fetchData () async {
    pageKey.value = 1;
    resultData.clear();
    loadController.resetFooter();
    isLoading.value = true;
    await loadRankList(isLoadMore: false);
    isLoading.value = false;
  }

  selectCategory (Category category) {
    _selectedCategory.value = category;
    fetchData();
  }

  selectRank (String rank) {
    _selectedRank.value = rank;
    fetchData();
  }

  loadRankList({bool isLoadMore = true}) async {
    print('====================loadRankList: ${pageKey.value}, rank: $selectedRank, category: ${selectedCategory.name}');
    var result = await appController.apiClient.getRankList(id: selectedCategory.id, rank: selectedRank, page: pageKey.value);
    pageKey.value = pageKey.value + 1;
    resultData.addAll(result.data);
    final isLastPage = result.currentPage == result.lastPage || result.lastPage == 0 || result.data.isEmpty;
    if (isLoadMore) loadController.finishLoad(isLastPage ? IndicatorResult.noMore : IndicatorResult.success);
  }

  @override
  void onClose() {
    loadController.dispose();
    super.onClose();
  }
}
