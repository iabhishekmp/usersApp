import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_app/my_routes.dart';
import './screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: MyRoutes.routes,
      home: Home(),
    );
  }
}
