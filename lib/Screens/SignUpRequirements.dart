import 'package:flutter/material.dart';
import 'package:vaccination_registration/Services/AuthenticationServices.dart';
import 'package:vaccination_registration/DataModels/UserDataModel.dart';
import 'package:vaccination_registration/Shared/palette.dart';

import '../Shared/SharedResources.dart';

class ProvideDetails extends StatefulWidget {
  @override
  _ProvideDetailsState createState() => _ProvideDetailsState();
}

class _ProvideDetailsState extends State<ProvideDetails> {
  final AuthenticationServices _authServices = AuthenticationServices();
  UserDataModel _userData = UserDataModel();
  Map dataFromSignUp = {};
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    dataFromSignUp = ModalRoute.of(context).settings.arguments;
    return (loading) ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FillDetailsText(),
            FillerImage(imagePath: 'assets/images/vaccinated.jpg'),
            _signUpRequirements(),
          ],
        ),
      ),
    );
  }

  Widget _signUpRequirements() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 30),
                  TextFormField(
                    style: textFieldContent,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Scholar Id...',
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
                      setState(() => _userData.scholarId = value);
                    },
                    validator: (value) => verifyScholarId(value),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    style: textFieldContent,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Name...',
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
                      setState(() => _userData.name = value);
                    },
                    validator: (value) => value != '' ? null : 'Field cannot be empty',
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    style: textFieldContent,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Age...',
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
                      setState(() => _userData.age = value);
                    },
                    validator: (value) => value != '' ? null : 'Field cannot be empty',
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    style: textFieldContent,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Phone Number...',
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
                      setState(() => _userData.phoneNumber = value);
                    },
                    validator: (value) => verifyPhoneNumber(value),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    style: textFieldContent,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Residence...',
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
                      setState(() => _userData.residenceAddress = value);
                    },
                    validator: (value) => value != '' ? null : 'Field cannot be empty',
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    style: textFieldContent,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Blood Group...',
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
                      setState(() => _userData.bloodGroup = value);
                    },
                    validator: (value) => verifyBloodGroup(value),
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
                            setState(() {
                              loading = true;
                            });
                            _userData.email = dataFromSignUp['email'];
                            if(await _authServices.signUpUser(_userData, dataFromSignUp['password']) != null) {
                              toastMessage('Account created successfully!', context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                            else {
                              setState(() {
                                loading = false;
                              });
                              toastMessage('Error signing up with these credentials!', context);
                              Navigator.pushReplacementNamed(context, 'RegisterScreen');
                            }
                          }
                        },
                        icon: Icon(Icons.person_add_alt_1),
                        label: Text(
                          'Complete Registration', style: moveAhead,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FillDetailsText extends StatelessWidget {
  const FillDetailsText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Text(
          'Fill in a few important details!',
          style: fillDetails,
        ),
      ),
    );
  }
}
