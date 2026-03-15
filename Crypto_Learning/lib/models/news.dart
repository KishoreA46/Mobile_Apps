class NewsModel {
  final String title;
  final String domain;
  final String url;
  final DateTime publishedAt;

  NewsModel({
    required this.title,
    required this.domain,
    required this.url,
    required this.publishedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? 'No Title',
      domain: json['domain'] ?? 'Unknown Source',
      url: json['url'] ?? '',
      publishedAt: DateTime.parse(
        json['published_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
