class NewsModel {
  final String id;
  final String title;
  final String description;
  final String? content;
  final String link;
  final String imageUrl;
  final String pubDate;
  final String sourceName;
  final String? author;
  final String? category;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    this.content,
    required this.link,
    required this.imageUrl,
    required this.pubDate,
    required this.sourceName,
    this.author,
    this.category,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'],
      link: json['link'] ?? '',
      imageUrl: json['image_url'] ?? json['imageUrl'] ?? '',
      pubDate: json['pubDate'] ?? json['pub_date'] ?? '',
      sourceName: json['source_name'] ?? json['sourceName'] ?? '',
      author: json['author'],
      category: json['category'],
      isActive: json['is_active'] ?? json['isActive'] ?? true,
      createdAt:
          DateTime.tryParse(json['created_at'] ?? json['createdAt'] ?? '') ??
          DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updated_at'] ?? json['updatedAt'] ?? '') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'content': content,
      'link': link,
      'image_url': imageUrl,
      'pubDate': pubDate,
      'source_name': sourceName,
      'author': author,
      'category': category,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
