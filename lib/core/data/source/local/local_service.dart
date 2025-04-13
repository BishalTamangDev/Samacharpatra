import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:samacharpatra/core/business/entities/article_entity.dart';
import 'package:samacharpatra/core/errors/failures/failures.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/article_model.dart';

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
      final int version = 1;

      // database path
      final String path = join(await getDatabasesPath(), databaseName);

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
      final Database db = await getDatabase();

      final String query = '''
        SELECT * FROM $articleTbl
      ''';

      final data = await db.rawQuery(query);

      final List<ArticleEntity> articles = data.map((datum) => ArticleModel.fromLocal(datum).toEntity()).toList();

      return Right(articles);
    } catch (e, stackTrace) {
      debugPrint("Error fetching saved articles :: $e\n$stackTrace");
      return Left(LocalStorageFailure());
    }
  }

  // search article if saved
  Future<bool> isSaved(String url) async {
    try {
      final Database db = await getDatabase();

      final articles = await db.query(articleTbl, where: "url = ?", whereArgs: [url]);

      return articles.isEmpty ? false : true;
    } catch (e, stackTrace) {
      debugPrint("Error check article if saved :: $e\n$stackTrace");
      return false;
    }
  }

  // save article
  Future<bool> save(ArticleEntity article) async {
    try {
      final Database db = await getDatabase();

      final Map<String, dynamic> data = ArticleModel.fromEntity(article).toLocal();

      final int rowsAffected = await db.insert(articleTbl, data);

      return rowsAffected > 0;
    } catch (e, stackTrace) {
      debugPrint("Error saving article :: $e\n$stackTrace");
      return false;
    }
  }

  // un-save article
  Future<bool> delete(ArticleEntity article) async {
    try {
      final Database db = await getDatabase();

      final int rowsAffected = await db.delete(articleTbl, where: "url = ?", whereArgs: [article.url]);

      return rowsAffected > 0;
    } catch (e, stackTrace) {
      debugPrint("Error deleting article :: $e\n$stackTrace");
      return false;
    }
  }

  // delete all saved articles
  Future<bool> deleteAll() async {
    try {
      Database db = await getDatabase();

      await db.delete(articleTbl);

      return true;
    } catch (e, stackTrace) {
      debugPrint("Error deleting saved articles :: $e\n$stackTrace");
      return false;
    }
  }
}
