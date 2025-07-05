class AuthResponse {
  final bool success;
  final AuthData data;
  final String message;

  AuthResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    final body = json['body'] as Map<String, dynamic>;

    return AuthResponse(
      success: body['success'] as bool,
      data: AuthData.fromJson(body['data'] as Map<String, dynamic>),
      message: body['message'] as String,
    );
  }
}

class AuthData {
  final String? token;
  final Author? author;

  AuthData({this.token, this.author});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      token: json['token'],
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
    );
  }
}

class Author {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? bio;
  final String? avatarUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Author({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.bio,
    this.avatarUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      bio: json['bio'],
      avatarUrl: json['avatarUrl'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  String get fullName => '$firstName $lastName';
}

class ProfileResponse {
  final bool success;
  final Author data;
  final String message;

  ProfileResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    final body = json['body'] as Map<String, dynamic>;

    return ProfileResponse(
      success: body['success'] as bool,
      data: Author.fromJson(body['data'] as Map<String, dynamic>),
      message: body['message'] as String,
    );
  }
}

class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }
}
