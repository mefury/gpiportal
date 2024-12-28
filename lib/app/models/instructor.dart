class Instructor {
  final String id;
  final String name;
  final String position;
  final String phone;
  final String email;
  final String? imageUrl;

  Instructor({
    required this.id,
    required this.name,
    required this.position,
    required this.phone,
    required this.email,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'position': position,
    'phone': phone,
    'email': email,
    'image_url': imageUrl,
  };

  factory Instructor.fromJson(Map<String, dynamic> json) => Instructor(
    id: json['id'],
    name: json['name'],
    position: json['position'],
    phone: json['phone'],
    email: json['email'],
    imageUrl: json['image_url'],
  );
} 