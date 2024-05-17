import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenemind/services/auth_service.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      final authService = Provider.of<AuthService>(context, listen: false);
      if (authService.isLoggedIn()) {
        Navigator.pushReplacementNamed(context, '/profile');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    return Scaffold(
      body: Center(
        child: Text('SereneMind', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
