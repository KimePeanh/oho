import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:onecam/src/features/History/historyScreen.dart';
import 'package:onecam/src/utils/app_con.dart';

class MyPFScreen extends StatefulWidget {
  const MyPFScreen({Key? key}) : super(key: key);

  @override
  _MyPFScreenState createState() => _MyPFScreenState();
}

Map<String, dynamic> mySOSClick = {};
Map<String, dynamic> noti = {};
Map<String, dynamic> lastSOS = {};
Map<String, dynamic> upSOS = {};

class _MyPFScreenState extends State<MyPFScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final database = FirebaseDatabase.instance.ref();
  var _firebaseInstance = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User user = FirebaseAuth.instance.currentUser!;
  String timeformate = DateFormat.jm().format(DateTime.now());
  CameraPosition? _kGooglePlex;
  String myUid = "";
  String myID = "";
  int getSOSCount = 0;
  var HelpME = [];
  var notiId = [];
  var notiurl = [];
  var getmySOSList = [];
  var testlist = [];
  var getFriList = [];
  int helpCount = 0;
  var notiList = [];
  String ButtonText = "My Location";
  List<Marker> _markers = [];
  late Timer _timer;
  int _start = 10;

  void startTimer() async {
    const oneSec = const Duration(seconds: 5);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          ok();
        },
      ),
    );
  }

  void ok() async {
    String formattedDate = DateFormat.yMd().format(DateTime.now());
    String timeformate = DateFormat.jm().format(DateTime.now());
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    upSOS.addAll({
      'lat': position.latitude,
      'lng': position.longitude,
      'date': formattedDate,
      'time': timeformate,
      'uid': user.uid,
      'status': lastSOS['status']
    });
    getmySOSList.remove(lastSOS);
    getmySOSList.add(upSOS);
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(user.uid)
        .update({'SOS': getmySOSList});
    up();
  }

  void updateSOSList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(user.uid)
        .update({'SOS': getmySOSList});
  }

  void updateSOSCount() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(user.uid)
        .update({'SOSCount': getSOSCount + 1});
  }

  void addmarker() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _markers.add(Marker(
        markerId: MarkerId(myID),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(
            //title: 'The title of the marker'
            )));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  getCurrentUser() async {
    final User user = await _auth.currentUser!;
    final uid = user.uid;
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      print(querySnapshot.docs.length);
      querySnapshot.docs.forEach((doc) {
        if (doc["uid"] == uid) {
          print(doc['uid']);
          setState(() {
            myUid = doc["uid"];
            myID = doc['id'];
            getmySOSList = doc['SOS'];
            //getSOSCount = doc['SOSCount'];
            getFriList = doc['fri'];
            lastSOS = getmySOSList[getmySOSList.length - 1];
            print(getFriList);
            print("JJJJJJJJJJJJJJJJJJJJJJJJJJJ");
            // mySOSClick = doc['Helpclick'];
          });
        }
      });
    });
  }

  up() async {
    final User user = await _auth.currentUser!;
    final uid = user.uid;
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["uid"] == uid) {
          setState(() {
            getmySOSList = doc['SOS'];
            lastSOS = getmySOSList[getmySOSList.length - 1];
            print("JJJJJJJJJJJJJJJJJJJJJJJJJJJ");
          });
        }
      });
    });
  }

  void hi() async {
    String formattedDate = DateFormat.yMd().format(DateTime.now());
    String timeformate = DateFormat.jm().format(DateTime.now());
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final User user = await _auth.currentUser!;
    final uid = user.uid;
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["uid"] == uid) {
          setState(() {
            getFriList = doc['fri'];
            print(getFriList);
            print("JJJJJJJJJJJJJJJJJJJJJJJJJJJ");
            // mySOSClick = doc['Helpclick'];
            int increase = 0;
            FirebaseFirestore.instance
                .collection("AllUsers")
                .get()
                .then((QuerySnapshot querySnapshot) {
              querySnapshot.docs.forEach((doc) {
                for (int i = 0; i < getFriList.length; i++) {
                  if (getFriList[i] == doc['id']) {
                    print(doc['uid']);
                    setState(() {
                      mySOSClick.addAll({
                        'lat': position.latitude,
                        'lng': position.longitude,
                        'date': formattedDate,
                        'time': timeformate,
                        'uid': user.uid,
                        'status': '0'
                      });
                      // print(doc['uid']);
                      notiList = doc['noti'];
                      notiList.add(mySOSClick);
                      FirebaseFirestore.instance
                          .collection("AllUsers")
                          .doc(doc['uid'])
                          .update({'noti': notiList});
                    });
                  }
                }
              });
            });
          });
        }
      });
    });
  }

  Future<void> _goToTheLake() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _kGooglePlex = CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 15);
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex!));
    //controller.getLatLng();
  }

  void updateHelpClickCount() async {
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        for (int i = 0; i < getFriList.length; i++) {
          if (getFriList[i] == doc['id']) {
            setState(() {
              notiList = doc['noti'];
            });
          }
        }
        for (int j = 0; j < notiList.length; j++) {
          if (notiList[j] == user.uid) {
            setState(() {
              helpCount = notiList[j];
              print(notiList[j]);
            });
          }
        }
      });
    });
  }

  void changeButtonText() async {
    String formattedDate = DateFormat.yMd().format(DateTime.now());
    String timeformate = DateFormat.jm().format(DateTime.now());
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (ButtonText == "My Location") {
      setState(() {
        ButtonText = "Help";
      });
    } else if (ButtonText == "Help") {
      setState(() {
        addmarker();
        ButtonText = "Stop";
        testlist.add(position.latitude);
        testlist.add(position.longitude);
        testlist.add(formattedDate);
        testlist.add(timeformate);
        mySOSClick.addAll({
          'lat': position.latitude,
          'lng': position.longitude,
          'date': formattedDate,
          'time': timeformate,
          'uid': user.uid,
          'status': '0'
        });
        print(mySOSClick);
        getmySOSList.add(mySOSClick);
        print(getmySOSList);
        HelpClick();
        hi();
        startTimer();
        //checkSOSlist();
        //checkSOSlist();
        // const oneSec = const Duration(seconds: 5);
        // _timer = new Timer.periodic(
        //   oneSec,
        //   (Timer timer) => setState(
        //     () {
        //       // up();
        //       // upSOS.addAll({
        //       //   'lat': position.latitude,
        //       //   'lng': position.longitude,
        //       //   'date': formattedDate,
        //       //   'time': timeformate,
        //       //   'status': lastSOS['status']
        //       // });
        //       // getmySOSList.remove(getmySOSList[getmySOSList.length - 1]);
        //       // getmySOSList.add(upSOS);
        //       // FirebaseFirestore.instance
        //       //     .collection("AllUsers")
        //       //     .doc(user.uid)
        //       //     .update({'SOS': getmySOSList});
        //       // lastSOS.addAll({
        //       //   'lat': position.latitude,
        //       //   'lng': position.longitude,
        //       //   'date': formattedDate,
        //       //   'time': timeformate,
        //       //   'status': lastSOS['status']
        //       // });
        //       // print(lastSOS);
        //       // print(getmySOSList[getmySOSList.length - 1]);
        //       // print("objectfffffffffffffffffffffffffff");
        //       // FirebaseFirestore.instance
        //       //     .collection("AllUsers")
        //       //     .doc(user.uid)
        //       //     .update({
        //       //   'SOS': FieldValue.arrayRemove(
        //       //       [getmySOSList[getmySOSList.length - 1]])
        //       // });
        //       // print(getmySOSList);
        //       // //getmySOSList.clear();
        //       // up();
        //       // print(getmySOSList);
        //       // getmySOSList.add(lastSOS);
        //       // print(getmySOSList);
        //       // HelpClick();
        //       // mySOSClick.clear();
        //       // mySOSClick.addAll({
        //       //   'lat': position.latitude,
        //       //   'lng': position.longitude,
        //       //   'date': formattedDate,
        //       //   'time': timeformate,
        //       //   'status': getmySOSList[getFriList.length - 1]['status']
        //       // });
        //       // getmySOSList.remove(getmySOSList[getFriList.length - 1]);
        //       // getmySOSList.add(mySOSClick);
        //       // HelpClick();
        //       print("Hi");
        //     },
        //   ),
        // );
      });
    } else {
      setState(() {
        mySOSClick.clear();
        print(mySOSClick);
        //getmySOSList.clear();
        ButtonText = "My Location";
      });
    }
  }

  // void checkSOSlist() async {
  //   if (getmySOSList.length >= 10) {
  //     QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
  //     FirebaseFirestore.instance.collection("AllUsers").doc(user.uid).update({
  //       'SOS': FieldValue.arrayRemove([getmySOSList[0]])
  //     });
  //     getCurrentUser();
  //     HelpClick();
  //   } else {
  //     HelpClick();
  //   }
  // }

  void HelpClick() async {
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(user.uid)
        .update({'SOS': getmySOSList});
  }

  getle() {
    final SOS = database.child('/${user.uid}');
    database.child(user.uid).child("Count").once().then((DataSnapshot) {
      int a;
      a = DataSnapshot.snapshot.value as int;
      int b = a + 1;
      database.child('/${user.uid}').child('${b}').set(testlist);
      database.child('/${user.uid}').child("Count").set(b);
      print(b);
    });
  }

  void SOSList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(myUid)
        .update({'SOS': HelpME});
  }

  @override
  void initState() {
    print(getFriList);
    getCurrentUser();
    updateHelpClickCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("AllUsers")
            .where('uid', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: snapshot.data!.docs.map((doc) {
                return Column(
                  children: [
                    SafeArea(
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                          color: mainColorRed,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 60,
                            alignment: Alignment.center,
                            child: Text(
                              "Tracking User Info",
                              style: TextStyle(
                                  color: white, fontWeight: bold, fontSize: 19),
                            ),
                          ),
                          //Expanded(child: Container()),
                          Container(
                            width: 30,
                          ),
                        ],
                      ),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10)),
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(doc['url']))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      doc['Username'],
                      style: TextStyle(
                          fontSize: 22,
                          color: mainColorRed,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        height: 35,
                        color: mainColorRed,
                        child: Text(
                          "History",
                          style: TextStyle(color: white, fontSize: 18),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HistoryScreen()));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 30,
                      height: 280,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: mainColorRed)),
                      child: GoogleMap(
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(11.562108, 104.888535),
                          zoom: 6.0,
                        ),
                        markers: Set<Marker>.of(_markers),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: mainColorRed,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(ButtonText,
                            style: TextStyle(
                              fontSize: 18,
                              color: white,
                            )),
                      ),
                      onTap: () {
                        _goToTheLake();
                        changeButtonText();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // InkWell(
                    //   child: Text(
                    //     "HIIIIIIIIIIIIIIIIIII",
                    //     style: TextStyle(fontSize: 20),
                    //   ),
                    //   onTap: () {
                    //     hi();
                    //   },
                    // )
                  ],
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
