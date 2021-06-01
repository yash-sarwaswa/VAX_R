import 'package:flutter/material.dart';
import 'package:vaccination_registration/Services/AuthenticationServices.dart';
import 'package:vaccination_registration/Shared/palette.dart';
import '../Shared/SharedResources.dart';

final AuthenticationServices _authServices = AuthenticationServices();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _scholarId = '';
  String _password = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return (loading) ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LogoImage(),
              FightText(),
              FillerImage(imagePath: 'assets/images/loginScreenImage.png'),
              LoginText(),
              _loginForm(),
              _SignupButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.number,
              style: textFieldContent,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Scholar ID...',
                labelStyle: textFieldLabel,
                fillColor: Colors.grey[200],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[700], width: 2.0)
                ),
              ),
              validator: (value) => verifyScholarId(value),
              onChanged: (value) {
                setState(() => _scholarId = value);
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              style: textFieldContent,
              obscureText: true,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Password...',
                labelStyle: textFieldLabel,
                fillColor: Colors.grey[200],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[700], width: 2.0)
                ),
              ),
              onChanged: (value) {
                setState(() => _password = value.hashCode.toString());
              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[700],
                      offset: Offset(-1.0, 1.0),
                    )
                  ]
                ),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      //Sign-In
                      setState(() {
                        loading = true;
                      });
                      if(await _authServices.signInUser(_scholarId, _password) != null) {
                        toastMessage('Successfully logged in!', context);
                        Navigator.pop(context);
                      }
                      else {
                        setState(() {
                          loading = false;
                        });
                        toastMessage('Error signing in with these credentials!', context);
                        Navigator.pushReplacementNamed(context, 'LoginScreen');
                      }
                    }
                  },
                  icon: Icon(Icons.login),
                  label: Text(
                    'Sign In!', style: moveAhead,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class LoginText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Sign In!',
        style: registerText,
      ),
    );
  }
}

class FightText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      '#IndiaFightsCovid',
      style: fightText,
    );
  }
}

class _SignupButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'New User?',
            style: loginButton.copyWith(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: GestureDetector(
              child: Text(
                'Sign Up!',
                style: loginButton.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, 'RegisterScreen');
              },
            ),
          ),
        ],
      ),
    );
  }
}