import 'package:samacharpatra/core/business/entities/article_entity.dart';

class ArticleModel extends ArticleEntity {
  ArticleModel({
    required super.source,
    required super.author,
    required super.title,
    required super.description,
    required super.url,
    required super.urlToImage,
    required super.publishedAt,
    required super.content,
  });

  @override
  String toString() {
    return "ArticleModel {source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content}";
  }

  // from json
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      source: json['source'] ?? {},
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

  // to json
  Map<String, dynamic> toJson() {
    return {
      'source': source,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  // from entity
  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
      source: entity.source,
      author: entity.author,
      title: entity.title,
      description: entity.description,
      url: entity.url,
      urlToImage: entity.urlToImage,
      publishedAt: entity.publishedAt,
      content: entity.content,
    );
  }

  // to entity
  ArticleEntity toEntity() {
    return ArticleEntity(
      source: source,
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }
}
