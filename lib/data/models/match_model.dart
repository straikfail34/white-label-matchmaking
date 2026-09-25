import 'profile_model.dart';

class MatchModel {
  final String id;
  final List<String> users;
  final DateTime createdAt;
  final ProfileModel? matchedUser;

  MatchModel({
    required this.id,
    required this.users,
    required this.createdAt,
    this.matchedUser,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json, {ProfileModel? matchedUser}) {
    return MatchModel(
      id: json['id'] as String,
      users: List<String>.from(json['users']),
      createdAt: DateTime.parse(json['created_at'] as String),
      matchedUser: matchedUser,
    );
  }
}