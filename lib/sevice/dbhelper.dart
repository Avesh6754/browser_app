import 'package:flutter_adv_ch4/modal/modalClass.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dbhelper {
  Dbhelper._();

  static Dbhelper dbhelper = Dbhelper._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var databasePath = await getDatabasesPath();
    final path = join(databasePath, "demo.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Bookmark (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, url TEXT)');
      await db.execute(
          'CREATE TABLE History (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, url TEXT)');
    });
  }

  Future<void> insertHistory(ModalClass items)
  async {
    final db=await database;
    await db.insert('History',ModalClass.toMap(items),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<void> deleteHistory(int id)
  async {
    final db =await database;
    db.delete('History',where: "id=?",whereArgs: [id]);
  }
  Future<void> insertBookMark(ModalClass items)
  async {
    final db=await database;
    await db.insert('History',ModalClass.toMap(items),conflictAlgorithm: ConflictAlgorithm.replace);
  }
  Future<void> deleteBookmark(int id)
  async {
    final db =await database;
   await db.delete('History',where: "id=?",whereArgs: [id]);
  }

  Future<List<Map<String, Object?>>> fetchDataHistory()
  async {
    final db=await database;
    return await db.query('History');
  }
}
