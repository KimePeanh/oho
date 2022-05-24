import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:onecam/src/features/frienf_pf/FriendScreen.dart';
import 'package:onecam/src/features/home/widget.dart';

import 'notification.dart';


class ButtonHome extends StatefulWidget {
  const ButtonHome({Key? key}) : super(key: key);

  @override
  _ButtonHomeState createState() => _ButtonHomeState();
}

class _ButtonHomeState extends State<ButtonHome> {
  var SOSs = [1, 2, 3];
  var Help = [];
  var newSOS = [];
  String? id;
  String? name;
  String? uidd;
  String? url;
  Map<String, dynamic> AllSOS = {};
  Map<String, dynamic> AllHelp = {};
  var _firebaseInstance = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String btnname = "";

  void getPoliceList() async {
    newSOS.clear();
    FirebaseFirestore.instance
        .collection("Polices")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc['Username'] == "Dit Way") {
          setState(() {
            newSOS = doc['SOS'];
            print(newSOS);
          });
        }
        SOS();
      });
    });
  }

  void getmyId() async {
    final User user = await _auth.currentUser!;
    final uid = user.uid;
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc['uid'] == uid) {
          setState(() {
            id = doc['id'];
            name = doc['Username'];
            uidd = doc['uid'];
            url = doc['url'];
          });
        }
      });
    });
  }

  void getDoctorList() async {
    newSOS.clear();
    FirebaseFirestore.instance
        .collection("Doctors")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc['Username'] == "Heng Tevy") {
          setState(() {
            newSOS = doc['SOS'];
            print(newSOS);
          });
        }
        SOS();
      });
    });
  }

  void SOS() async {
    final User user = await _auth.currentUser!;
    final uid = user.uid;
    String formattedDate = DateFormat.yMd().format(DateTime.now());
    String timeformate = DateFormat.jm().format(DateTime.now());
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (btnname == "Police") {
      setState(() {
        AllSOS.addAll({
          'lat': position.latitude,
          'lng': position.longitude,
          'date': formattedDate,
          'time': timeformate,
          'uid': uid
        });
        newSOS.add(AllSOS);
        print(newSOS);
        FirebaseFirestore.instance
            .collection("Polices")
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.update({'SOS': newSOS});
          });
        });
      });
    }
    if (btnname == "Doctor") {
      AllSOS.clear();
      setState(() {
        AllSOS.addAll({
          'lat': position.latitude,
          'lng': position.longitude,
          'date': formattedDate,
          'time': timeformate,
          'uid': uid
        });
        newSOS.add(AllSOS);
        print(newSOS);
        FirebaseFirestore.instance
            .collection("Doctors")
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            doc.reference.update({'SOS': newSOS});
          });
        });
      });
    }
  }

  void listennotification() {
    NotificationApi.onNotification.stream.listen((event) {
      onClickNoti();
    });
  }

  void onClickNoti() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                FriendProfileScreen("", id!, name!, uidd!, url!)));
  }

  @override
  void initState() {
    getmyId();
    NotificationApi.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child:
                        btn(context, "assets/images/home/police.png", "POLICE"),
                    onTap: () {
                      setState(() {
                        btnname = "Police";
                        getPoliceList();
                        NotificationApi.showNoti(
                          title: "One CamEmergency",
                          body: "Hey! Help ${name}"
                        );
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: InkWell(
                  child: btn(context, "assets/images/home/ff.png", "FIREMAN"),
                  onTap: () {},
                )),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.15,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: InkWell(
                  child: btn(
                      context, "assets/images/home/hospital.png", "HOSPITAL"),
                  onTap: () {
                    btnname = "Doctor";
                    getPoliceList();
                  },
                )),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: InkWell(
                  child: btn(context, "assets/images/home/fri.png", "FIRENDS"),
                  onTap: () {},
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
