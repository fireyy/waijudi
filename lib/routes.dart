import 'package:get/route_manager.dart';

import 'pages/home/index.dart';
import 'pages/detail/index.dart';

routes() => [
  GetPage(name: "/", page: () => const Home()),
  GetPage(name: "/detail/:id", page: () => VideoDetail()),
];