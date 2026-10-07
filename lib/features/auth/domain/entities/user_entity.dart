import 'package:equatable/equatable.dart';

/// Pure domain entity representing an authenticated user.
class UserEntity extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final String authProvider; // 'google', 'apple', 'email'
  final DateTime createdAt;

  const UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    required this.authProvider,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, email, displayName, photoUrl, authProvider, createdAt];
}
