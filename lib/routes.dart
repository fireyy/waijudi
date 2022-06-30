import 'package:get/route_manager.dart';

import 'pages/home/index.dart';
import 'pages/detail/index.dart';
import 'pages/search/index.dart';
import 'pages/list/index.dart';

routes() => [
  GetPage(name: "/", page: () => const Home()),
  GetPage(name: "/detail/:id", page: () => const VideoDetail()),
  GetPage(name: "/search", page: () => const Search()),
  GetPage(name: "/list", page: () => const List()),
];