import 'dart:async';
// import 'dart:js';
import 'package:flutter/material.dart';
import 'package:new_firebase/ui/auth/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }
}
