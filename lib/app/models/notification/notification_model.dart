import 'package:flutter/material.dart';

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final IconData? icon;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    this.icon,
  });
}
