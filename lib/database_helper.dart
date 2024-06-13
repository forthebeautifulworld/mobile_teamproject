import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // DatabaseHelper 클래스의 싱글톤 인스턴스 생성
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  // 데이터베이스 객체
  static Database? _database;
  // 내부 생성자
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  // 데이터베이스 초기화
  Future<Database> _initDatabase() async {
    // 데이터베이스 파일 경로 생성
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        // 데이터베이스 생성 시 호출되는 콜백
        // users 테이블 생성
        db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, birth TEXT, userId TEXT, password TEXT)",
        );
        db.execute(
          // stores 테이블 생성
          "CREATE TABLE stores(id INTEGER PRIMARY KEY AUTOINCREMENT, storeName TEXT, ownerName TEXT, storeLocation TEXT, storePhone TEXT, businessNumber TEXT, ownerPhone TEXT, storeType TEXT, avgPrice INTEGER, menuFile TEXT, layoutFile TEXT, maxCapacity INTEGER, storeFeatures TEXT)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {
        // 데이터베이스 업그레이드 시 호출되는 콜백
        if (oldVersion < 2) {
          db.execute(
            "CREATE TABLE stores(id INTEGER PRIMARY KEY AUTOINCREMENT, storeName TEXT, ownerName TEXT, storeLocation TEXT, storePhone TEXT, businessNumber TEXT, ownerPhone TEXT, storeType TEXT, avgPrice INTEGER, menuFile TEXT, layoutFile TEXT, maxCapacity INTEGER, storeFeatures TEXT)",
          );
        }
      },
    );
  }
  // 가게 정보 삽입
  Future<void> insertStore(Map<String, dynamic> store) async {
    final db = await database;
    await db.insert(
      'stores',
      store,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  // 사용자 정보 삽입
  Future<void> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
// 사용자 정보 삭제
  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  // 가게 정보 삭제
  Future<void> deleteStore(int id) async {
    final db = await database;
    await db.delete(
      'stores',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  // 모든 사용자 정보 조회
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }
  // 모든 가게 정보 조회
  Future<List<Map<String, dynamic>>> getStores() async {
    final db = await database;
    return await db.query('stores');
  }
  // 가게 수 조회
  Future<int> getStoreCount() async {
    final db = await database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM stores'))!;
  }
  // 가게의 사업자 번호 목록 조회
  Future<List<String>> getBusinessNumbers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('stores', columns: ['businessNumber']);
    return List.generate(maps.length, (i) {
      return maps[i]['businessNumber'];
    });
  }
  // 사업자 번호로 가게 이름 조회
  Future<String> getStoreNameByBusinessNumber(String businessNumber) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'stores',
      columns: ['storeName'],
      where: 'businessNumber = ?',
      whereArgs: [businessNumber],
    );

    if (maps.isNotEmpty) {
      return maps.first['storeName'];
    } else {
      throw Exception('Store not found');
    }
  }
}
