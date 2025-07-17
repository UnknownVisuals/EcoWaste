class NewsModel {
  final String title;
  final String description;
  final String link;
  final String imageUrl;
  final String pubDate;
  final String sourceName;

  NewsModel({
    required this.title,
    required this.description,
    required this.link,
    required this.imageUrl,
    required this.pubDate,
    required this.sourceName,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      link: json['link'] ?? '',
      imageUrl: json['image_url'] ?? '',
      pubDate: json['pubDate'] ?? '',
      sourceName: json['source_name'] ?? '',
    );
  }
}
