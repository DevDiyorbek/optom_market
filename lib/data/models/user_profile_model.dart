class UserProfile {
  final int id;
  final String firstName;
  final String? lastName;
  final String? phoneNumber;
  final String image;
  final int telegramId;
  final String? username;
  final DateTime createdAt;
  final String? address;
  final bool isAdmin;

  UserProfile({
    required this.id,
    required this.firstName,
    this.lastName,
    required this.phoneNumber,
    required this.image,
    required this.telegramId,
    required this.username,
    required this.createdAt,
    this.address,
    required this.isAdmin,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
      image: json['image'],
      telegramId: json['telegram_id'],
      username: json['username'],
      createdAt: DateTime.parse(json['created_at']),
      address: json['address'],
      isAdmin: json['is_admin'],
    );
  }
}
