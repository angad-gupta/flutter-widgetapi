import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:projectapp/model/note_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbVersion = 1;
  static const _dbName = "note.db";
  static const tableName = "note";

  static const title = "title";
  static const idd = "id";
  static const desc = "desc";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  // it will check database is already exist or not and return database
  Future<Database?> get db async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  // it will create directory and database
  initDatabase() async {
    //create a directory for input
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, _dbName);
    var db = await openDatabase(path, version: _dbVersion, onCreate: onCreate);
    return db;
  }

  // it create tabel 
  Future<void> onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $tableName ($idd INTEGER PRIMARY KEY AUTOINCREMENT  ,  $title TEXT, $desc TEXT)''');
  }

  // sql method for inserting new note
  Future<void> insertData(NoteModel note) async {
    final dbClient = await instance.db;
    await dbClient!.insert(tableName, note.toJson());
  }

  // sql method for get note list
  Future<List<NoteModel>> getData() async {
    final dbClient = await instance.db;
    final List<Map<String, dynamic>> data = await dbClient!.query(tableName);
    print(data);
    return data.map((e) => NoteModel.fromMap(e)).toList();
  }

  // sql method for update existing note 
  Future<void> update(NoteModel note, int id) async {
    Database? dbClient = await instance.db;
    await dbClient!
        .update(tableName, note.toJson(), where: "id=?", whereArgs: [id]);
  } 
  // sql method for delete existing note 
  Future<void> delete(int id) async {
    Database? dbClient = await instance.db;
    await dbClient!.delete(tableName, where: "id=?", whereArgs: [id]);
  }
}
