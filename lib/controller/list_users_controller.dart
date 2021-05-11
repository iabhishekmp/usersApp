import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_app/http_service.dart';
import 'package:users_app/models/list_users.dart';
import '../models/user.dart';

class ListUsersController extends GetxController {
  HttpService _dio = HttpService();

  var usersList = <User>[].obs;

  @override
  void onInit() {
    _apiGetUsersList();
    super.onInit();
  }

  void _apiGetUsersList() async {
    Future.delayed(
      Duration.zero,
      () => Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false),
    );
    var resp = await _dio.getRequest('/users');
    if (resp.statusCode == 200) {
      usersList.value = ListUsers.fromJson(resp.data).usersList;
    }
    Get.back();
  }
}
