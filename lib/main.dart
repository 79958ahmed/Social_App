
import 'package:flutter/material.dart';

import 'modules/Cart.dart';
import 'modules/food.dart';
import 'modules/social_app/social_login/social_login_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' ',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:SocialLoginScreen(),
    );
  }
}