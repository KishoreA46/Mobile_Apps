enum ResourceType { article, video, chart, practice }

class ResourceModel {
  final String id;
  final ResourceType type;
  final String title;
  final String description;
  final String? url;
  final String? imageUrl;

  ResourceModel({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    this.url,
    this.imageUrl,
  });
}
