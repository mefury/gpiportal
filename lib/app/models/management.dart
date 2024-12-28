class Management {
  final String id;
  final String name;
  final String position;
  final String bio;
  final String? imageUrl;

  Management({
    required this.id,
    required this.name,
    required this.position,
    required this.bio,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'position': position,
    'bio': bio,
    'image_url': imageUrl,
  };

  factory Management.fromJson(Map<String, dynamic> json) => Management(
    id: json['id'],
    name: json['name'],
    position: json['position'],
    bio: json['bio'],
    imageUrl: json['image_url'],
  );
} 