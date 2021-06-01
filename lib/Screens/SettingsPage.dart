import 'package:flutter/material.dart';
import 'package:vaccination_registration/Services/DatabaseServices.dart';
import 'package:vaccination_registration/DataModels/UserDataModel.dart';
import 'package:vaccination_registration/Shared/SharedResources.dart';
import '../Shared/palette.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();
  Map _dataFromDashboard = {};
  UserDataModel _userDetails = UserDataModel();
  String _newName;
  String _newAge;
  String _newPhoneNumber;
  String _newResidence;
  @override
  Widget build(BuildContext context) {
    _dataFromDashboard = ModalRoute.of(context).settings.arguments;
    _userDetails = _dataFromDashboard['userData'];
    return StreamBuilder<UserDataModel>(
      stream: DatabaseServices(userDetails: _userDetails).userDataDocument,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _userDetails = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FillerImage(imagePath: 'assets/images/settings_img.jpg'),
                    _SettingsText(),
                    _editableDetailsForm(),
                  ],
                ),
              ),
            ),
          );
        }
        else {
          return Loading();
        }
      }
    );
  }

  Widget _editableDetailsForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: TextFormField(
              style: textFieldContent,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Name...',
                labelStyle: textFieldLabel,
                fillColor: Colors.grey[200],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              initialValue: _userDetails.name,
              onChanged: (value) {
                setState(() {
                  _newName = value;
                });
              },
              validator: (value) => value != '' ? null : 'Field cannot be empty',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: TextFormField(
              keyboardType: TextInputType.phone,
              style: textFieldContent,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Phone Number...',
                labelStyle: textFieldLabel,
                fillColor: Colors.grey[200],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              initialValue: _userDetails.phoneNumber,
              onChanged: (value) {
                setState(() {
                  _newPhoneNumber = value;
                });
              },
              validator: (value) => verifyPhoneNumber(value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: TextFormField(
              keyboardType: TextInputType.streetAddress,
              style: textFieldContent,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Address...',
                labelStyle: textFieldLabel,
                fillColor: Colors.grey[200],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              initialValue: _userDetails.residenceAddress,
              onChanged: (value) {
                setState(() {
                  _newResidence = value;
                });
              },
              validator: (value) => value != '' ? null : 'Field cannot be empty',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            child: TextFormField(
              keyboardType: TextInputType.number,
              style: textFieldContent,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelText: 'Age...',
                labelStyle: textFieldLabel,
                fillColor: Colors.grey[200],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              initialValue: _userDetails.age,
              onChanged: (value) {
                setState(() {
                  _newAge = value;
                });
              },
              validator: (value) => value != '' ? null : 'Field cannot be empty',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[700],
                      blurRadius: 2.0,
                    )
                  ]
              ),
              child: ElevatedButton.icon(
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    _userDetails.name = _newName ?? _userDetails.name;
                    _userDetails.residenceAddress =
                        _newResidence ?? _userDetails.residenceAddress;
                    _userDetails.age = _newAge ?? _userDetails.age;
                    _userDetails.phoneNumber =
                        _newPhoneNumber ?? _userDetails.phoneNumber;
                    await DatabaseServices(userDetails: _userDetails)
                        .updateUserDetails();
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.save),
                label: Text(
                  'Save Details?', style: moveAhead,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Update Details!',
        style: registerText,
      ),
    );
  }
}