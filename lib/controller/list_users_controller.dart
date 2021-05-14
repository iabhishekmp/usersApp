import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_app/DBHelper/users_db_helper.dart';
import 'package:users_app/check_network.dart';
import 'package:users_app/http_service.dart';
import 'package:users_app/models/list_users.dart';
import '../models/user.dart';

class ListUsersController extends GetxController {
  HttpService _dio = HttpService();
  UsersDBHelper dbClient = UsersDBHelper();

  var usersList = <User>[].obs;
  @override
  void onInit() {
    CheckNetwork().checkConnection();
    _onInitFunc();
    super.onInit();
  }

  @override
  void onClose() {
    CheckNetwork().listener.cancel();
    super.onClose();
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
    if (resp != null && resp.statusCode == 200) {
      final result = ListUsers.fromJson(resp.data).usersList;
      return result;
    }
    return [];
  }

  Future<bool> addMoreData() async {
    List<User> newData = await _apiGetUsersList();
    if (newData.length != 0) {
      dbClient.save(newData);
      usersList.addAll(newData);
      return true;
    }
    return false;
  }

  var userNote = "".obs;
  var isSavingNote = false.obs;
  var isLoadingNote = false.obs;
  var isNoteMatchWithDB = true.obs;
  var noteFromDB = "";

  void updateUserNote(String note) {
    userNote.value = note;
    if (note != noteFromDB)
      isNoteMatchWithDB.value = false;
    else
      isNoteMatchWithDB.value = true;
  }

  void saveNoteInDB(String id) async {
    isSavingNote.value = true;
    await dbClient.saveNote(userNote.value, id);
    isSavingNote.value = false;
    noteFromDB = userNote.value;
    isNoteMatchWithDB.value = true;
    var index = usersList.indexWhere((element) => element.id == id);
    var obj = usersList[index];
    usersList[index] = User(obj.id, obj.email, obj.firstName, obj.lastName,
        obj.createdAt, obj.updatedAt, userNote.value);
  }

  Future<void> getNoteFromDB(String id) async {
    isLoadingNote.value = true;
    noteFromDB = await dbClient.getNote(id);
    userNote.value = noteFromDB;
    isNoteMatchWithDB.value = true;
    isLoadingNote.value = false;
  }
}
