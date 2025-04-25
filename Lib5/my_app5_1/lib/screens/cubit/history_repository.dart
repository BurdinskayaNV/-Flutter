// history_repository.dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Для desktop
import 'package:sqflite/sqflite.dart'; // Для mobile
import 'package:path/path.dart';
import 'dart:io';

class HistoryRepository {
  static final HistoryRepository _instance = HistoryRepository._internal();
  factory HistoryRepository() => _instance;

  late Database _database;

  HistoryRepository._internal();

  Future<void> init() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      // Инициализация для desktop
      sqfliteFfiInit(); // Инициализация FFI
      final databaseFactory = databaseFactoryFfi; // Получаем фабрику для desktop

      _database = await databaseFactory.openDatabase(
        join(Directory.current.path, 'history.db'),
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) {
            return db.execute(
              "CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT, capital REAL, rate REAL, time REAL, interest REAL, totalAmount REAL)",
            );
          },
        ),
      );
    } else {
      // Инициализация для mobile
      _database = await openDatabase(
        join(await getDatabasesPath(), 'history.db'),
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE history(id INTEGER PRIMARY KEY AUTOINCREMENT, capital REAL, rate REAL, time REAL, interest REAL, totalAmount REAL)",
          );
        },
        version: 1,
      );
    }
  }

  Future<void> saveCalculation(double capital, double rate, double time, double interest, double totalAmount) async {
    await _database.insert(
      'history',
      {
        'capital': capital,
        'rate': rate,
        'time': time,
        'interest': interest,
        'totalAmount': totalAmount,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getHistory() async {
    return await _database.query('history');
  }

  Future<void> clearHistory() async {
    await _database.delete('history');
  }
  
  getDatabaseFactory({required String ffiLibraryPath}) {}
}