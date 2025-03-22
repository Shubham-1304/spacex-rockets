
// lib/core/database/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// class RocketDataManager {
//   // Singleton pattern implementation
//   static final RocketDataManager _instance =
//       RocketDataManager._internal();
//   factory RocketDataManager() => _instance;
//   RocketDataManager._internal();

//   // State management
//   List<RocketModel> _rockets = [];

//   // Getters
//   List<Rocket> get rockets => _rockets;

//   Rocket rocketById(String id) {
//     final index = _binarySearch(id);
//     if (index != null) {
//       return _rockets[index];
//     }
//     throw const ManagerFailure(message: "Not Found", statusCode: 404);
//   }

//   void getRockets(List<Rocket> rockets) {
//     rockets.sort((s1, s2) => s1.id.compareTo(s2.id));
//     _rockets = rockets
//         .map((rocket) =>
//             RocketModel.fromRocket(rocket))
//         .toList();
//     // print("_rocket list: $_rockets");
//   }

//   // Helper methods for state management
//   int? _binarySearch(String id) {
//     int left = 0;
//     int right = _rockets.length - 1;
//     // print("$left $right $_rockets $id ..");

//     while (left <= right) {
//       int mid = ((left + right) / 2).floor();
//       int result = _rockets[mid].id.compareTo(id);
//       if (result==0) {
//         return mid;
//       } else if (result<0) {
//         left = mid + 1;
//       } else {
//         right = mid - 1;
//       }
//     }
//     return null;
//   }
// }

class RocketDataManager {
  static final RocketDataManager _instance = RocketDataManager._internal();
  static Database? _database;

  factory RocketDataManager() => _instance;

  RocketDataManager._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cache_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cache (
        id TEXT PRIMARY KEY,
        data TEXT,
        timestamp INTEGER
      )
    ''');
  }

  Future<void> cacheApiResponse(String cacheKey, String data) async {
    final db = await database;
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    
    await db.insert(
      'cache',
      {
        'id': cacheKey,
        'data': data,
        'timestamp': timestamp,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getCachedResponse(String cacheKey) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cache',
      columns: ['data', 'timestamp'],
      where: 'id = ?',
      whereArgs: [cacheKey],
    );

    if (maps.isNotEmpty) {
      return maps.first['data'] as String;
    }
    return null;
  }

  Future<bool> isCacheExpired(String cacheKey, Duration maxAge) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cache',
      columns: ['timestamp'],
      where: 'id = ?',
      whereArgs: [cacheKey],
    );

    if (maps.isEmpty) {
      return true;
    }

    final timestamp = maps.first['timestamp'] as int;
    final now = DateTime.now().millisecondsSinceEpoch;
    return (now - timestamp) > maxAge.inMilliseconds;
  }

  Future<void> clearCache(String cacheKey) async {
    final db = await database;
    await db.delete(
      'cache',
      where: 'id = ?',
      whereArgs: [cacheKey],
    );
  }

  Future<void> clearAllCache() async {
    final db = await database;
    await db.delete('cache');
  }
}
