import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marquee/marquee.dart';
import 'package:vaccination_registration/Services/AuthenticationServices.dart';
import 'package:vaccination_registration/Services/BookingServices.dart';
import 'package:vaccination_registration/Services/DatabaseServices.dart';
import 'package:vaccination_registration/Services/StorageServices.dart';
import 'package:vaccination_registration/DataModels/UserDataModel.dart';
import '../Shared/SharedResources.dart';
import '../Shared/palette.dart';

final AuthenticationServices _authServices = AuthenticationServices();
final DatabaseServices _databaseServices = DatabaseServices();
final StorageServices _storageServices = StorageServices();
UserDataModel _userDetails;
String _imageUrl;

Future _getInitData() async {
  _userDetails = UserDataModel();
  String firebaseUser = _authServices.getCurrentUser();
  if(firebaseUser != null) {
    _userDetails = await _databaseServices.getStudentUserFromFirebaseUser(firebaseUser);
    //print('In-init $_userDetails'); <- Debugging Line
    _imageUrl = await _storageServices.getImageLink(_userDetails.scholarId);
    //print(_imageUrl); <- Debugging Line
  }
}

class UserDashboard extends StatefulWidget {
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) => FutureBuilder(
    future: _getInitData(),
    builder: (context, snapshot) {
      if(!snapshot.hasData) {
        return _Dashboard();
      }
      else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}

class _WelcomeText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Welcome!',
        style: registerText,
      ),
    );
  }
}

class _DisplayData extends StatefulWidget {
  const _DisplayData({Key key}) : super(key: key);
  @override
  __DisplayDataState createState() => __DisplayDataState();
}

class __DisplayDataState extends State<_DisplayData> {
  String _userName = 'LOADING...';
  String _userId = 'LOADING...';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<UserDataModel>(
        stream: DatabaseServices(userDetails: _userDetails).userDataDocument,
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
            _userDetails = snapshot.data;
            _userName = _userDetails.name;
            _userId = _userDetails.scholarId;
            return NameAndId(userName: _userName, userId: _userId);
          }
          else {
            return NameAndId(userName: _userName, userId: _userId);
          }
        },
      ),
    );
  }
}

class NameAndId extends StatelessWidget {
  const NameAndId({
    Key key,
    @required String userName,
    @required String userId,
  }) : _userName = userName, _userId = userId, super(key: key);

  final String _userName;
  final String _userId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 0, 5),
              child: Text(_userName, style: dashboardName),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 2, 0, 5),
              child: Text(_userId, style: dashboardName),
            ),
          ],
        ),
      ],
    );
  }
}

class _Dashboard extends StatefulWidget {
  @override
  __DashboardState createState() => __DashboardState();
}

class __DashboardState extends State<_Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FillerImage(imagePath: 'assets/images/dashboard_img.jpg'),
              _WelcomeText(),
              ProfilePictureAndButtons(),
              _DisplayData(),
              BookingDetails(),
            ],
          ),
        ),
      ),
    );
  }

}

class ProfilePictureAndButtons extends StatelessWidget {
  const ProfilePictureAndButtons({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ProfilePicture(),
          UserButtons(context: context),
        ],
      ),
    );
  }
}

class UserButtons extends StatelessWidget {
  const UserButtons({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SignOutButton(),
            SettingsButton(context: context),
          ],
        ),
      ],
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: Column(
          children: [
            RawMaterialButton(
              onPressed: () async {
                await _authServices.signOut();
              },
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
              fillColor: Colors.grey[200],
              elevation: 4.0,
              child: Icon(Icons.logout, size: 35),
            ),
            SizedBox(height: 10),
            Text('Sign Out!', style: buttonName),
          ],
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        child: Column(
          children: [
            RawMaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, 'SettingsPage', arguments: {'userData' : _userDetails});
              },
              shape: CircleBorder(),
              padding: EdgeInsets.all(10),
              fillColor: Colors.grey[200],
              elevation: 4.0,
              child: Icon(Icons.settings, size: 35),
            ),
            SizedBox(height: 10),
            Text('Settings', style: buttonName)
          ],
        ),
      ),
    );
  }
}

class _ProfilePicture extends StatefulWidget {
  @override
  __ProfilePictureState createState() => __ProfilePictureState();
}

class __ProfilePictureState extends State<_ProfilePicture> {
  File _profileImage;

  Future _getImageFromGallery() async {
    var image = await ImagePicker().getImage(source : ImageSource.gallery);
    setState(() {
      _profileImage = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              _ProfilePhoto(),
              Positioned(
                top: 60, left: 60,
                child: RawMaterialButton(
                  fillColor: Colors.blue,
                  child: Icon(
                      Icons.update_outlined, size: 25),
                  shape: CircleBorder(),
                  onPressed: () async {
                    await _getImageFromGallery();
                    _imageUrl = await _storageServices.uploadProfileImage(_userDetails.scholarId, _profileImage);
                    //This rebuilds the widget and all its stateful children that have changed
                    setState(() {});
                  },
                ),
              ),
            ]
          ),
        ),
      ],
    );
  }
}

class _ProfilePhoto extends StatefulWidget {
  @override
  __ProfilePhotoState createState() => __ProfilePhotoState();
}

class __ProfilePhotoState extends State<_ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return (_imageUrl != null) ?
    CircleAvatar(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
          image: DecorationImage(
            image: NetworkImage(_imageUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(60),
        ),
      ),
      radius: 60,
    )
        :
    CircleAvatar(
      child: Icon(Icons.person, size: 60),
      backgroundColor: Colors.grey[400],
      foregroundColor: Colors.white,
      radius: 60,
    )
    ;
  }
}

class BookingDetails extends StatefulWidget {
  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    String _statusString = (_userDetails.bookingDate != null) ? 'You have a slot booked for ${_formatDate(_userDetails.bookingDate.toDate())}!' : 'You do not have a booked slot!' ;
    return (_userDetails.bookingDate == null) ? Column(
      children: [
        StatusStringLabel(statusString: _statusString),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          //child is a gesture detector based on status of booking
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(3.0, 3.0),
                ),
              ],
            ),
            child: GestureDetector(
              child: Text(
                'Book a vaccination slot?',
                style: loginButton.copyWith(fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              onTap: () async {
                Timestamp _booking = await BookingServices(userDetails: _userDetails, context: context).bookASlot();
                if(_booking != null) {
                  _userDetails.bookingDate = _booking;
                  setState(() {
                    _statusString = 'You have a slot booked for ${_formatDate(_booking.toDate())}!';
                  });
                }
                else {
                  toastMessage('Unable to book this slot or booking cancelled. Try again later or try a different slot', context);
                }
              },
            ),
          ),
        ),
      ],
    ) : Column(
      children: [
        StatusStringLabel(statusString: _statusString),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          //child is a gesture detector based on status of booking
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  offset: Offset(3.0, 3.0),
                ),
              ],
            ),
            child: GestureDetector(
              child: Text(
                'Cancel your booked slot?',
                style: loginButton.copyWith(fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              onTap: () async {
                if(await BookingServices(userDetails: _userDetails).deleteASlot() == null) {
                  _userDetails.bookingDate = null;
                  setState(() {
                    _statusString = 'You do not have a booked slot!';
                  });
                }
                else {
                  toastMessage('Unable to cancel this booking. Try again later', context);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

String _formatDate(DateTime date) {
  String dateString = date.toString();
  return dateString.substring(0, dateString.length - 7);
}

class StatusStringLabel extends StatefulWidget {
  const StatusStringLabel({
    Key key,
    @required String statusString,
  }) : _statusString = statusString, super(key: key);

  final String _statusString;

  @override
  _StatusStringLabelState createState() => _StatusStringLabelState();
}

class _StatusStringLabelState extends State<StatusStringLabel> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Container(
        height: 50,
        width: size.width * 0.9,
        child: Marquee(
          text: ' ${widget._statusString} ',
          style: TextStyle(color: Colors.red, fontSize: 40),
        ),
      ),
    );
  }
}
