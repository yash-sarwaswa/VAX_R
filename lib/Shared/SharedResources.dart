import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void toastMessage(String text, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

dynamic verifyScholarId(String value) {
  if(value == '')
    return 'Field cannot be empty...';
  String pattern = r'^[0-9]{7,7}$';
  String onError = 'Enter a valid scholar id...';
  RegExp regExp = new RegExp(pattern);
  if(regExp.hasMatch(value)) return null;
  else return onError;
}

dynamic verifyPhoneNumber(String value) {
  if(value == '')
    return 'Field cannot be empty...';
  String pattern = r'[0-9]{10,10}$';
  String onError = 'Enter a valid phone number...';
  RegExp regExp = new RegExp(pattern);
  if(regExp.hasMatch(value)) return null;
  else return onError;
}

dynamic verifyBloodGroup(String value) {
  if(value == '')
    return 'Field cannot be empty...';
  String onError = 'Enter a valid blood group...';
  switch(value) {
    case 'A+':
    case 'A-':
    case 'B+':
    case 'B-':
    case 'O+':
    case 'O-':
    case 'AB+':
    case 'AB-': return null;
  }
  return onError;
}
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.black,
          size: 60,
        ),
      ),
    );
  }
}

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset("assets/images/nitsilchar_logo.png",
        height: 120.0,
        width: 110.0,
      ),
    );
  }
}

class FillerImage extends StatelessWidget {
  const FillerImage({
    Key key,
    @required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: size.height * 0.3,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black87, BlendMode.softLight),
            )
        ),
      ),
    );
  }
}

