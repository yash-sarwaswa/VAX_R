import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccination_registration/Services/DatabaseServices.dart';
import 'package:vaccination_registration/DataModels/UserDataModel.dart';
import 'package:vaccination_registration/DataModels/UserModel.dart';

class AuthenticationServices {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //model FirebaseUser to StudentUser
  StudentUser _studentUserFromFirebaseUser(User user) => (user != null) ? StudentUser(userId: user.uid) : null;

  Stream<StudentUser> get studentUser {
    return _firebaseAuth.authStateChanges().map(_studentUserFromFirebaseUser);
  }
  String getCurrentUser() {
    StudentUser _studentUser = _studentUserFromFirebaseUser(_firebaseAuth.currentUser);
    return (_studentUser != null) ? _studentUser.userId : null;
  }
  //sign-in using scholar_id and password
  Future signInUser(String scholarId, String password) async {
    try {
      String email = await DatabaseServices().getEmailFromScholarId(scholarId);
      UserCredential authResult = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return _studentUserFromFirebaseUser(authResult.user);
    }
    catch(e) {
      print(e.toString());
    }
  }
  //sign-up
  Future signUpUser(UserDataModel userDetails, String password) async {
    try {
      UserCredential authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: userDetails.email, password: password);
      if(authResult != null) {
        await DatabaseServices(userDetails: userDetails).createUserInFirestore();
      }
      return _studentUserFromFirebaseUser(authResult.user);
    }
    catch(e) {
      print(e.toString());
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }
}