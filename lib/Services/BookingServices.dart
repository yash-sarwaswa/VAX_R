import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vaccination_registration/DataModels/UserDataModel.dart';
import 'DatabaseServices.dart';

class BookingServices {
  DateTime _pickedDate;
  TimeOfDay _pickedTime;
  Timestamp _bookedSlot;
  final UserDataModel userDetails;
  final BuildContext context;
  BookingServices({this.userDetails, this.context});

  _pickADate() async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if(date != null) {
      _pickedDate = date;
    }
  }

  _pickATime() async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Select a time between 10 AM and 6 PM',
    );
    if(time != null) {
      _pickedTime = time;
    }
  }

  bookASlot() async {
    await _pickADate();
    if(_pickedDate == null)
      return null;
    await _pickATime();
    if(_pickedTime == null)
      return null;
    if(_pickedTime.hour < 10 || _pickedTime.hour > 18)
      return null;
    DateTime merged = DateTime(
      _pickedDate.year,
      _pickedDate.month,
      _pickedDate.day,
      _pickedTime.hour,
      _pickedTime.minute,
    );
    _bookedSlot = Timestamp.fromDate(merged);
    Timestamp booked = await DatabaseServices(userDetails: userDetails).bookASlot(_bookedSlot);
    return booked;
  }

  deleteASlot() async {
    try {
      String key = userDetails.bookingDate.toString();
      await DatabaseServices(userDetails: userDetails).deleteASlot(key);
      return null;
    }
    catch(e) {
      print(e.toString());
    }
  }
}