import 'package:flutter/material.dart';
import 'package:orc_commerce_mobile/models/auth.dart';

class UserController extends ChangeNotifier {
  final Auth auth = Auth();

  bool get isLoggedIn => auth.user != null;
  bool isLoading = false;

  Future<void> login(
      String email, String password, BuildContext context) async {
    if (auth.user != null) {
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();
    AuthResponse resp = await auth.login(email, password);
    isLoading = false;
    notifyListeners();
    if (resp.status) {
      Navigator.of(context)
          .pushReplacementNamed('/home'); // Navigate to home page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resp.message ?? 'Login failed')),
      );
    }
  }

  void logout(context) {
    auth.logout();
    notifyListeners();
    Navigator.of(context)
        .pushReplacementNamed('/home'); // Redirect to login page
  }
}
