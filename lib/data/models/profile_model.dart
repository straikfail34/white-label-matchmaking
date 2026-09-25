class ProfileModel {
  final String id;
  final String displayName;
  final int? age;
  final String? bio;
  final List<String> photos;
  final List<String> tags;
  final DateTime createdAt;

  ProfileModel({
    required this.id,
    required this.displayName,
    this.age,
    this.bio,
    required this.photos,
    required this.tags,
    required this.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      displayName: json['display_name'] as String,
      age: json['age'] as int?,
      bio: json['bio'] as String?,
      photos: List<String>.from(json['photos'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'display_name': displayName,
      'age': age,
      'bio': bio,
      'photos': photos,
      'tags': tags,
      'created_at': createdAt.toIso8601String(),
    };
  }
}