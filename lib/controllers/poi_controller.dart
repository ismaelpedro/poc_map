import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/poi_model.dart';

class POIController extends GetxController {
  var pois = <POI>[].obs;
  Database? database;

  @override
  void onInit() {
    super.onInit();
    initDatabase();
  }

  Future<void> initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'pois.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS pois('
          'id INTEGER PRIMARY KEY, '
          'title TEXT, '
          'description TEXT, '
          'category TEXT, '
          'latitude REAL, '
          'longitude REAL)',
        );
      },
      version: 1,
    );
    loadPOIs();
  }

  Future<void> loadPOIs() async {
    final List<Map<String, dynamic>> maps = await database!.query('pois');
    pois.value = List.generate(maps.length, (i) {
      return POI(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        category: maps[i]['category'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
      );
    });
    pois.refresh();
  }

  Future<void> addPOI(POI poi) async {
    int id = await database!.insert(
      'pois',
      {
        'title': poi.title,
        'description': poi.description,
        'category': poi.category,
        'latitude': poi.latitude,
        'longitude': poi.longitude,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    poi.id = id;
    pois.add(poi);
    pois.refresh();
  }
}
