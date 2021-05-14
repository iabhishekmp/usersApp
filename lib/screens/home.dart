import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_app/controller/list_users_controller.dart';
// import 'package:users_app/controller/user_detail_controller.dart';
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
    print("myLog: pagination called!!");
    var connection = await DataConnectionChecker().hasConnection;
    if (connection) {
      await _listUsersController.addMoreData();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: TextField(),
      ),
      body: Obx(
        () => Container(
          child: NotificationListener<ScrollNotification>(
            // ignore: missing_return
            onNotification: (ScrollNotification scrollInfo) {
              if (!isLoading &&
                  scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                setState(() {
                  isLoading = true;
                });
                _pagination();
                print("pagination calling....");
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
                        subtitle: Text(currentUser.note),
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
