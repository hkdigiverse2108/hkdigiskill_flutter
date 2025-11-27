class UserModel {
  bool isEmailVerified;
  String role;
  String id;
  String email;
  String fullName;
  String token;

  UserModel({
    required this.isEmailVerified,
    required this.role,
    required this.id,
    required this.email,
    required this.fullName,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    isEmailVerified: json["isEmailVerified"],
    role: json["role"],
    id: json["_id"],
    email: json["email"],
    fullName: json["fullName"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "isEmailVerified": isEmailVerified,
    "role": role,
    "_id": id,
    "email": email,
    "fullName": fullName,
    "token": token,
  };
}
