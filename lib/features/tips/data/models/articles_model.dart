class Article {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String content;
  // final List<String> keyTakeaways;

  Article({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.content,
  });

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      content: map['content'] ?? '',
      // keyTakeaways: List<String>.from(map['keyTakeaways'] ?? []),

    );
  }
}
