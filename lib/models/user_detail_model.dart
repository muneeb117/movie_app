class UserDetail {
  final String userId;
  final String name;
  final String email;

  UserDetail({
    required this.userId,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': name,
      'email': email,
    };
  }

  factory UserDetail.fromMap(Map<String, dynamic> map, String userId) {
    return UserDetail(
      userId: userId,
      name: map['userName'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
