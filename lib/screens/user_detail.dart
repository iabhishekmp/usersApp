import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_app/controller/user_detail_controller.dart';
import 'package:users_app/models/user.dart';

class UserDetail extends StatelessWidget {
  final User currentuser = Get.arguments;
  final UserDetailControler _userDetailControler = UserDetailControler();

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
                    color: Colors.amber[100],
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
                    color: Colors.amber[100],
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
                color: Colors.amber[100],
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
                child: FutureBuilder(
                  future: _userDetailControler.getNoteFromDB(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? Center(child: CircularProgressIndicator())
                        : TextFormField(
                            initialValue: _userDetailControler.userNote.value,
                            onChanged: (val) {
                              _userDetailControler.updateUserNote(val);
                            },
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: "Enter Text here...",
                              labelText: "Bio",
                            ),
                          );
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Obx(
                  () => _userDetailControler.isSavingNote.value
                      ? CircularProgressIndicator()
                      : TextButton(
                          onPressed:
                              (_userDetailControler.isNoteMatchWithDB.value)
                                  ? null
                                  : _userDetailControler.saveNoteInDB,
                          child: Text(
                            (_userDetailControler.userNote.value.length > 0 &&
                                    _userDetailControler
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
