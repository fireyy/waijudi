import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:waijudi/models/category.dart';
import 'package:waijudi/models/section.dart';
import 'package:waijudi/models/searchresult.dart';
import 'package:waijudi/util/storage.dart';

class HomeController extends GetxController {
  AppController appController = Get.find();
  RxList<Category> categories = RxList<Category>([]);
  final Rx<Category> _selectedCategory = Rx<Category>(Category());
  Category get selectedCategory => _selectedCategory.value;
  final homeData = RxList<Section>([]);

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  loadCategories() async {
    //Load categories
    if (Storage.hasData('categories')) {
      categories.value = Storage.getCategories();
    }
    List<Category> dataCategories = await appController.apiClient.getNavigation();
    categories.value = dataCategories;
    Storage.saveCategories(dataCategories);
  }

  selectCategory(Category category) async {
    _selectedCategory.value = category;
    await getVideo();
  }

  getVideo () async {
    SearchResult results = await appController.apiClient.getVideo(category: _selectedCategory.value.id);
    homeData.value = results.data;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
