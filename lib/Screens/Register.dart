import 'package:flutter/material.dart';
import 'package:vaccination_registration/Shared/SharedResources.dart';
import 'package:vaccination_registration/Shared/palette.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LogoImage(),
              FillerImage(imagePath: 'assets/images/register_img.jpg'),
              RegisterText(),
              FormTextLabel(),
              _signUpForm(),
              _LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _signUpForm() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                style: textFieldContent,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Email...',
                  labelStyle: textFieldLabel,
                  fillColor: Colors.grey[100],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[700], width: 2.0)
                  ),
                ),
                onChanged: (value) {
                  setState(() => email = value);
                },
                validator: (value) => _verifyEmail(value),
              ),
              SizedBox(height: 30),
              TextFormField(
                style: textFieldContent,
                obscureText: true,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Password...',
                  labelStyle: textFieldLabel,
                  fillColor: Colors.grey[100],
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue[700], width: 2.0)
                  ),
                ),
                onChanged: (value) {
                  setState(() => password = value);
                },
                validator: (value) => _verifyPassword(value),
              ),
              SizedBox(height: 30),
              Container(
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
                  onPressed: () {
                    if(_formKey.currentState.validate()) {
                      setState(() => password = password.hashCode.toString());
                      Navigator.pushNamed(
                          context, 'ProvideDetails', arguments: {
                        'email': email, 'password': password
                      });
                    }
                  },
                  icon: Icon(Icons.how_to_reg),
                  label: Text('Move Ahead!', style: moveAhead),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

dynamic _verifyPassword(String value) {
  if(value == '')
    return 'Field cannot be empty...';
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~-]).{8,32}$';
  String onError = 'Password must have\nAt-least one upper case letter\nAt-least one lower case letter\nAt-least one digit\nAt-least one valid special character\nMust be between 8 to 32 characters long';
  RegExp regExp = new RegExp(pattern);
  if(regExp.hasMatch(value)) return null;
  else return onError;
}

dynamic _verifyEmail(String value) {
  if(value == '')
    return 'Field cannot be empty...';
  String pattern = r'^[a-z]+_(ug|pg)@[a-z]+\.(nits.ac.in)$';
  String onError = 'Use your institute GSuite email id only';
  RegExp regExp = new RegExp(pattern);
  if(regExp.hasMatch(value)) return null;
  else return onError;
}
class FormTextLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Container(
        width: size.width * 0.91,
        child: Text(
          'Remember : Use your GSuite Account only!',
          style: registerHeading2,
        ),
      ),
    );
  }
}

class RegisterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Get Registered!',
        style: registerText,
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account?',
          style: loginButton.copyWith(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: GestureDetector(
            child: Text(
              'Sign In!',
              style: loginButton.copyWith(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, 'LoginScreen');
            },
          ),
        ),
      ],
    );
  }
}