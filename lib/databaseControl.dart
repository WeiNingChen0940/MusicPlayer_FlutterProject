import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Settings {
  String name = '';
  int intValue = 0;
  int boolValue = 0;
  String stringValue = '';

  Settings(
      {required this.name,
      this.intValue = 0,
      this.boolValue = 0,
      this.stringValue = ''});

  Settings.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    intValue = map['intValue'];
    boolValue = map['boolValue'];
    stringValue = map['stringValue'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'intValue': intValue,
      'boolValue': boolValue,
      'stringValue': stringValue,
    };
  }

  void show() {
    Fluttertoast.showToast(
        msg:
            'name: $name, intValue: $intValue, boolValue: $boolValue, stringValue: $stringValue');
  }
}

class DatabaseControl {
  String path =
      join(getApplicationDocumentsDirectory().toString(), 'settings.db');
  Future<Database>? _db;

  DatabaseControl() {
    _createDatabase();
  }

  void _createDatabase() async {
    _db = openDatabase(path, onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS settings(name TEXT, intValue INTEGER, boolValue INTEGER, stringValue TEXT)');
    }, version: 1);
  }

  Future<List<Settings>> getSettings() async {
    Database db = await _db!;
    List<Map<String, dynamic>> maps = await db.query('settings');
    if (maps.isNotEmpty) {
      return [for (var map in maps) Settings.fromMap(map)];
    }
    return [];
  }

  Future<int> setSettings(Settings settings) async {
    Database db = await _db!;
    var num = await db
        .delete('settings', where: 'name = ?', whereArgs: [settings.name]);
    //Fluttertoast.showToast(msg: 'delete:$num');
    var result = await db.insert('settings', settings.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    //Fluttertoast.showToast(msg: 'insert');
    return result;
  }

  void deleteSettings(String name) async {
    Database db = await _db!;
    var num = await db.delete('settings', where: 'name = ?', whereArgs: [name]);
    //Fluttertoast.showToast(msg: 'delete:$num');
  }

  Future<void> deleteSongs() async {
    Database db = await _db!;
    int count = 0;
    while (true) {
      var num = await db
          .delete('settings', where: 'name = ?', whereArgs: ['musicDir$count']);
      count += 1;
      if (num == 0) {
        break;
      }
      print('delete:$num');
    }

    Fluttertoast.showToast(msg: 'delete all!');
  }
}
