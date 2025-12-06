import 'package:hkdigiskill/app/models/workshop/workshop_model.dart';

class WorkshopPurchaseModel {
  final String? id;
  final WorkshopModel? workshop;
  final UserShortModel? user;
  final num? amount;
  final String? paymentStatus;
  final String? paymentMethod;
  final String? paymentId;
  final String? transactionDate;
  final num? discountAmount;
  final num? finalAmount;
  final bool? isDeleted;
  final bool? isBlocked;
  final String? createdAt;
  final String? updatedAt;

  WorkshopPurchaseModel({
    this.id,
    this.workshop,
    this.user,
    this.amount,
    this.paymentStatus,
    this.paymentMethod,
    this.paymentId,
    this.transactionDate,
    this.discountAmount,
    this.finalAmount,
    this.isDeleted,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
  });

  factory WorkshopPurchaseModel.fromJson(Map<String, dynamic> json) {
    return WorkshopPurchaseModel(
      id: json["_id"],
      workshop: json["workshopId"] != null
          ? WorkshopModel.fromJson(json["workshopId"])
          : null,
      user: json["userId"] != null
          ? UserShortModel.fromJson(json["userId"])
          : null,
      amount: json["amount"],
      paymentStatus: json["paymentStatus"],
      paymentMethod: json["paymentMethod"],
      paymentId: json["paymentId"],
      transactionDate: json["transactionDate"],
      discountAmount: json["discountAmount"],
      finalAmount: json["finalAmount"],
      isDeleted: json["isDeleted"],
      isBlocked: json["isBlocked"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "workshopId": workshop?.toJson(),
      "userId": user?.toJson(),
      "amount": amount,
      "paymentStatus": paymentStatus,
      "paymentMethod": paymentMethod,
      "paymentId": paymentId,
      "transactionDate": transactionDate,
      "discountAmount": discountAmount,
      "finalAmount": finalAmount,
      "isDeleted": isDeleted,
      "isBlocked": isBlocked,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}

class WorkshopShortModel {
  final String? id;
  final String? image;
  final String? title;
  final String? subTitle;
  final num? price;
  final num? mrpPrice;
  final String? language;
  final String? duration;

  WorkshopShortModel({
    this.id,
    this.image,
    this.title,
    this.subTitle,
    this.price,
    this.mrpPrice,
    this.language,
    this.duration,
  });

  factory WorkshopShortModel.fromJson(Map<String, dynamic> json) {
    return WorkshopShortModel(
      id: json["_id"],
      image: json["image"],
      title: json["title"],
      subTitle: json["subTitle"],
      price: json["price"],
      mrpPrice: json["mrpPrice"],
      language: json["language"],
      duration: json["duration"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "image": image,
      "title": title,
      "subTitle": subTitle,
      "price": price,
      "mrpPrice": mrpPrice,
      "language": language,
      "duration": duration,
    };
  }
}

class UserShortModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? profilePhoto;
  final String? designation;

  UserShortModel({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.password,
    this.profilePhoto,
    this.designation,
  });

  factory UserShortModel.fromJson(Map<String, dynamic> json) {
    return UserShortModel(
      id: json["_id"],
      fullName: json["fullName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      password: json["password"],
      profilePhoto: json["profilePhoto"],
      designation: json["designation"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "fullName": fullName,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "profilePhoto": profilePhoto,
      "designation": designation,
    };
  }
}
