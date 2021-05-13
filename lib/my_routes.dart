import 'package:get/get.dart';
import 'screens/home.dart';
import 'screens/user_detail.dart';

class MyRoutes {
  static const HOME = '/';
  static const USERDETAIL = '/user-detail';
  static final routes = [
    GetPage(
      name: HOME,
      page: () => Home(),
    ),
    GetPage(
      name: USERDETAIL,
      page: () => UserDetail(),
    ),
  ];
}
