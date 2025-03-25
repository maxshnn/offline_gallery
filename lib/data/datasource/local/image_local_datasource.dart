import 'dart:io';

import 'package:offline_gallery/data/model/image_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ImageLocalDatasource {
  static final ImageLocalDatasource instance = ImageLocalDatasource._instance();
  static Database? _database;

  ImageLocalDatasource._instance();

  ImageLocalDatasource();

  Future<Database> get db async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      return await databaseFactory.openDatabase(inMemoryDatabasePath);
    }
    final pathToDatabase = await getDatabasesPath();
    final path = '$pathToDatabase/offline_gallery.db';
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(''' CREATE TABLE images (
      id INTEGER PRIMARY KEY,
      image TEXT
    )''');
  }

  Future<List<ImageModel>> readAll() async {
    final db = await instance.db;
    final response = await db.query('images');
    return response
        .map(
          (row) => ImageModel.fromMap(row),
        )
        .toList();
  }

  Future<void> insertImages(List<ImageModel> images) async {
    final db = await instance.db;
    final batch = db.batch();

    for (final image in images) {
      batch.insert(
        'images',
        image.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> deleteAll() async {
    final db = await instance.db;
    await db.delete('images');
  }
}
