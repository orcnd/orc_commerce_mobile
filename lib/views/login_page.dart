import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:orc_commerce_mobile/controllers/user_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Consumer<UserController>(
        builder: (context, userController, child) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: userController.isLoading
                          ? null
                          : () {
                              final email = _emailController.text;
                              final password = _passwordController.text;
                              userController.login(email, password, context);
                            },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ),
              if (userController.isLoading)
                Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: LoadingAnimationWidget.stretchedDots(
                      color: const Color.fromARGB(255, 55, 67, 234),
                      size: 200,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
