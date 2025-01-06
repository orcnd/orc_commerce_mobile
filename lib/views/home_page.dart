import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:orc_commerce_mobile/views/layout_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutPage(
        title: 'Home Page', child: Text('Welcome to the Home Page'));
  }
}
