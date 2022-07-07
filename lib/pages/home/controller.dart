import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:waijudi/models/category.dart';
import 'package:waijudi/models/section.dart';
import 'package:waijudi/models/searchresult.dart';

class HomeController extends GetxController {
  AppController appController = Get.find();
  RxList<Category> categories = RxList<Category>([]);
  final Rx<Category> _selectedCategory = Rx<Category>(Category());
  Category get selectedCategory => _selectedCategory.value;
  RxList<Section> homeData = RxList<Section>([]);

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  loadCategories() async {
    //Load categories
    List<Category> dataCategories = await appController.apiClient.getNavigation();
    categories.value = dataCategories;
    await selectCategory(categories.first);
  }

  selectCategory(Category category) async {
    _selectedCategory.value = category;
    SearchResult results = await appController.apiClient.getVideo(category: category.id);
    homeData.value = results.data;
  }
}
