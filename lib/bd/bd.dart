import 'dart:async';
import 'dart:io';
import 'package:projet_final/models/utilisateur.dart';
import 'package:projet_final/models/twitt.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DB{

  DB._privateConstructor();
  static final DB instance = DB._privateConstructor();

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await initializeDB();

  Future<Database> initializeDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    return await openDatabase(
      join(documentsDirectory.path, 'users.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE utilisateur(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    prenom TEXT NOT NULL, 
    nom TEXT NOT NULL, 
    identifiant TEXT NOT NULL,
    mdp TEXT NOT NULL
    )        
    ''');
    await db.execute('''
    CREATE TABLE twitte(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    utilisateurId INTEGER NOT NULL,  
    pseudo TEXT NOT NULL, 
    twitt TEXT NOT NULL,
    like INTEGER,
    unlike INTEGER,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (utilisateurId) REFERENCES utilisateur (id) ON DELETE NO ACTION ON UPDATE NO ACTION
    )        
    ''');
  }
  Future<int> insert(Utilisateurs user) async {
    Database db = await instance.database;
    return await db.insert(
      'utilisateur',
      user.toMap(),
    );
  }

  Future<int> insertTwitt(Twitts twitt) async {
    Database db = await instance.database;
    return await db.insert(
      'twitte',
      twitt.toMap(),
    );
  }

  Future<Utilisateurs?> connexion(String identifiant, String mdp) async {
    Database db = await instance.database;
    var res = await db.rawQuery("SELECT * FROM utilisateur WHERE identifiant = '$identifiant' AND mdp = '$mdp'");

    if (res.length > 0) {
      return new Utilisateurs.fromMap(res.first);
    }
    return null;
  }

  Future<Utilisateurs?> utilisateurExistant(String identifiant) async {
    Database db = await instance.database;
    var res = await db.rawQuery("SELECT * FROM utilisateur WHERE identifiant = '$identifiant'");

    if (res.length > 0) {
      return new Utilisateurs.fromMap(res.first);
    }
    return null;
  }

  Future<void> update(Utilisateurs utilisateur) async {

    final db = await instance.database;
    await db.update(
      'utilisateur',
      utilisateur.toMap(),
      where: 'id = ?',
      whereArgs: [utilisateur.id],
    );
  }

  Future<void> updateLike(Twitts tweet) async {

    final db = await instance.database;
    await db.update(
      'twitte',
      tweet.toMap(),
      where: 'id = ?',
      whereArgs: [tweet.id],
    );
  }

  Future<List<Twitts>> allTwitt() async {

    final db = await instance.database;
    var twits = await db.rawQuery("SELECT * FROM twitte order by date");
    List<Twitts> twitsList = twits.isNotEmpty
        ? twits.map((c) => Twitts.fromMap(c)).toList()
        : [];
    return twitsList;
  }

  Future<List<Twitts>> twitteById(int utilisateurId) async {
    Database db = await instance.database;
    var twits = await db.rawQuery("SELECT * FROM twitte WHERE utilisateurId = '$utilisateurId'");
    List<Twitts> twitsList = twits.isNotEmpty
        ? twits.map((c) => Twitts.fromMap(c)).toList()
        : [];
    return twitsList;
    }

  Future<void> delete(int id) async {

    final db =await instance.database;
    await db.delete(
      'twitte',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}

