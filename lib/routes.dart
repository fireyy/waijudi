import 'package:get/route_manager.dart';

import 'pages/home/index.dart';
import 'pages/home/binding.dart';
import 'pages/detail/index.dart';
import 'pages/search/index.dart';
import 'pages/list/index.dart';
import 'pages/login/index.dart';

routes() => [
  GetPage(name: "/", page: () => const Home(), bindings: [HomeBinding(),]),
  GetPage(name: "/detail/:id", page: () => const VideoDetail()),
  GetPage(name: "/search", page: () => const Search(), transition: Transition.noTransition),
  GetPage(name: "/list", page: () => const List()),
  GetPage(name: "/login", page: () => const Login()),
];