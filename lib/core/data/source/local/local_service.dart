import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/data/models/article_model.dart';
import 'package:samacharpatra/core/errors/failures/failures.dart';
import 'package:sqflite/sqflite.dart';

class LocalService {
  // private constructor
  LocalService._();

  // database
  Database? _database;

  // singleton
  static LocalService getInstance() => LocalService._();

  // database name
  static final String databaseName = "samacharpatra.db";

  // table
  static final String articleTbl = "article_tbl";

  // open database & create table
  static Future<Database?> _initializeDatabase() async {
    try {
      int version = 1;

      // database path
      String path = join(await getDatabasesPath(), databaseName);

      return await openDatabase(
        path,
        version: version,
        onCreate: (databasePath, version) async {
          String query = '''
            CREATE TABLE IF NOT EXISTS $articleTbl (
              article_id INTEGER PRIMARY KEY AUTOINCREMENT,
              title TEXT,
              description TEXT,
              author TEXT,
              url TEXT,
              urlToImage TEXT,
              publishedAt TEXT,
              content TEXT,
              source TEXT
            )
          ''';

          await databasePath.rawQuery(query);
        },
      );
    } catch (e, stackTrace) {
      debugPrint("Error in database :: $e\n$stackTrace");
      return null;
    }
  }

  // get database
  Future<Database> getDatabase() async {
    _database ??= await _initializeDatabase();
    return _database!;
  }

  // fetch articles
  Future<Either<Failure, List<ArticleEntity>>> fetchArticles() async {
    try {
      final db = await getDatabase();

      final String query = '''
        SELECT * FROM $articleTbl
      ''';

      final data = await db.rawQuery(query);

      final List<ArticleEntity> articles = data.map((datum) => ArticleModel.fromJson(datum).toEntity()).toList();

      debugPrint("Saved articles :: $data");

      return Right(articles);
    } catch (e, stackTrace) {
      debugPrint("Error fetching saved articles :: $e\n$stackTrace");
      return Left(LocalStorageFailure());
    }
  }

  // search article if saved
  Future<bool> checkPresence(String url) async {
    return false;
  }

  // save article
  Future<bool> unSave(int id) async {
    return true;
  }

  // un-save article
  Future<bool> save(ArticleEntity article) async {
    return true;
  }
}
