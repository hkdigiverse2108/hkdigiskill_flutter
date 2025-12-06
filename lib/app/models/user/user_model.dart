class UserModel {
  String id;
  String fullName;
  String email;
  String? phoneNumber;
  String? profilePhoto;
  String? designation;
  String? referralCode;
  bool agreeTerms;
  String role;
  bool isEmailVerified;
  bool isDeleted;
  bool isBlocked;
  String? otp;
  DateTime? otpExpireTime;
  DateTime createdAt;
  DateTime updatedAt;

  // Token from login API (not always present)
  String? token;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    this.profilePhoto,
    this.designation,
    this.referralCode,
    required this.agreeTerms,
    required this.role,
    this.otp,
    this.otpExpireTime,
    required this.isEmailVerified,
    required this.isDeleted,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    profilePhoto: json["profilePhoto"],
    designation: json["designation"],
    referralCode: json["referralCode"],
    agreeTerms: json["agreeTerms"] ?? false,
    role: json["role"],
    otp: json["otp"],
    otpExpireTime: json["otpExpireTime"] != null
        ? DateTime.parse(json["otpExpireTime"])
        : null,
    isEmailVerified: json["isEmailVerified"] ?? false,
    isDeleted: json["isDeleted"] ?? false,
    isBlocked: json["isBlocked"] ?? false,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),

    // token comes only from login response
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "phoneNumber": phoneNumber,
    "profilePhoto": profilePhoto,
    "designation": designation,
    "referralCode": referralCode,
    "agreeTerms": agreeTerms,
    "role": role,
    "otp": otp,
    "otpExpireTime": otpExpireTime?.toIso8601String(),
    "isEmailVerified": isEmailVerified,
    "isDeleted": isDeleted,
    "isBlocked": isBlocked,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "token": token,
  };
}
