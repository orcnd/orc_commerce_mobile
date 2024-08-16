import 'package:flutter/material.dart';
import 'package:orc_commerce_mobile/views/home_page.dart';
import 'package:orc_commerce_mobile/views/login_page.dart';
import 'package:orc_commerce_mobile/models/auth.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes() {
    final auth = Auth();
    return {
      '/': (context) => HomePage(),
      '/home': (context) => HomePage(),
      '/login': (context) => auth.user == null ? LoginPage() : HomePage(),
    };
  }
}
