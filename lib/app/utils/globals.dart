import 'dart:developer';

import 'package:hkdigiskill/app/models/user/user_model.dart';
import 'package:intl/intl.dart';

class Globals {
  static UserModel? userData;

  static String fixLocalhostUrl(String url) {
    if (url.contains("localhost")) {
      return url.replaceFirst("localhost", "192.168.29.196");
    }
    return url;
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd MMM, yyyy').format(date);
  }
}
