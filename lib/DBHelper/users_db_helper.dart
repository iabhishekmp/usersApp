import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:users_app/models/user.dart';

class UsersDBHelper {
  static Database _db;
  //Columns
  static const String ID = 'id';
  static const String FNAME = 'first_name';
  static const String LNAME = 'last_name';
  static const String EMAIL = 'email';
  static const String CREATED_AT = 'created_at';
  static const String UPDATED_AT = 'updated_at';
  static const String NOTE = 'notes';

  //Database-Table
  static const DB_NAME = 'users1.db';
  static const TABLE = 'Users';

  // Get the dataBase
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    //Get the document directory of devices
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // Path is : /data/user/0/com.example.git_users/app_flutter

    //Make a path for database
    String path = join(documentsDirectory.path, DB_NAME);
    print("myLog: Path for the database is: $path");

    //Open the database
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  // What will happed at the time of creation of database
  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $TABLE ($ID TEXT PRIMARY KEY, $EMAIL TEXT, $FNAME TEXT, $LNAME TEXT, $CREATED_AT TEXT, $UPDATED_AT TEXT, $NOTE TEXT DEFAULT '')");
  }

  //Insert the data into database
  void save(List<User> usersList) async {
    var dbClient = await db;
    Batch batch = dbClient.batch();
    usersList.forEach((element) {
      batch.insert(TABLE, element.toJson());
    });
    await batch.commit();
  }

  // get the no of rows in database
  Future<int> getNoOfRows() async {
    var dbClient = await db;
    var resp = await dbClient.rawQuery("SELECT COUNT() FROM $TABLE");
    return resp[0]['COUNT()'];
  }

  // Get all the users
  // I'm returning all the data from the database, if I have big database, it is not recommeded way.
  Future<List<User>> getUsers() async {
    var dbClient = await db;
    //Fetch all the users in json form
    List<Map<String, dynamic>> maps =
        await dbClient.query(TABLE, columns: [ID, FNAME, LNAME, EMAIL]);
    List<User> users = [];
    //Convert the json form into dartObj and add into the list
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        users.add(User.fromJson(maps[i]));
      }
    }
    return users;
  }

  //close the database
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  deleteAllRecords() async {
    var dbClient = await db;
    await dbClient.rawDelete('DELETE FROM Users');
  }

  Future<void> saveNote(String note, String id) async {
    var dbClient = await db;
    await dbClient
        .rawUpdate('UPDATE $TABLE SET $NOTE = "$note" WHERE $ID="$id"');
  }

  Future<String> getNote(String id) async {
    var dbClient = await db;
    var s = await dbClient.rawQuery('SELECT $NOTE FROM $TABLE WHERE $ID="$id"');
    return s[0][NOTE];
  }
}
