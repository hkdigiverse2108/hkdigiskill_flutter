import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/chat/chat_model.dart';

class ChatsController extends GetxController {
  final isEditing = false.obs;
  final selectedChats = <int>{}.obs;
  final chats = <ChatModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with some dummy data if needed
    chats.assignAll([
      ChatModel(
        name: 'Andrew Parker',
        lastMessage: 'What kind of strategy is better?',
        date: '11/16/19',
        avatarUrl: null,
        messageIcon: const Icon(Icons.done_all, size: 16, color: Colors.blue),
      ),
      // Add other chat items here
    ]);
  }

  void toggleEditMode() {
    isEditing.value = !isEditing.value;
    if (!isEditing.value) {
      selectedChats.clear();
    }
    update();
  }

  void selectChat(int index) {
    if (selectedChats.contains(index)) {
      selectedChats.remove(index);
    } else {
      selectedChats.add(index);
    }
    update();
  }

  void deleteSelectedChats() {
    if (selectedChats.isEmpty) return;
    
    // Sort indices in descending order to avoid index shifting when removing
    final sortedIndices = selectedChats.toList()..sort((a, b) => b.compareTo(a));
    
    for (final index in sortedIndices) {
      if (index < chats.length) {
        chats.removeAt(index);
      }
    }
    
    selectedChats.clear();
    isEditing.value = false;
    update();
  }
}
