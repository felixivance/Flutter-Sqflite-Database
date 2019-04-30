import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_sqflite/models/user.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  //singleton class has one instance and a single object
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _database;

  Future<Database> get db async{
    if(_database !=null){
      return _database;
    }else{
      _database = await initDB();
      return _database;
    }
  }
  DatabaseHelper.internal();

  initDB() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDB = await openDatabase(path,version:1, onCreate:_onCreate);
    return ourDB;
  }

  void _onCreate(Database db, int version ) async{
    await db.execute("CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
    print("TABLE IS CREATED");
  }

  //kuweka kwa db
  Future<int> saveUser(User user) async{
    var dbClient = await db;
    int response = await dbClient.insert("User", user.toMap());
    return response;
  }

  //kutoa kwa db deletion
  Future<int> deleteUser(User user) async{
    var dbClient = await db;
    int response = await dbClient.delete("User");
    return response;
  }
}