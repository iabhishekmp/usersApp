import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_app/controller/list_users_controller.dart';
// import 'package:users_app/controller/user_detail_controller.dart';
import 'package:users_app/models/user.dart';

class UserDetail extends StatefulWidget {
  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  final User currentuser = Get.arguments;
  var noteFromDB = "";

  final ListUsersController _listUsersController = Get.find();

  void _saveNote() {
    _listUsersController.saveNoteInDB(currentuser.id);
  }

  @override
  void initState() {
    _listUsersController.getNoteFromDB(currentuser.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 200,
                child: Center(
                  child: CircleAvatar(
                    radius: 80,
                    child: Text(
                      currentuser.firstName[0] + currentuser.lastName[0],
                      style: TextStyle(fontSize: 50),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: 150,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "First Name",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            currentuser.firstName,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 150,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "LastName",
                            style: TextStyle(color: Colors.grey),
                          ),
                          Text(
                            currentuser.lastName,
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        currentuser.email,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                child: TextFormField(
                  initialValue: currentuser.note,
                  onChanged: (val) {
                    _listUsersController.updateUserNote(val);
                  },
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Enter Text here...",
                    labelText: "Bio",
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Obx(
                  () => _listUsersController.isSavingNote.value
                      ? CircularProgressIndicator()
                      : TextButton(
                          onPressed:
                              (_listUsersController.isNoteMatchWithDB.value)
                                  ? null
                                  : _saveNote,
                          child: Text(
                            (currentuser.note.length > 0 &&
                                    _listUsersController
                                        .isNoteMatchWithDB.value)
                                ? "Saved"
                                : "Save",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
