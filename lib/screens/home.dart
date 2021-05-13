import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_app/controller/list_users_controller.dart';
import 'package:users_app/my_routes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  final ListUsersController _listUsersController =
      Get.put(ListUsersController());

  void _pagination() async {
    setState(() {
      isLoading = true;
    });
    print("myLog: Pagination called!");
    await _listUsersController.addMoreData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => Container(
          child: NotificationListener<ScrollNotification>(
            // ignore: missing_return
            onNotification: (ScrollNotification scrollInfo) {
              if (!isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                _pagination();
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _listUsersController.usersList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final currentUser = _listUsersController.usersList[index];
                      return ListTile(
                        onTap: () => Get.toNamed(MyRoutes.USERDETAIL,
                            arguments: currentUser),
                        leading: CircleAvatar(
                          child: Text((currentUser.firstName[0] ?? "") +
                              (currentUser.lastName[0] ?? "")),
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
                Container(
                  height: isLoading ? 50.0 : 0.0,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
