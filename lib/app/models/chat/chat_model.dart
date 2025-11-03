import 'package:flutter/material.dart';

class ChatModel {
  final String name;
  final String lastMessage;
  final String date;
  final String? avatarUrl;
  final Widget? messageIcon;

  ChatModel({
    required this.name,
    required this.lastMessage,
    required this.date,
    this.avatarUrl,
    this.messageIcon,
  });
}
