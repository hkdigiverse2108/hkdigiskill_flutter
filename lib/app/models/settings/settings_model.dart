class AppSettings {
  final String id;
  final bool isDeleted;
  final String address;
  final int classCompleted;
  final DateTime createdAt;
  final String email;
  final int enrolledLearners;
  final String link;
  final String logo;
  final String phoneNumber;
  final String razorpayKey;
  final String razorpaySecret;
  final double satisfactionRate;
  final DateTime updatedAt;
  final SocialMediaLinks socialMediaLinks;

  AppSettings({
    required this.id,
    required this.isDeleted,
    required this.address,
    required this.classCompleted,
    required this.createdAt,
    required this.email,
    required this.enrolledLearners,
    required this.link,
    required this.logo,
    required this.phoneNumber,
    required this.razorpayKey,
    required this.razorpaySecret,
    required this.satisfactionRate,
    required this.updatedAt,
    required this.socialMediaLinks,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      id: json["_id"] ?? "",
      isDeleted: json["isDeleted"] ?? false,
      address: json["address"] ?? "",
      classCompleted: (json["classCompleted"] ?? 0).toInt(),
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      email: json["email"] ?? "",
      enrolledLearners: (json["enrolledLearners"] ?? 0).toInt(),
      link: json["link"] ?? "",
      logo: json["logo"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      razorpayKey: json["razorpayKey"] ?? "",
      razorpaySecret: json["razorpaySecret"] ?? "",
      satisfactionRate: (json["satisfactionRate"] ?? 0).toDouble(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
      socialMediaLinks: SocialMediaLinks.fromJson(
        json["socialMediaLinks"] ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "isDeleted": isDeleted,
      "address": address,
      "classCompleted": classCompleted,
      "createdAt": createdAt.toIso8601String(),
      "email": email,
      "enrolledLearners": enrolledLearners,
      "link": link,
      "logo": logo,
      "phoneNumber": phoneNumber,
      "razorpayKey": razorpayKey,
      "razorpaySecret": razorpaySecret,
      "satisfactionRate": satisfactionRate,
      "updatedAt": updatedAt.toIso8601String(),
      "socialMediaLinks": socialMediaLinks.toJson(),
    };
  }
}

class SocialMediaLinks {
  final String facebook;
  final String twitter;
  final String instagram;
  final String linkedin;

  SocialMediaLinks({
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.linkedin,
  });

  factory SocialMediaLinks.fromJson(Map<String, dynamic> json) {
    return SocialMediaLinks(
      facebook: json["facebook"] ?? "",
      twitter: json["twitter"] ?? "",
      instagram: json["instagram"] ?? "",
      linkedin: json["linkedin"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "facebook": facebook,
      "twitter": twitter,
      "instagram": instagram,
      "linkedin": linkedin,
    };
  }
}
