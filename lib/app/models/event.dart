class Event {
  final String id;
  final String title;
  final String description;
  final String venue;
  final DateTime dateTime;
  final String? imageUrl;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.venue,
    required this.dateTime,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'venue': venue,
    'date_time': dateTime.toIso8601String(),
    'image_url': imageUrl,
  };

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    venue: json['venue'],
    dateTime: DateTime.parse(json['date_time']),
    imageUrl: json['image_url'],
  );
} 