import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:orc_commerce_mobile/controllers/main_controller.dart';
import 'package:orc_commerce_mobile/controllers/user_controller.dart';
import 'package:orc_commerce_mobile/controllers/admin/main_controller.dart';
import 'package:orc_commerce_mobile/controllers/admin/category_controller.dart';
import 'package:orc_commerce_mobile/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => AdminMainController()),
        ChangeNotifierProvider(create: (_) => AdminCategoryController()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'orc Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: Routes.getRoutes(),
    );
  }
}
