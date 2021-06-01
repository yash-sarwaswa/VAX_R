import 'package:flutter/material.dart';
import '../Screens/SignUpRequirements.dart';
import '../Screens/Register.dart';
import '../Screens/Login.dart';
import '../Screens/SettingsPage.dart';
import '../Screens/UserDashboard.dart';
import '../Screens/WelcomeScreen.dart';
import '../Services/IsAuthorized.dart';

class BaseMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IsAuthorized(),
      routes: {
        'WelcomeScreen': (context) => WelcomeScreen(),
        'LoginScreen': (context) => Login(),
        'RegisterScreen': (context) => SignUp(),
        'ProvideDetails': (context) => ProvideDetails(),
        'Dashboard': (context) => UserDashboard(),
        'SettingsPage': (context) => Settings(),
      },
    );
  }
}
