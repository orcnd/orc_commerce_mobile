import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:orc_commerce_mobile/controllers/main_controller.dart';
import 'package:orc_commerce_mobile/models/auth.dart';
import 'package:orc_commerce_mobile/controllers/user_controller.dart';

class HomePage extends StatelessWidget {
  final Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);

    final mainController = Provider.of<MainController>(context);
    String name = '';
    if (auth.user != null) {
      name = " " + auth.user!.name!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu' + name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
            ),
            AdminMenu(),
            if (auth.user != null)
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  userController.logout(context);
                },
              ),
            if (auth.user == null)
              ListTile(
                leading: Icon(Icons.login),
                title: Text('Login'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/login');
                },
              ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to the Home Page'),
      ),
    );
  }
}

class AdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    final auth = userController.auth;

    if (auth.user?.role != 'admin') {
      // return something empty
      return Container();
    }

    return ExpansionTile(
      title: Text('Admin'),
      leading: Icon(Icons.admin_panel_settings),
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.category),
          title: Text('Categories'),
          onTap: () {
            Navigator.pop(context);
            // Navigator.pushNamed(context, '/admin/categories');
          },
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Products'),
          onTap: () {
            Navigator.pop(context); // Drawer'ı kapatır
            // Navigator.pushNamed(context, '/admin/products');
          },
        ),
      ],
    );
  }
}
