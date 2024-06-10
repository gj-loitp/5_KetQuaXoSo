import 'dart:async';
import 'package:ketquaxoso/mckimquyen/model/province.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'history.dart';

class DatabaseHelper {
  final table = "histories";
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
    String path = join(await getDatabasesPath(), 'kqxs.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $table(id TEXT PRIMARY KEY, number TEXT, datetime TEXT, callFromScreen TEXT, provinceName TEXT, provinceSlug TEXT, provinceUrl TEXT)',
    );
  }

  Future<void> insertHistory(History history) async {
    final db = await database;
    await db.insert(
      table,
      {
        'id': history.id,
        'number': history.number,
        'datetime': history.datetime,
        'callFromScreen': history.callFromScreen,
        'provinceName': history.province?.name,
        'provinceSlug': history.province?.slug,
        'provinceUrl': history.province?.url,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<History>> getHistories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return History(
        id: maps[i]['id'],
        number: maps[i]['number'],
        datetime: maps[i]['datetime'],
        callFromScreen: maps[i]['callFromScreen'],
        province: Province(
          name: maps[i]['provinceName'],
          slug: maps[i]['provinceSlug'],
          url: maps[i]['provinceUrl'],
        ),
      );
    });
  }
}
