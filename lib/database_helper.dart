import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _db;
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();

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
        try {
          db.execute('''CREATE TABLE favorites (
            type TEXT PRIMARY KEY
          );''');
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
      },
    );

    return database;
  }

  // Insert a favorite item
  Future<void> insertFavorite(String type) async {
    final db = await database;
    await db.transaction((txn) async {
      try {
        await txn.insert('favorites', {
          'type': type,
        }, conflictAlgorithm: ConflictAlgorithm.replace);
      } catch (e) {
        // If an error occurs, the transaction is rolled back automatically
        if (kDebugMode) {
          print("Transaction error: $e");
        }
        rethrow;
      }
    });
  }

  // Delete a favorite item
  Future<void> deleteFavorite(String type) async {
    final db = await database;
    await db.transaction((txn) async {
      try {
        await txn.delete('favorites', where: 'type = ?', whereArgs: [type]);

      } catch (e) {
        // If an error occurs, the transaction is rolled back automatically
        if (kDebugMode) {
          print("Transaction error: $e");
        }
        rethrow;
      }
    });
  }

  // Select all favorite items
  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.rawQuery('SELECT * FROM favorites');
  }
}
