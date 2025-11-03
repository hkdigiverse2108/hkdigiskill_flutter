class Workshop {
  final String id;
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;
  final String thumbnailUrl;
  final String status;
  final String? instructor;
  final String? instructorTitle;
  final String? instructorImage;
  final String? duration;
  final int? capacity;
  final double? price;
  final String? category;
  final List<String>? requirements;
  final List<String>? whatYouWillLearn;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Workshop({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
    required this.thumbnailUrl,
    required this.status,
    this.instructor,
    this.instructorTitle,
    this.instructorImage,
    this.duration,
    this.capacity,
    this.price,
    this.category,
    this.requirements,
    this.whatYouWillLearn,
    this.createdAt,
    this.updatedAt,
  });

  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      thumbnailUrl: json['thumbnailUrl'],
      status: json['status'],
      instructor: json['instructor'],
      instructorTitle: json['instructorTitle'],
      instructorImage: json['instructorImage'],
      duration: json['duration'],
      capacity: json['capacity'],
      price: json['price']?.toDouble(),
      category: json['category'],
      requirements: json['requirements'] != null ? List<String>.from(json['requirements']) : null,
      whatYouWillLearn: json['whatYouWillLearn'] != null ? List<String>.from(json['whatYouWillLearn']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      'thumbnailUrl': thumbnailUrl,
      'status': status,
      'instructor': instructor,
      'instructorTitle': instructorTitle,
      'instructorImage': instructorImage,
      'duration': duration,
      'capacity': capacity,
      'price': price,
      'category': category,
      'requirements': requirements,
      'whatYouWillLearn': whatYouWillLearn,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Workshop copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    String? time,
    String? location,
    String? thumbnailUrl,
    String? status,
    String? instructor,
    String? instructorTitle,
    String? instructorImage,
    String? duration,
    int? capacity,
    double? price,
    String? category,
    List<String>? requirements,
    List<String>? whatYouWillLearn,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Workshop(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      location: location ?? this.location,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      status: status ?? this.status,
      instructor: instructor ?? this.instructor,
      instructorTitle: instructorTitle ?? this.instructorTitle,
      instructorImage: instructorImage ?? this.instructorImage,
      duration: duration ?? this.duration,
      capacity: capacity ?? this.capacity,
      price: price ?? this.price,
      category: category ?? this.category,
      requirements: requirements ?? this.requirements,
      whatYouWillLearn: whatYouWillLearn ?? this.whatYouWillLearn,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
