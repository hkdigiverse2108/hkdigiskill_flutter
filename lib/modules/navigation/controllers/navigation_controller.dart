import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/modules/category/views/category.dart';
import 'package:hkdigiskill/modules/chat/views/chats.dart';
import 'package:hkdigiskill/modules/courses/views/courses.dart';
import 'package:hkdigiskill/modules/home/views/home_screen.dart';
import 'package:hkdigiskill/modules/workshops/views/workshops.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  List<Widget> pages = [
    HomeScreen(),
    Category(),
    Courses(),
    Workshops(),
    Chats(),
  ];

  void changePage(int index) {
    currentIndex.value = index;
  }
}
