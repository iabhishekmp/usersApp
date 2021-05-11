import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:users_app/models/list_users.dart';

import '../http_service.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HttpService httpServiceObj = HttpService();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
          future: httpServiceObj.getRequest('/users'),
          builder: (BuildContext context, AsyncSnapshot<Response> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            final jsonData = snapshot.data;
            final listUsers = ListUsers.fromJson(jsonData?.data).usersList;
            return ListView.builder(
              itemCount: listUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(listUsers[index].firstName ?? ''),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
