import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const TextStyle mainHeading1 = TextStyle(
  fontSize: 35,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontFamily: 'MerriweatherBold',
);

const TextStyle mainHeading2 = TextStyle(
  fontSize: 45,
  fontWeight: FontWeight.bold,
  color: Colors.indigo,
  fontFamily: 'Cambria',
);
const TextStyle registerHeading1 = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontFamily: 'MerriweatherBold',
);
const TextStyle registerHeading2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  fontFamily: 'Cambria',
);

const TextStyle loginButton = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

TextStyle registerText = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  fontFamily: 'MerriweatherBold',
  foreground: Paint()
    ..shader = LinearGradient(
      colors: [Colors.red[700], Colors.indigo[900]]
    ).createShader(Rect.fromLTWH(0, 0, 500, 30)),
);

const TextStyle moveAhead = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const TextStyle fillDetails = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  fontFamily: 'Calibri'
);

TextStyle fightText = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.italic,
  foreground: Paint()
    ..shader = LinearGradient(
        colors: [Colors.deepOrange, Colors.grey[200], Colors.green]
    ).createShader(Rect.fromLTWH(0, 0, 420, 30)),
);

const TextStyle dashboardName = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  fontFamily: 'MerriweatherBold',
);

const TextStyle buttonName = TextStyle(
  fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Cambria',
);

const TextStyle textFieldLabel = TextStyle(
  fontSize: 25, fontWeight : FontWeight.normal, color: Colors.black,
);

const TextStyle textFieldContent = TextStyle(
  fontSize: 24, fontWeight: FontWeight.normal, color: Colors.black,
);