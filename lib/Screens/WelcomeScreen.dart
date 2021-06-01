import 'package:flutter/material.dart';
import 'package:vaccination_registration/Shared/SharedResources.dart';
import 'package:vaccination_registration/Shared/palette.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WelcomeScreenBody(),
    );
  }
}

class WelcomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          LogoImage(),
          TextWidget2(),
          FillerImage(imagePath: 'assets/images/get_vaccinated.jpg'),
          TextWidget1(),
          SizedBox(height: 30),
          LoginButton(),
          SizedBox(height: 10),
          SignupButton(),
        ],
      ),
    );
  }
}

class TextWidget1 extends StatelessWidget {
  const TextWidget1({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Text(
          "Do Your Part !",
          style: mainHeading1,
        ),
      ),
    );
  }
}

class TextWidget2 extends StatelessWidget {
  const TextWidget2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: Text(
          "Get Vaccinated !",
          style: mainHeading2,
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: loginButton,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: GestureDetector(
              child: Text(
                'Sign In!',
                style: loginButton.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'LoginScreen');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New User?',
            style: loginButton,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: GestureDetector(
              child: Text(
                'Sign Up!',
                style: loginButton.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'RegisterScreen');
              },
            ),
          ),
        ],
      ),
    );
  }
}

