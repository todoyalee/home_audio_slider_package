import 'package:hope_audio_slider/views/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hope_audio_slider/views/page1.dart';
import 'package:hope_audio_slider/views/page2.dart';

class AppRoutes {
  static String home = '/';
  static String mainPage = '/MainPage';
  static String page1 = '/page1';
  static String page2 = '/page2';

  static List<GetPage> pages = [
    GetPage(name: mainPage, page: () => MainPage()),
    GetPage(name: page1, page: () => Page1()),
    GetPage(name: page2, page: () => Page2()),
  ];
}
