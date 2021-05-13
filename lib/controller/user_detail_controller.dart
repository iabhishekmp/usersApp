import 'package:get/get.dart';
import 'package:users_app/models/user.dart';
import '../DBHelper/users_db_helper.dart';

class UserDetailControler extends GetxController {
  UsersDBHelper dbClient = UsersDBHelper();
  User currentUser = Get.arguments;

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

  Future<void> saveNoteInDB() async {
    isSavingNote.value = true;
    await dbClient.saveNote(userNote.value, currentUser.id);
    isSavingNote.value = false;
    isNoteMatchWithDB.value = true;
  }

  Future<void> getNoteFromDB() async {
    isLoadingNote.value = true;
    noteFromDB = await dbClient.getNote(currentUser.id);
    userNote.value = noteFromDB;
    isLoadingNote.value = false;
  }
}
