import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future uploadProfileImage(String userIdentifier, File image) async {
    String url;
    Reference _storageReference = _firebaseStorage.ref().child(userIdentifier);
    UploadTask uploadTask = _storageReference.putFile(image);
    TaskSnapshot taskSnapshot = (await uploadTask);
    url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  Future getImageLink(String userIdentifier) async {
    String url;
    try {
      Reference _storageReference = _firebaseStorage.ref().child(userIdentifier);
      url = await _storageReference.getDownloadURL();
    }
    catch(e) {
      print(e.toString());
    }
    return url;
  }
}