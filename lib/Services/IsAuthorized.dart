import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaccination_registration/Screens/UserDashboard.dart';
import 'package:vaccination_registration/Screens/WelcomeScreen.dart';
import '../DataModels/UserModel.dart';

class IsAuthorized extends StatefulWidget {
  @override
  _IsAuthorizedState createState() => _IsAuthorizedState();
}

class _IsAuthorizedState extends State<IsAuthorized> {
  @override
  Widget build(BuildContext context) {
    final _studentUser = Provider.of<StudentUser>(context);
    return (_studentUser != null) ? UserDashboard() : WelcomeScreen();
  }
}
