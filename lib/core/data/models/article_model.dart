import 'dart:convert';

import 'package:samacharpatra/core/business/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  ArticleModel({
    required super.id,
    required super.source,
    required super.author,
    required super.title,
    required super.description,
    required super.url,
    required super.urlToImage,
    required super.publishedAt,
    required super.content,
    required super.saved,
  });

  @override
  String toString() {
    return "ArticleModel {source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content}";
  }

  // from json
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] ?? 0,
      source: json['source'] ?? {},
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
      saved: json['saved'] ?? false,
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source': source,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'saved': saved,
    };
  }

  // from entity
  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
      id: entity.id,
      source: entity.source,
      author: entity.author,
      title: entity.title,
      description: entity.description,
      url: entity.url,
      urlToImage: entity.urlToImage,
      publishedAt: entity.publishedAt,
      content: entity.content,
      saved: entity.saved,
    );
  }

  // to entity
  ArticleEntity toEntity() {
    return ArticleEntity(
      id: id,
      source: source,
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
      saved: saved,
    );
  }

  // from local data
  factory ArticleModel.fromLocal(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['article_id'] ?? 0,
      source: jsonDecode(json['source']),
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
      saved: json['saved'] ?? true,
    );
  }

  // to local data
  Map<String, dynamic> toLocal() {
    return {
      'source': jsonEncode(source),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}
