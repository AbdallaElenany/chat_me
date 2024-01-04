class UserModel {
  UserModel({
    required this.userId,
    required this.name,
    required this.phone,
    required this.email,
  });
  String userId;
  String name;
  String phone;
  String email;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'name': name,
        'phone': phone,
        'email': email,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['userId'] as String,
        name: json['name'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String,
      );
}

class User {
  final int id;
  final String name;
  final String imageUrl;

  User({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}
