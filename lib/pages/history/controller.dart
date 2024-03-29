import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:waijudi/models/playback.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/util/utils.dart';

class HistoryController extends GetxController {
  AppController appController = Get.find();
  final RxList<Playback> searchResults = RxList<Playback>([]);
  final RxInt pageKey = 1.obs;
  final EasyRefreshController loadController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  final RxBool _isEdit = false.obs;
  set isEdit(bool value) {
    _isEdit.value = value;
    if (!value) selected.clear();
  }
  bool get isEdit => _isEdit.value;
  final RxList<int> selected = RxList<int>([]);
  
  void toggleSelected (int id, bool value) {
    if (!selected.contains(id) && value) {
      selected.add(id);
    } else if (selected.contains(id) && !value) {
      selected.remove(id);
    }
  }

  Future removeSinglePlayback (int id) async {
    searchResults.removeWhere((item) => item.id == id);
    selected.clear();
    selected.add(id);
    await delPlaybackRecords();
  }

  Future delPlaybackRecords () async {
    await appController.apiClient.delPlaybackRecord(selected.join(','));
    searchResults.removeWhere((item) => selected.contains(item.id));
    selected.clear();
  }

  void confirmToDeletePlaybackRecords () {
    if (selected.isNotEmpty) {
      confirm(
        title: 'Confirm',
        content: "Do you confirm to remove this item?",
        onConfirm: () async {
          await delPlaybackRecords();
        },
      );
    } else {
      toast('Please select at least one item');
    }
  }

  fetchData () async {
    print('====================searchByName: ${pageKey.value}');
    try {
      var result = await appController.apiClient.getPlaybackRecord(pageKey.value);
      return result;
    } catch (err) {
      //
      return null;
    }
  }

  loadData () async {
    var result = await fetchData();
    if (result != null) {
      pageKey.value = pageKey.value + 1;
      searchResults.addAll(result.data);
      final isLastPage = result.currentPage == result.lastPage;
      loadController.finishLoad(isLastPage ? IndicatorResult.noMore : IndicatorResult.success);
    }
  }

  refreshData () async {
    pageKey.value = 1;
    loadController.resetFooter();
    var result = await fetchData();
    if (result != null) {
      searchResults.value = result.data;
      loadController.finishRefresh(IndicatorResult.success);
    }
  }

  @override
  void onClose() {
    loadController.dispose();
    super.onClose();
  }
}