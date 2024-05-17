import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:serenemind/services/auth_service.dart';
import 'package:serenemind/screens/splash_screen.dart';
import 'package:serenemind/screens/login_screen.dart';
/* import 'package:your_app/screens/login_screen.dart';
import 'package:your_app/screens/register_screen.dart';
import 'package:your_app/screens/profile_screen.dart'; */
import 'package:serenemind/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'SereneMind',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        routes: {
           '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}
