class Announcement {
  final String id;
  final String title;
  final String content;
  final DateTime timestamp;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'content': content,
    'timestamp': timestamp.toIso8601String(),
  };

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    timestamp: DateTime.parse(json['timestamp']),
  );
} 