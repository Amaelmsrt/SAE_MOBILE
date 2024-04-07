import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteService {
  Future<void> onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE CATEGORIE (
        idCat TEXT PRIMARY KEY,
        nomCat TEXT NOT NULL
      )
    """);

    await db.execute("""
      CREATE TABLE OBJET (
        idObjet TEXT PRIMARY KEY,
        nomObjet TEXT NOT NULL,
        descriptionObjet TEXT NOT NULL,
        statutObjet INTEGER,
        photoObjet BLOB NOT NULL
      )
    """);

    await db.execute("""
      CREATE TABLE ANNONCE (
        idAnnonce TEXT PRIMARY KEY,
        titreAnnonce TEXT NOT NULL,
        descriptionAnnonce TEXT NOT NULL,
        datePubliAnnonce TEXT NOT NULL,
        dateAideAnnonce TEXT NOT NULL,
        estUrgente INTEGER NOT NULL,
        etatAnnonce INTEGER NOT NULL
      )
    """);

    await db.execute("""
      CREATE TABLE CATEGORISER_OBJET (
        idObjet TEXT NOT NULL,
        idAnnonce TEXT NOT NULL,
        PRIMARY KEY (idObjet, idAnnonce),
        FOREIGN KEY (idObjet) REFERENCES OBJET (idObjet),
        FOREIGN KEY (idAnnonce) REFERENCES ANNONCE (idAnnonce)
      )
    """);

    await db.execute("""
      CREATE TABLE CATEGORISER_ANNONCE (
        idCat TEXT NOT NULL,
        idAnnonce TEXT NOT NULL,
        PRIMARY KEY (idCat, idAnnonce),
        FOREIGN KEY (idCat) REFERENCES CATEGORIE (idCat),
        FOREIGN KEY (idAnnonce) REFERENCES ANNONCE (idAnnonce)
      )
    """);
  }

  Future<Database> initializeDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: onCreate,
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute("DROP TABLE IF EXISTS CATEGORISER_OBJET");
        await db.execute("DROP TABLE IF EXISTS CATEGORISER_ANNONCE");
        await db.execute("DROP TABLE IF EXISTS OBJET");
        await db.execute("DROP TABLE IF EXISTS ANNONCE");
        await db.execute("DROP TABLE IF EXISTS CATEGORIE");
        onCreate(db, newVersion);
      },
      version: 2,
    );
  }
}