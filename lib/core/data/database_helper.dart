import 'package:site_construct/core/data/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY,
        phoneNumber TEXT
      )
    ''');
  }

  Future<int> insertUser(UserModel user) async {
    Database db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<List<UserModel>> getAllUsers() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return UserModel.fromMap(maps[i]);
    });
  }

  Future<UserModel?> getUserByPhoneNumber(String phoneNumber) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('users', where: 'phoneNumber = ?', whereArgs: [phoneNumber]);
    if (maps.isEmpty) {
      return null;
    } else {
      return UserModel.fromMap(maps.first);
    }
  }

  Future<int> deleteUserByPhoneNumber(String phoneNumber) async {
    Database db = await instance.database;
    return await db.delete('users', where : 'phoneNumber =?', whereArgs: [phoneNumber]);
  }
}
