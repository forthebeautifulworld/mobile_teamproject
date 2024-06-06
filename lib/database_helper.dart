import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        // "users" 테이블 생성
        db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, birth TEXT, userId TEXT, password TEXT)",
        );
        // "stores" 테이블 생성
        db.execute(
          "CREATE TABLE stores(id INTEGER PRIMARY KEY AUTOINCREMENT, storeName TEXT, ownerName TEXT, storeLocation TEXT, storePhone TEXT, businessNumber TEXT, ownerPhone TEXT, storeType TEXT, avgPrice INTEGER, menuFile TEXT, layoutFile TEXT, maxCapacity INTEGER, storeFeatures TEXT)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        if (oldVersion < 2) {
          // "stores" 테이블 생성 쿼리 실행
          db.execute(
            "CREATE TABLE stores(id INTEGER PRIMARY KEY AUTOINCREMENT, storeName TEXT, ownerName TEXT, storeLocation TEXT, storePhone TEXT, businessNumber TEXT, ownerPhone TEXT, storeType TEXT, avgPrice INTEGER, menuFile TEXT, layoutFile TEXT, maxCapacity INTEGER, storeFeatures TEXT)",
          );
        }
      },
    );
  }
  Future<void> insertStore(Map<String, dynamic> store) async {
    final db = await database;
    await db.insert(
      'stores',
      store,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<List<Map<String, dynamic>>> getStores() async {
    final db = await database;
    return await db.query('stores');
  }
}

