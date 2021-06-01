import 'package:cloud_firestore/cloud_firestore.dart';
class UserDataModel {
  String email;
  String scholarId;
  String name;
  String age;
  String phoneNumber;
  String residenceAddress;
  String bloodGroup;
  Timestamp bookingDate;
  UserDataModel({this.email, this.scholarId, this.name, this.age, this.phoneNumber, this.residenceAddress, this.bloodGroup, this.bookingDate});
}
