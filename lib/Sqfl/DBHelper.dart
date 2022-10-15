import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:project_photo_learn/Sqfl/ClassAlbum.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'Photo.dart';

class DBHelper {
  //
  static Database? _db;
  static const String TABLE_PHOTO = 'PhotosTable';
  static const String TABLE_CLASS = 'ClassTable';
  static const String DB_NAME = 'database.db';

  Future<Database?> get db async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final db = openDatabase(
      join(documentsDirectory.path, DB_NAME),
    );
  }

  delete_database() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File filedatabase = await new File(join(documentsDirectory.path, DB_NAME));
    bool checkfile = await filedatabase.existsSync();
    File filedatabaseJ =
        await new File(join(documentsDirectory.path, "database.db-journal"));
    if (checkfile) {
      /*final db2 = await openDatabase(
        join(documentsDirectory.path, DB_NAME),
      );*/
      filedatabaseJ.delete();
      filedatabase.delete();

      //เขียนลบ database
    }
    print(await openDatabase(
      join(documentsDirectory.path, DB_NAME),
    ));
    print('db ลบแล้วววววววววววววววววว');
  }

  checkDatabase() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    File filedatabase = await new File(join(documentsDirectory.path, DB_NAME));
    bool checkfile = await filedatabase.existsSync();

    if (checkfile) {
      final db2 = await openDatabase(
        join(documentsDirectory.path, DB_NAME),
      );
      print(await db2.runtimeType);
      _db = await db2;
      print('db ไม่ว่างงงงงงงง');
      return await _db;

      //เขียนลบ database
    }

    _db = await initDB();
    print('db ว่างงงงงงงง');
    return await _db;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db2 = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db2;
  }

  _onCreate(Database db, int version) async {
    String id = 'id';
    String photoName = 'photoName';
    String photopath = 'photopath';
    String photokeyword = 'photokeyword';
    String photodescriptions = 'photodescriptions';
    String photoclass = 'photoclass';
    String fixalbum = 'fixalbum';
    String statuscloud = 'statuscloud';
    String Cloud_Storage = 'Cloud_Storage';

    String NAMEALBUM = 'NAMEALBUM';
    String DESCRIPTIONALBUM = 'DESCRIPTIONALBUM';
    String IDENTITYALBUM = 'IDENTITYALBUM';
    String KEYWORDALBUM = 'KEYWORDALBUM';

    await db.execute(
        'CREATE TABLE $TABLE_CLASS ($NAMEALBUM TEXT PRIMARY KEY , $DESCRIPTIONALBUM TEXT ,$IDENTITYALBUM TEXT ,$KEYWORDALBUM TEXT)');
    print("dddddddddddmakkkkkkkkkkkkk");
    await db.execute(
        'CREATE TABLE $TABLE_PHOTO ($id TEXT PRIMARY KEY, $photoName TEXT ,$photopath TEXT , $photokeyword TEXT ,$photodescriptions TEXT,$fixalbum TEXT ,$statuscloud TEXT ,$photoclass TEXT,$Cloud_Storage TEXT)');
  }

  saveAlbum(var album, var db) async {
    var dbClient = await db;
    print("อลับั้มมมมมม");
    print(await dbClient);
    final id = await dbClient.insert(TABLE_CLASS, album,
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(id);
    Database f;
  }

  deletedata_intable() async {
    DBHelper db = DBHelper();
    var db2 = await db.checkDatabase();
    print("ลบข้อมูล");
    print(await db2.delete(
      TABLE_PHOTO,
    ));
    await db2.delete(
      TABLE_CLASS,
    );
  }

  getPhoto() async {
    var db2 = await checkDatabase();

    return (await db2.query(TABLE_PHOTO));
  }

  getPhotoinAlbum(var namealbum) async {
    var db = await checkDatabase();
    //var name = "'" + '"' + "photoclass" + '"' + ' = ' + namealbum + "'";
    var dbClient = await db;
    return (await dbClient
        .query(TABLE_PHOTO, where: '"photoclass" = ?', whereArgs: [namealbum]));
  }

  getPhoto_from_keyword(var keyword) async {
    var db = await checkDatabase();
    //var name = "'" + '"' + "photoclass" + '"' + ' = ' + namealbum + "'";
    var dbClient = await db;
    return (await dbClient
        .query(TABLE_PHOTO, where: '"photokeyword" = ?', whereArgs: [keyword]));
  }

  getPhoto_from_id(var id) async {
    var db = await checkDatabase();
    //var name = "'" + '"' + "photoclass" + '"' + ' = ' + namealbum + "'";
    var dbClient = await db;
    return (await dbClient
        .query(TABLE_PHOTO, where: '"id" = ?', whereArgs: [id]));
  }

  getAlbum() async {
    //DBHelper db = DBHelper();
    var db2 = await checkDatabase();
    return (await db2.query(TABLE_CLASS));
  }

  getData_Album(var namealbum) async {
    //DBHelper db = DBHelper();
    var db2 = await checkDatabase();

    return (await db2
        .query(TABLE_CLASS, where: '"NAMEALBUM" = ?', whereArgs: [namealbum]));
  }

  Future<Photo?> savePhoto(Photo photo, var db) async {
    print('^^^^^^^^^^^^^^^^^^');
    print(photo.toString());
    print('^^^^^^^^^^^^^^^^^^');
    var dbClient = await db;
    var p = photo.toMap();
    print('^^^^^^^^^======^^^^^^^^^');
    print(dbClient?.path);
    print(p['photopath']);
    print('^^^^^^^^^======^^^^^^^^^');
    final id = await dbClient.insert(TABLE_PHOTO, p,
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(id);
    Database f;

    print(await dbClient.query(TABLE_PHOTO));
    print(dbClient?.path);
    //List<Map> maps =
    // await dbClient!.query(TABLE_PHOTO, columns: ['id', 'photoName']);
    //for (int i = 0; i < maps.length; i++) {
    //print(maps[i]);
    //}
    return photo;
  }

  DeletePhoto(String id) async {
    return 'delete sucess';
  }

  YaiPhoto(String id) async {
    return 'yai sucess';
  }

  /*Future<ClassAlbum?> saveAlbum(ClassAlbum album) async {
    var dbClient = await db;
    await dbClient?.insert(TABLE_CLASS, album.toMap())!;
    return album;
  }

  DeleteAlbum(Photo photo) async {
    return 'delete sucess';
  }

  Future<List<ClassAlbum>> getAlbum() async {
    var dbClient = await db;
    List<Map> maps = await dbClient!
        .query(TABLE_CLASS, columns: ['idAlbum', 'nameAlbum', 'keywordAlbum']);
    List<ClassAlbum> albumg = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        print(maps[i].runtimeType);
        albumg.add(ClassAlbum.fromMap(maps[i], true));
      }
    }
    return albumg;
  }*/

  /*Future<List<Photo>> getPhotos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient!.query(TABLE, columns: [ID, NAME]);
    List<Photo> photos = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        print(maps[i].runtimeType);
        photos.add(Photo.fromMap(maps[i], true));
      }
    }
    return photos;
  }*/

  Future close() async {
    var dbClient = await db;
    dbClient?.close();
  }
}
/*import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:project_photo_learn/Sqfl/ClassAlbum.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'Photo.dart';

class DBHelper {
  //
  static Database? _db;
  static const String ID = 'id';
  static const String NAME = 'photoName';
  static const String TABLE_PHOTO = 'PhotosTable';
  static const String TABLE_CLASS = 'ClassTable';
  static const String DB_NAME = 'database.db';

  Future<Database?> get db async {
    if (null != _db) {
      io.Directory documentsDirectory =
          await getApplicationDocumentsDirectory();

      final _db = openDatabase(
        join(documentsDirectory.path, DB_NAME),
      );
      print('db ไม่ว่างงงงงงงง');
      return _db;
    }
    _db = await initDB();
    print('db ว่างงงงงงงง');
    return _db;
  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    String id = 'id';
    String photoName = 'photoName';
    String photopath = 'photopath';
    String photokeyword = 'photokeyword';
    String photoclass = 'photoclass';

    await db.execute('CREATE TABLE $TABLE_CLASS ($ID TEXT, $NAME TEXT)');
    await db.execute(
        'CREATE TABLE $TABLE_PHOTO ($id TEXT, $photoName TEXT ,$photopath TEXT , $photokeyword TEXT ,$photoclass TEXT)');
  }

  Future<Photo?> savePhoto(Photo photo) async {
    var dbClient = await _db;
    await dbClient?.insert(TABLE_PHOTO, photo.toMap())!;
    //List<Map> maps = await dbClient!.query(TABLE_PHOTO, columns: [ID, NAME]);
    //for (int i = 0; i < maps.length; i++) {
    //print(maps[i]);
    //}
    return photo;
  }

  DeletePhoto(String id) async {
    return 'delete sucess';
  }

  YaiPhoto(String id) async {
    return 'yai sucess';
  }

  Future<ClassAlbum?> saveAlbum(ClassAlbum album) async {
    var dbClient = await _db;
    await dbClient?.insert(TABLE_CLASS, album.toMap())!;
    return album;
  }

  DeleteAlbum(Photo photo) async {
    return 'delete sucess';
  }

  Future<List<ClassAlbum>> getAlbum() async {
    var dbClient = await db;
    List<Map> maps = await dbClient!
        .query(TABLE_CLASS, columns: ['idAlbum', 'nameAlbum', 'keywordAlbum']);
    List<ClassAlbum> albumg = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        print(maps[i].runtimeType);
        albumg.add(ClassAlbum.fromMap(maps[i], true));
      }
    }
    return albumg;
  }

  Future<List<Photo>> getPhotos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient!.query(TABLE_PHOTO, columns: [ID, NAME]);
    List<Photo> photos = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        print(maps[i].runtimeType);
        photos.add(Photo.fromMap(maps[i], true));
      }
    }
    return photos;
  }

  Future close() async {
    var dbClient = await db;
    dbClient?.close();
  }
}*/
