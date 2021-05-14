import 'dart:async';
import 'package:flutter/material.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get/get.dart';

class CheckNetwork {
  StreamSubscription<DataConnectionStatus> listener;
  var internetStatus = "Unknown";
  var contentmessage = "Unknown";

  void _showDialog(String title, String content) {
    Get.defaultDialog(title: title, content: Text(content));
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //           title: new Text(title),
    //           content: new Text(content),
    //           actions: <Widget>[
    //             new TextButton(
    //                 onPressed: () {
    //                   Navigator.of(context).pop();
    //                 },
    //                 child: new Text("Close"))
    //           ]);
    //     });
  }

  checkConnection() async {
    print("myLog: checkConnection func is called & setting up the listner...");
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      print("myLog: internet status has changed to $status");
      if (status != DataConnectionStatus.connected) {
        internetStatus = "You are disconnected to the Internet. ";
        contentmessage = "Please check your internet connection";
        _showDialog(internetStatus, contentmessage);
      } else {
        print("Its connected!!");
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }
}
