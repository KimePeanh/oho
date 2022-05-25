import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import 'package:onecam/src/features/login_register/method.dart';
import 'package:onecam/src/features/navigator/navigator.dart';
import 'package:onecam/src/shared/shared_widget.dart';
import 'package:onecam/src/utils/app_con.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPScreen extends StatefulWidget {
  //const OTPScreen({Key? key}) : super(key: key);
  final state;
  final verID;
  final fname;
  final lname;
  final phone;
  final pw;
  final sex;
  final dob;
  OTPScreen(this.state, this.verID, this.fname, this.lname, this.phone, this.pw,
      this.sex, this.dob);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Method method = Method("login");
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  var fri = [];
  var reFri = [];
  var addfri = [];
  var HelpList = [];
  var Myhelp = [];
  var noti = [];
  var allID = [];
  List<String> SOS = [];
  var _firebaseInstance = FirebaseFirestore.instance;
  String id = "";
  void getid() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    // int n = qn.docs.length + 1;
    // id = n.toString();
    // print(id);
  }

  void checkId() async {
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        allID.add(doc['id']);
      });
    });
    setState(() {
      id = allID.reduce((curr, next) => curr > next ? curr : next) + 1;
      print(id);
    });
  }

  @override
  void initState() {
    getid();
    print(widget.state);
    print(widget.verID);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SafeArea(
                child: Container(
              width: 150,
              height: 150,
              padding: EdgeInsets.only(top: 20),
              child: Image(
                image: AssetImage("assets/images/logo.png"),
              ),
            )),
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width - 20,
              child: Text(
                "Please confirm your Phone Verification",
                style: TextStyle(color: Blue, fontWeight: bold, fontSize: 16),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width - 20,
              child: Text(
                "Enter your OTP code here",
                style: TextStyle(
                  color: Blue,
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Flexible(
              child: OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width - 40,
                fieldWidth: 50,
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onChanged: (pin) {},
                onCompleted: (pin) async {
                  print("Completed: " + pin);
                  //method.loging(context, OTP: pin, verID: widget.verID);
                  if (widget.state == "login") {
                    method.loging(context, OTP: pin, verID: widget.verID);
                  } else if (widget.state == "signup") {
                    createaccount(context, OTP: pin);
                  }
                },
              ),
            ),
            // SizedBox(
            //   height: 50,
            // ),
            Spacer(
              flex: 1,
            ),
            InkWell(
              child: logButton(context, "Verify Now"),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BottomNav()));
              },
            )
          ],
        ),
      ),
    );
  }

  void createaccount(BuildContext context, {required String OTP}) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verID,
        smsCode: OTP,
      );
      final User user = (await _auth.signInWithCredential(credential)).user!;
      if (user.uid.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('AllUsers')
            .doc(user.uid)
            .set({
              'id': id,
              'Username': widget.fname + " " + widget.lname,
              'Phonenumber': '+855' + widget.phone,
              'password': widget.pw,
              'date_bd': widget.dob,
              'sex': widget.sex,
              'email': "",
              'fri': fri,
              'addfri': addfri,
              'reFri': reFri,
              'uid': user.uid,
              'SOS': SOS,
              'lastStatus': '1',
              'HelpList': HelpList,
              'MyHelp': Myhelp,
              'noti': noti,
              'keyword': [
                widget.fname,
                widget.lname,
                widget.fname + " " + widget.lname,
              ],
              'url':
                  'https://firebasestorage.googleapis.com/v0/b/newonecam-53e7c.appspot.com/o/user%20(1).png?alt=media&token=c4dafa52-3e22-4514-9482-874bd4dde42d',
            })
            .then((value) => print('SSS'))
            .catchError((e) => print(e));
        user.updateDisplayName("+855" + widget.phone);
        user.updatePhotoURL(
            'https://firebasestorage.googleapis.com/v0/b/newonecam-53e7c.appspot.com/o/user%20(1).png?alt=media&token=c4dafa52-3e22-4514-9482-874bd4dde42d');
        user.reload();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNav()));

        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => HomeScreen(widget.phonenumberr)));
      }
    } catch (e) {
      print(e);
    }
  }
}
