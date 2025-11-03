import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/chat/message_model.dart';

class ChatController extends GetxController {
  final List<ChatMessage> messages = [
    ChatMessage(text: "Good bye!", time: "17:47", isMe: true),
    ChatMessage(text: "Good morning!", time: "10:10", isMe: true),
    ChatMessage(text: "Japan looks amazing!", time: "10:10", isMe: true),
    ChatMessage(
      isFile: true,
      filename: "IMG_0475",
      filesize: "2.4 MB • png",
      isMe: true,
      time: "10:15",
    ),
    ChatMessage(
      isFile: true,
      filename: "IMG_0481",
      filesize: "2.8 MB • png",
      isMe: true,
      time: "10:15",
    ),
    ChatMessage(
      text: "Do you know what time is it?",
      time: "11:40",
      isMe: false,
    ),
    ChatMessage(text: "It's morning in Tokyo 😎", time: "11:43", isMe: true),
    ChatMessage(
      text: "What is the most popular meal in Japan?",
      time: "11:45",
      isMe: false,
    ),
    ChatMessage(text: "Do you like it?", time: "11:45", isMe: false),
    ChatMessage(text: "I think top two are:", time: "11:51", isMe: true),
    ChatMessage(
      isFile: true,
      filename: "IMG_0483",
      filesize: "2.8 MB • png",
      isMe: true,
      time: "11:51",
    ),
    ChatMessage(
      isFile: true,
      filename: "IMG_0484",
      filesize: "2.6 MB • png",
      isMe: true,
      time: "11:51",
    ),
  ];

  final textController = TextEditingController();

  // Add message to list
  void sendMessage() {
    final text = textController.text.trim();
    if (text.isNotEmpty) {
      messages.add(
        ChatMessage(
          text: text,
          time: TimeOfDay.now().format(Get.context!),
          isMe: true,
          isFile: false,
        ),
      );
      textController.clear();
    }
  }
}
