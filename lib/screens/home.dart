import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_app/controller/list_users_controller.dart';

class Home extends StatelessWidget {
  final ListUsersController _listUsersController =
      Get.put(ListUsersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Container(
          child: ListView.builder(
            itemCount: _listUsersController.usersList.length,
            itemBuilder: (BuildContext context, int index) {
              final currentUser = _listUsersController.usersList[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text((currentUser.firstName?[0] ?? "") +
                      (currentUser.lastName?[0] ?? "")),
                ),
                title: Text(
                  (currentUser.firstName ?? "") +
                      " " +
                      (currentUser.lastName ?? ""),
                ),
                subtitle: Text(currentUser.email ?? ""),
              );
            },
          ),
        ),
      ),
    );
  }
}
