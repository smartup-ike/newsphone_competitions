import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static Database? _db;
  static final DatabaseHelper instance = DatabaseHelper._constructor();

  DatabaseHelper._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await setDB();
    }

    return _db!;
  }

  Future<Database> setDB() async {
    ///We get the dir path we store our database
    final databaseDirPath = await getDatabasesPath();

    ///We set up our Database
    final databasePath = join(databaseDirPath, "newsphone.db");

    ///And we create the database and the table decks
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        ///With execute we execute raw sql commands
        db.execute('''
        ''');

        try {
          db.execute('''
         ''');
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      },
    );

    return database;
  }
}