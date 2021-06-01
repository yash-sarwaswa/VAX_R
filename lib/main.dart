import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'DataModels/UserModel.dart';
import 'Services/AuthenticationServices.dart';
import 'Shared/MaterialApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<StudentUser>.value(
      value: AuthenticationServices().studentUser,
      child: BaseMaterialApp(),
      initialData: null,
    );
  }
}




