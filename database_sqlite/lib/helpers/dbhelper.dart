import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:database_sqlite/models/item.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  final String tableName = 'tableItem';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnPrice = 'price';

  DbHelper._internal();
  factory DbHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'item.db');

    //create, read databases
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //buat tabel baru dengan nama item
  Future<void> _onCreate(Database db, int version) async {
    var sql =
        "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$columnName TEXT,"
        "$columnPrice TEXT)";
    await db.execute(sql);
  }

  //create databases
  Future<int?> saveItem(Item item) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, item.toMap());
  }

  Future<List?> getAllItem() async {
    var dbClient = await _db;
    var result = await dbClient!
        .query(tableName, columns: [columnId, columnName, columnPrice]);

    return result.toList();
  }

  //update databases
  Future<int?> updateItem(Item item) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, item.toMap(),
        where: '$columnId = ?', whereArgs: [item.id]);
  }

  //delete databases
  Future<int?> deleteItem(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
