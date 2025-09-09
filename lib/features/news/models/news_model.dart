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

class NewsResponse {
  final String status;
  final int totalResults;
  final List<NewsModel> results;
  final String? nextPage;

  NewsResponse({
    required this.status,
    required this.totalResults,
    required this.results,
    this.nextPage,
  });

  factory NewsResponse.fromJson(Map<String, dynamic> json) {
    return NewsResponse(
      status: json['status'] ?? '',
      totalResults: json['totalResults'] ?? 0,
      results: (json['results'] as List? ?? [])
          .map((data) => NewsModel.fromJson(data as Map<String, dynamic>))
          .toList(),
      nextPage: json['nextPage'],
    );
  }
}
