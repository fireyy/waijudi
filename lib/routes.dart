import 'package:get/get.dart';

import 'pages/home/index.dart';
import 'pages/home/binding.dart';
import 'pages/detail/index.dart';
import 'pages/search/index.dart';
import 'pages/list/index.dart';
import 'pages/login/index.dart';
import 'pages/history/index.dart';
import 'pages/more/index.dart';

class AppPages {
  static final routes = [
    GetPage(name: "/", page: () => const Home(), bindings: [HomeBinding(),]),
    GetPage(name: "/detail", page: () => const VideoDetail()),
    GetPage(name: "/search", page: () => const Search(), transition: Transition.noTransition),
    GetPage(name: "/list", page: () => const List()),
    GetPage(name: "/login", page: () => Login()),
    GetPage(name: "/history", page: () => const History()),
    GetPage(name: "/more", page: () => const More()),
  ];
}