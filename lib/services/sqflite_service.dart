import 'package:allo/models/annonce_sqflite.dart';
import 'package:allo/models/objet_sqflite.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteService {
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE CATEGORIE_ANNONCE (
        idCat INTEGER PRIMARY KEY AUTOINCREMENT,
        nomCat TEXT NOT NULL
      )
    """);

    await db.execute("""
      CREATE TABLE CATEGORIE_OBJET (
        idCat INTEGER PRIMARY KEY AUTOINCREMENT,
        nomCat TEXT NOT NULL
      )
    """);

    await db.execute("""
      CREATE TABLE OBJET (
        idObjet INTEGER PRIMARY KEY AUTOINCREMENT,
        nomObjet TEXT,
        descriptionObjet TEXT,
        statutObjet INTEGER,
        photoObjet BLOB
      )
    """);

    await db.execute("""
      CREATE TABLE ANNONCE (
        idAnnonce INTEGER PRIMARY KEY AUTOINCREMENT,
        titreAnnonce TEXT,
        descriptionAnnonce TEXT,
        datePubliAnnonce TEXT,
        dateAideAnnonce TEXT,
        estUrgente INTEGER,
        etatAnnonce INTEGER,
        prixAnnonce REAL
      )
    """);

    await db.execute("""
      CREATE TABLE PHOTO_ANNONCE (
        idPhotoAnnonce INTEGER PRIMARY KEY AUTOINCREMENT,
        photo BLOB
      )
    """);
  }

  Future<Database> initializeDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS PHOTO_ANNONCE");
        await db.execute("DROP TABLE IF EXISTS CATEGORIE_OBJET");
        await db.execute("DROP TABLE IF EXISTS CATEGORIE_ANNONCE");
        await db.execute("DROP TABLE IF EXISTS OBJET");
        await db.execute("DROP TABLE IF EXISTS ANNONCE");
        await onCreate(db, newVersion);
        print("Database upgraded from version $oldVersion to $newVersion");
      },
      version: 7,
    );
  }

  static Future<void> ajouterAnnonceBrouillon(AnnonceSQFLite annonce) async {
    final Database db = await SqfliteService().initializeDB();
    await db.insert(
      'ANNONCE',
      {
        'titreAnnonce': annonce.titreAnnonce,
        'descriptionAnnonce': annonce.descriptionAnnonce,
        'dateAideAnnonce': annonce.dateAideAnnonce.toString(),
        'estUrgente': annonce.estUrgente ? 1 : 0,
        'prixAnnonce': annonce.prixAnnonce,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await db.delete('PHOTO_ANNONCE');
    await db.delete('CATEGORIE_ANNONCE');
    for (Uint8List image in annonce.images) {
      await db.insert(
        'PHOTO_ANNONCE',
        {'photo': image},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    for (String categorie in annonce.categories) {
      await db.insert(
        'CATEGORIE_ANNONCE',
        {'nomCat': categorie},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<AnnonceSQFLite?> getAnnonceBrouillon() async {
    final Database db = await SqfliteService().initializeDB();
    final List<Map<String, dynamic>> annonce = await db.query('ANNONCE');
    if (annonce.isEmpty) {
      return null;
    }
    final List<Map<String, dynamic>> photos = await db.query('PHOTO_ANNONCE');
    final List<Map<String, dynamic>> categories =
        await db.query('CATEGORIE_ANNONCE');
    AnnonceSQFLite annonceSQFLite = AnnonceSQFLite(
      titreAnnonce: annonce[0]['titreAnnonce'],
      descriptionAnnonce: annonce[0]['descriptionAnnonce'],
      dateAideAnnonce: DateTime.parse(annonce[0]['dateAideAnnonce']),
      estUrgente: annonce[0]['estUrgente'] == 1 ? true : false,
      prixAnnonce: annonce[0]['prixAnnonce'],
    );
    for (Map<String, dynamic> photo in photos) {
      annonceSQFLite.addImage(photo['photo']);
    }
    for (Map<String, dynamic> categorie in categories) {
      annonceSQFLite.categories.add(categorie['nomCat']);
    }
    return annonceSQFLite;
  }

  static Future<void> supprimerAnnonceBrouillon() async {
    final Database db = await SqfliteService().initializeDB();
    await db.delete('ANNONCE');
    await db.delete('PHOTO_ANNONCE');
    await db.delete('CATEGORIE_ANNONCE');
  }

  static Future<void> ajouterObjetBrouillon(ObjetSQFLite objet) async {
    final Database db = await SqfliteService().initializeDB();
    await db.insert(
      'OBJET',
      {
        'nomObjet': objet.nomObjet,
        'descriptionObjet': objet.descriptionObjet,
        'photoObjet': objet.photoObjet,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    await db.delete('CATEGORIE_OBJET');
    for (String categorie in objet.categories) {
      await db.insert(
        'CATEGORIE_OBJET',
        {'nomCat': categorie},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  static Future<ObjetSQFLite?> getObjetBrouillon() async {
    final Database db = await SqfliteService().initializeDB();
    final List<Map<String, dynamic>> objet = await db.query('OBJET');
    if (objet.isEmpty) {
      return null;
    }
    final List<Map<String, dynamic>> categories =
        await db.query('CATEGORIE_OBJET');
    ObjetSQFLite objetSQFlite = ObjetSQFLite(
      nomObjet: objet[0]['nomObjet'],
      descriptionObjet: objet[0]['descriptionObjet'],
      photoObjet: objet[0]['photoObjet'],
    );
    for (Map<String, dynamic> categorie in categories) {
      objetSQFlite.categories.add(categorie['nomCat']);
    }
    return objetSQFlite;
  }

  static Future<void> supprimerObjetBrouillon() async {
    final Database db = await SqfliteService().initializeDB();
    await db.delete('OBJET');
    await db.delete('CATEGORIE_OBJET');
  }
}
