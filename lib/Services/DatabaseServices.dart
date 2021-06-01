import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaccination_registration/Services/AuthenticationServices.dart';
import '../DataModels/UserDataModel.dart';

class DatabaseServices {

  final UserDataModel userDetails;
  DatabaseServices({this.userDetails});

  final CollectionReference _vaccineRegistrations = FirebaseFirestore.instance.collection('vaccine_registrations');
  final CollectionReference _userIdToScholarId = FirebaseFirestore.instance.collection('userIdToScholarId');
  final CollectionReference _bookings = FirebaseFirestore.instance.collection('bookings');
  final AuthenticationServices _authServices = AuthenticationServices();

  Future createUserInFirestore() async {
  try{
    await _userIdToScholarId.doc(_authServices.getCurrentUser()).set({
      'scholarId' : userDetails.scholarId,
    });
    await createDatabaseUser();
  }
  catch(e) {
    print(e.toString());
    }
  }

  Future createDatabaseUser() async {
    try {
      return await _vaccineRegistrations.doc(userDetails.scholarId).set(
          {
            'email' : userDetails.email,
            'name' : userDetails.name,
            'phoneNumber' : userDetails.phoneNumber,
            'residence' : userDetails.residenceAddress,
            'bloodGroup' : userDetails.bloodGroup,
            'age' : userDetails.age,
            'bookingDate' : null,
          }
      );
    }
    catch(e) {
      print(e.toString());
    }
  }

  Future updateUserDetails() async {
    try {
      return await _vaccineRegistrations.doc(userDetails.scholarId).update(
          {
            'name' : userDetails.name,
            'phoneNumber' : userDetails.phoneNumber,
            'residence' : userDetails.residenceAddress,
            'age' : userDetails.age,
          }
      );
    }
    catch(e) {
      print(e.toString());
    }
  }

  Future getEmailFromScholarId(String scholarId) async {
    try {
      String email = '';
      DocumentSnapshot details = await _vaccineRegistrations.doc(scholarId).get();
      email = details.get('email').toString();
      return email;
    }
    catch(e) {
      print('getEmailFromId => $e');
    }
  }

  Future getStudentUserFromFirebaseUser(String firebaseUser) async {
    try {
      UserDataModel _userData = UserDataModel();
      String scholarId = await _getStudentUser(firebaseUser);
      // print(scholarId); <- Debugging Line
      DocumentSnapshot data = await _vaccineRegistrations.doc(scholarId).get();
      // print(data);  <- Debugging Line
       _userData.scholarId = scholarId;
       _userData.name = data['name'].toString();
       _userData.bloodGroup = data['bloodGroup'].toString();
       _userData.residenceAddress = data['residence'].toString();
       _userData.phoneNumber = data['phoneNumber'].toString();
       _userData.age = data['age'].toString();
       _userData.bookingDate = data['bookingDate'];
      return _userData;
    }
    catch(e) {
      print('getStudentUserFromFirebaseUser => $e');
    }
  }

  Future _getStudentUser(String firebaseUser) async{
    try {
      String studentUserId = '';
      DocumentSnapshot mapping = await _userIdToScholarId.doc(firebaseUser).get();
      studentUserId = mapping['scholarId'].toString();
      return studentUserId;
    }
    catch(e) {
      print('_getStudentUser => $e');
    }
  }

  UserDataModel _dataFromSnapshot(DocumentSnapshot snapshot) {
    Map dataMap = snapshot.data();
    return (dataMap != null) ? UserDataModel(
      scholarId: userDetails.scholarId,
      age: dataMap['age'].toString(),
      bloodGroup: dataMap['bloodGroup'].toString(),
      email: dataMap['email'].toString(),
      name: dataMap['name'].toString(),
      phoneNumber: dataMap['phoneNumber'].toString(),
      residenceAddress: dataMap['residence'].toString(),
      bookingDate: dataMap['bookingDate']
    ) : null;
  }

  Stream<UserDataModel> get userDataDocument {
    return _vaccineRegistrations.doc(userDetails.scholarId).snapshots()
        .map(_dataFromSnapshot);
  }

  Future bookASlot(Timestamp timestamp) async {
    String key = timestamp.toString();
    var docRef = _bookings.doc(key).get().then((snapshot) async {
      if(snapshot.exists)
        return null;
      try {
        await _bookings.doc(key).set({
          'scholarId' : userDetails.scholarId
        });
        await _vaccineRegistrations.doc(userDetails.scholarId).update({
          'bookingDate' : timestamp
        });
        return timestamp;
      }
      catch(e) {
        print(e.toString());
      }
    }).catchError((error) => null);
    return docRef;
  }

  Future deleteASlot(String key) async {
    try {
      await _bookings.doc(key).delete();
      await _vaccineRegistrations.doc(userDetails.scholarId).update({'bookingDate' : null});
    }
    catch(e) {
      print(e.toString());
    }
  }

}