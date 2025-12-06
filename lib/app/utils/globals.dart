import 'dart:developer';

import 'package:hkdigiskill/app/models/settings/settings_model.dart';
import 'package:hkdigiskill/app/models/user/user_model.dart';
import 'package:intl/intl.dart';

class Globals {
  static UserModel? userData;

  static AppSettings? appSettings;

  static String fixLocalhostUrl(String url) {
    if (url.contains("localhost")) {
      return url.replaceFirst("localhost", "192.168.29.195");
    }
    return url;
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd MMM, yyyy').format(date);
  }

  static String convertMinutesToHoursDays(int minutes) {
    if (minutes == 0) {
      return "0 minutes";
    }

    int hours = minutes ~/ 60;
    int days = hours ~/ 24;
    hours = hours % 24;

    String result = "";
    if (days > 0) {
      result += "$days day";
      if (days > 1) result += "s ";
    }
    if (hours > 0) {
      result += "$hours hour";
      if (hours > 1) result += "s ";
    }
    if (minutes <= 60) {
      result += "$minutes minute";
      if (minutes > 1) result += "s ";
    }

    return result.trim();
  }
}
