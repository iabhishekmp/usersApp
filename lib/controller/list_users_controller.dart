import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_app/DBHelper/users_db_helper.dart';
import 'package:users_app/http_service.dart';
import 'package:users_app/models/list_users.dart';
import '../models/user.dart';

class ListUsersController extends GetxController {
  HttpService _dio = HttpService();
  UsersDBHelper dbClient = UsersDBHelper();

  var usersList = <User>[].obs;

  @override
  void onInit() {
    _onInitFunc();
    super.onInit();
  }

  void _onInitFunc() async {
    Future.delayed(
      Duration.zero,
      () => Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false),
    );
    List<User> bucket = await _getusersFromDB();
    if (bucket.length == 0) {
      bucket = await _apiGetUsersList();
      dbClient.save(bucket);
    }
    usersList.value = bucket;
    Get.back();
  }

  Future<int> _getNoOfRowsFromDB() async {
    int sinceCount = await dbClient.getNoOfRows();
    return sinceCount;
  }

  Future<List<User>> _getusersFromDB() async {
    final usersListFromDB = await dbClient.getUsers();
    return usersListFromDB;
  }

  Future<List<User>> _apiGetUsersList() async {
    final int sinceCount = await _getNoOfRowsFromDB();
    var resp = await _dio.getRequest('/users', sinceCount).catchError((err) {
      Get.snackbar('Error occure', "Someting wrong with the backend!");
    });
    if (resp.statusCode == 200) {
      final result = ListUsers.fromJson(resp.data).usersList;
      return result;
    }
    return [];
  }

  Future<bool> addMoreData() async {
    List<User> newData = await _apiGetUsersList();
    if (newData.length != 0) {
      usersList.addAll(newData);
      dbClient.save(newData);
      return true;
    }
    return false;
  }
}
