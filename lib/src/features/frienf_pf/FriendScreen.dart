import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onecam/src/features/History/fri_history.dart';
import 'package:onecam/src/utils/app_con.dart';

import 'not_friend.dart';


class FriendProfileScreen extends StatefulWidget {
  // const FriendProfileScreen({ Key? key }) : super(key: key);
  final String state;
  final String id;
  final String name;
  final String uid;
  final String url;
  FriendProfileScreen(this.state, this.id, this.name, this.uid, this.url);

  @override
  State<FriendProfileScreen> createState() => _FriendProfileScreenState();
}

Map<String, dynamic> lastSOSList = {};

class _FriendProfileScreenState extends State<FriendProfileScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final User user = FirebaseAuth.instance.currentUser!;
  var _firebaseInstance = FirebaseFirestore.instance;
  var fri = [];
  var myfri = [];
  var getSOS = [];
  String keuid = "";
  CameraPosition? _helplocation;
  List<Marker> _markers = [];
  bool isSOS = false;
  bool isAdd = false;
  bool isUnfriend = false;
  String getlastlat = "";
  String getlastlng = "";
  String id = "";
  String friid = "";
  String texthelp = "View Location";
  String text = "Add Friend";
  var getHelpList = [];
  var getMyHelpList = [];
  Map<String, dynamic> myhelp = {};
  Map<String, dynamic> afhelp = {};
  Map<String, dynamic> lasthelp = {};
  void getreFriList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection('AllUsers')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == user.uid) {
          setState(() {
            fri = doc["fri"];
            id = doc["id"];
            getMyHelpList = doc['MyHelp'];
          });
        }
      });
    });
  }

  void cf() async {
    if (text == "Add Friend") {}
  }

  void getSOSListDetail() {
    setState(() {
      lastSOSList = getSOS[getSOS.length - 1];
      print(lastSOSList);
    });
  }

  void ad() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(keuid)
        .update({'list': getSOS});
  }

  void MyUnfriend() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance.collection("AllUsers").doc(user.uid).update({
      'fri': FieldValue.arrayRemove([widget.id]),
    });
    FirebaseFirestore.instance.collection("AllUsers").doc(keuid).update({
      'fri': FieldValue.arrayRemove([id])
    });
  }

  void addmarker() async {
    _markers.add(Marker(
        markerId: MarkerId(widget.id),
        position:
            LatLng(lastSOSList['lat'] as double, lastSOSList['lng'] as double),
        infoWindow: InfoWindow(
            //title: 'The title of the marker'
            )));
  }

  Future<void> _goToHelp() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _helplocation = CameraPosition(
          target: LatLng(
              lastSOSList['lat'] as double, lastSOSList['lng'] as double),
          zoom: 15);
    });
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_helplocation!));
    //controller.getLatLng();
  }

  void checkSOS() async {
    if (getSOS.length != 0 && lastSOSList['status'] == "0") {
      setState(() {
        isSOS = true;
        print("HIIIIIIWRONGGGGGGGGGGGG");
      });
    } else {
      setState(() {
        print("SOSFalseeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
        isSOS = false;
      });
    }
  }

  HelpFri(BuildContext context) async {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("AllUsers")
            .where('uid', isEqualTo: widget.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {}
          return Text("No data");
        });
  }

  void HelpClick() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(keuid)
        .update({'HelpList': getHelpList});
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(keuid)
        .update({'SOS': getSOS});
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(user.uid)
        .update({'MyHelp': getMyHelpList});
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(keuid)
        .update({'lastStatus': "1"});
  }

  void changeText() {
    if (texthelp == "View Location") {
      setState(() {
        _goToHelp();
        addmarker();
        myhelp.clear();
        texthelp = "Help";
      });
    } else {
      setState(() {
        texthelp = "View Location";
        String formattedDate = DateFormat.yMd().format(DateTime.now());
        String timeformate = DateFormat.jm().format(DateTime.now());
        myhelp.addAll({
          'lat': lastSOSList['lat'],
          'lng': lastSOSList['lng'],
          'date': formattedDate,
          'time': timeformate,
          'uid': keuid
        });
        getMyHelpList.add(myhelp);
        afhelp.addAll({
          'lat': lastSOSList['lat'],
          'lng': lastSOSList['lng'],
          'date': formattedDate,
          'time': timeformate,
          'uid': user.uid
        });
        getHelpList.add(afhelp);
        lasthelp.addAll({
          'lat': lastSOSList['lat'],
          'lng': lastSOSList['lng'],
          'date': lastSOSList['date'],
          'time': lastSOSList['time'],
          'status': "1"
        });
      });
      getSOS.remove(getSOS[getSOS.length - 1]);
      getSOS.add(lasthelp);
      HelpClick();
    }
  }

  void showFri() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (widget.id == doc['id']) {
          setState(() {
            getSOS = doc['SOS'];
            myfri = doc['fri'];
            keuid = doc["uid"];
            getHelpList = doc['HelpList'];
            print(doc['SOS']);
            print(keuid);
            checkSOS();
            getSOSListDetail();
          });
        }
      });
    });
  }

  void updatelast() async {
    FirebaseFirestore.instance.collection("AllUsers").doc(keuid).update({
      'SOS': FieldValue.arrayRemove([getSOS[getSOS.length - 1]])
    });
  }

  @override
  void initState() {
    getreFriList();
    print("Friend");
    print(keuid);
    showFri();
    //checkSOS();
    print("SOSSSSSSSSSSSSSSSSSSSSSSS");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.uid);
    print("Okkkkkkkkkkkkkkkkkkkkkkmakkkkkkkkkkg");
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: mainColorRed,
    //     toolbarHeight: 70,
    //     elevation: 0,
    //     leading: IconButton(
    //       icon: Icon(
    //         Icons.arrow_back,
    //         color: white,
    //         size: 25,
    //       ),
    //       onPressed: () {
    //         Navigator.pop(context);
    //       },
    //     ),
    //     title: Text(widget.name),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.vertical(
    //         bottom: Radius.circular(10),
    //       ),
    //     ),
    //   ),
    //   body: SingleChildScrollView(
    //     child: Center(
    //       child: Column(
    //         children: <Widget>[
    //           StreamBuilder(
    //               stream: FirebaseFirestore.instance
    //                   .collection("AllUsers")
    //                   .where('id'.toString(), isEqualTo: widget.id)
    //                   .snapshots(),
    //               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //                 if (snapshot.hasData) {
    //                   return Column(
    //                     children: snapshot.data!.docs.map((doc) {
    //                       return Column(
    //                         children: <Widget>[
    //                           SizedBox(
    //                             height: 10,
    //                           ),
    //                           Center(
    //                             child: Container(
    //                               width: 110,
    //                               height: 110,
    //                               decoration: BoxDecoration(
    //                                   border: Border.all(
    //                                       width: 2,
    //                                       color: Theme.of(context)
    //                                           .scaffoldBackgroundColor),
    //                                   boxShadow: [
    //                                     BoxShadow(
    //                                         spreadRadius: 2,
    //                                         blurRadius: 10,
    //                                         color:
    //                                             Colors.black.withOpacity(0.1),
    //                                         offset: Offset(0, 10))
    //                                   ],
    //                                   shape: BoxShape.circle,
    //                                   image: DecorationImage(
    //                                       fit: BoxFit.cover,
    //                                       image: NetworkImage(doc['url']))),
    //                             ),
    //                           ),
    //                           SizedBox(
    //                             height: 10,
    //                           ),
    //                           Text(
    //                             doc['Username'],
    //                             style: TextStyle(
    //                                 fontSize: 20,
    //                                 fontWeight: bold,
    //                                 color: mainColorRed),
    //                           ),
    //                           SizedBox(
    //                             height: 10,
    //                           ),
    //                           isUnfriend == false
    //                               ? Center(
    //                                   child: Column(
    //                                     children: <Widget>[
    //                                       Container(
    //                                         width: MediaQuery.of(context)
    //                                                 .size
    //                                                 .width -
    //                                             100,
    //                                         height: 44,
    //                                         child: Row(
    //                                           children: <Widget>[
    //                                             Expanded(
    //                                                 child: InkWell(
    //                                               child: Container(
    //                                                 alignment: Alignment.center,
    //                                                 height: 45,
    //                                                 decoration: BoxDecoration(
    //                                                   color: mainColorBlue,
    //                                                   borderRadius:
    //                                                       BorderRadius.circular(
    //                                                           10),
    //                                                 ),
    //                                                 child: Text(
    //                                                   "Friend",
    //                                                   style: TextStyle(
    //                                                       color: white,
    //                                                       fontSize: 18),
    //                                                 ),
    //                                               ),
    //                                               onTap: () {
    //                                                 setState(() {
    //                                                   isUnfriend = true;
    //                                                   MyUnfriend();
    //                                                 });
    //                                               },
    //                                             )),
    //                                             SizedBox(
    //                                               width: 10,
    //                                             ),
    //                                             Expanded(
    //                                                 child: Container(
    //                                               alignment: Alignment.center,
    //                                               height: 45,
    //                                               decoration: BoxDecoration(
    //                                                 color: mainColorRed,
    //                                                 borderRadius:
    //                                                     BorderRadius.circular(
    //                                                         10),
    //                                               ),
    //                                               child: Text(
    //                                                 "History",
    //                                                 style: TextStyle(
    //                                                     color: white,
    //                                                     fontSize: 18),
    //                                               ),
    //                                             )),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                       SizedBox(
    //                                         height: 30,
    //                                       ),
    //                                       Container(
    //                                           width: MediaQuery.of(context)
    //                                                   .size
    //                                                   .width -
    //                                               30,
    //                                           height: 280,
    //                                           child: isSOS == true
    //                                               ? Container(
    //                                                   padding:
    //                                                       EdgeInsets.all(4),
    //                                                   width:
    //                                                       MediaQuery.of(context)
    //                                                               .size
    //                                                               .width -
    //                                                           30,
    //                                                   height: 280,
    //                                                   decoration: BoxDecoration(
    //                                                       border: Border.all(
    //                                                           color:
    //                                                               mainColorRed),
    //                                                       borderRadius:
    //                                                           BorderRadius
    //                                                               .circular(
    //                                                                   10)),
    //                                                   child: GoogleMap(
    //                                                     myLocationEnabled: true,
    //                                                     myLocationButtonEnabled:
    //                                                         true,
    //                                                     initialCameraPosition:
    //                                                         CameraPosition(
    //                                                       target: LatLng(
    //                                                           11.562108,
    //                                                           104.888535),
    //                                                       zoom: 6.0,
    //                                                     ),
    //                                                     markers: Set<Marker>.of(
    //                                                         _markers),
    //                                                     onMapCreated:
    //                                                         (GoogleMapController
    //                                                             controller) {
    //                                                       _controller.complete(
    //                                                           controller);
    //                                                     },
    //                                                   ),
    //                                                 )
    //                                               : null),
    //                                     ],
    //                                   ),
    //                                 )
    //                               : Center(
    //                                   child: Column(
    //                                     children: <Widget>[
    //                                       Container(
    //                                         width: MediaQuery.of(context)
    //                                                 .size
    //                                                 .width -
    //                                             100,
    //                                         height: 44,
    //                                         child: Row(
    //                                           children: <Widget>[
    //                                             Expanded(
    //                                                 child: InkWell(
    //                                               child: Container(
    //                                                 alignment: Alignment.center,
    //                                                 height: 45,
    //                                                 decoration: BoxDecoration(
    //                                                   color: mainColorBlue,
    //                                                   borderRadius:
    //                                                       BorderRadius.circular(
    //                                                           10),
    //                                                 ),
    //                                                 child: Text(
    //                                                   text,
    //                                                   style: TextStyle(
    //                                                       color: white,
    //                                                       fontSize: 18),
    //                                                 ),
    //                                               ),
    //                                               onTap: () {
    //                                                 setState(() {
    //                                                   text = "Confirm";
    //                                                 });
    //                                               },
    //                                             )),
    //                                             SizedBox(
    //                                               width: 10,
    //                                             ),
    //                                             Expanded(
    //                                                 child: Container(
    //                                               alignment: Alignment.center,
    //                                               height: 45,
    //                                               decoration: BoxDecoration(
    //                                                 color: mainColorRed,
    //                                                 borderRadius:
    //                                                     BorderRadius.circular(
    //                                                         10),
    //                                               ),
    //                                               child: Text(
    //                                                 "History",
    //                                                 style: TextStyle(
    //                                                     color: white,
    //                                                     fontSize: 18),
    //                                               ),
    //                                             )),
    //                                           ],
    //                                         ),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 )
    //                         ],
    //                       );
    //                     }).toList(),
    //                   );
    //                 } else {
    //                   return Center(
    //                     child: CircularProgressIndicator(),
    //                   );
    //                 }
    //               }),
    //         ],
    //       ),
    //     ),
    //   ),
    //   floatingActionButton: Container(
    //       width: MediaQuery.of(context).size.width,
    //       margin: EdgeInsets.only(left: 30),
    //       height: 50,
    //       //color: mainColorBlue,
    //       child: isSOS == true && isUnfriend == false
    //           ? Center(
    //               child: InkWell(
    //                 child: Container(
    //                   alignment: Alignment.center,
    //                   width: MediaQuery.of(context).size.width - 100,
    //                   height: 50,
    //                   decoration: BoxDecoration(
    //                     color: mainColorRed,
    //                     borderRadius: BorderRadius.circular(10),
    //                   ),
    //                   child: Text(
    //                     texthelp,
    //                     style: TextStyle(color: white, fontSize: 18),
    //                   ),
    //                 ),
    //                 onTap: () {
    //                   changeText();
    //                 },
    //               ),
    //             )
    //           : Container()),
    // );
    return Container(
        child: isUnfriend == false
            ? Scaffold(
                appBar: AppBar(
                  backgroundColor: mainColorRed,
                  toolbarHeight: 70,
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: white,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: Text(widget.name),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.15),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(widget.url))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: bold,
                              color: mainColorRed),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width - 100,
                                height: 44,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: InkWell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: mainColorBlue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "Friend",
                                          style: TextStyle(
                                              color: white, fontSize: 18),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          isUnfriend = true;
                                          MyUnfriend();
                                        });
                                      },
                                    )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: InkWell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: mainColorRed,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          "History",
                                          style: TextStyle(
                                              color: white, fontSize: 18),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FriHistory(keuid)));
                                      },
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              // Container(
                              //     width: MediaQuery.of(context).size.width - 30,
                              //     // height: 280,
                              //     child: isSOS == true
                              //         ? Column(
                              //             children: [
                              //               Container(
                              //                 padding: EdgeInsets.all(4),
                              //                 width: MediaQuery.of(context)
                              //                         .size
                              //                         .width -
                              //                     30,
                              //                 height: 280,
                              //                 decoration: BoxDecoration(
                              //                     border: Border.all(
                              //                         color: mainColorRed),
                              //                     borderRadius:
                              //                         BorderRadius.circular(
                              //                             10)),
                              //                 child: GoogleMap(
                              //                   myLocationEnabled: true,
                              //                   myLocationButtonEnabled: true,
                              //                   initialCameraPosition:
                              //                       CameraPosition(
                              //                     target: LatLng(
                              //                         11.562108, 104.888535),
                              //                     zoom: 6.0,
                              //                   ),
                              //                   markers:
                              //                       Set<Marker>.of(_markers),
                              //                   onMapCreated:
                              //                       (GoogleMapController
                              //                           controller) {
                              //                     _controller
                              //                         .complete(controller);
                              //                   },
                              //                 ),
                              //               ),
                              //               // SizedBox(height: 10,),
                              //               // Container(
                              //               //   alignment: Alignment.center,
                              //               //   width: MediaQuery.of(context).size.width - 100,
                              //               //   height: 45,
                              //               //   decoration: BoxDecoration(
                              //               //     borderRadius: BorderRadius.circular(10),
                              //               //     color: mainColorRed,
                              //               //   ),
                              //               //   child: Text("View Location", style: TextStyle(color: white, fontWeight: bold, fontSize: 20),),
                              //               // )
                              //             ],
                              //           )
                              //         : null),
                              Container(
                                  child: Container(
                                width: MediaQuery.of(context).size.width - 30,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                //color: mainColorBlue,
                                // child: StreamBuilder(
                                //   stream: FirebaseFirestore.instance
                                //       .collection("AllUsers")
                                //       .where('uid', isEqualTo: keuid)
                                //       .snapshots(),
                                //   builder: (context,
                                //       AsyncSnapshot<QuerySnapshot> snapshot) {
                                //     if (snapshot.hasData) {
                                //       print(
                                //           "HIiiiiiiiiiiiiiiHEREEEEEEEEEEEEEEEEEEEEEEEEEEE");
                                //       snapshot.data!.docs.map((document) {
                                //         if (document['lastStatus'] == "0") {
                                //           print("hiiiiiii");
                                //           return Container(
                                //             child: GoogleMap(
                                //               myLocationEnabled: true,
                                //               myLocationButtonEnabled: true,
                                //               initialCameraPosition:
                                //                   CameraPosition(
                                //                 target: LatLng(
                                //                     11.562108, 104.888535),
                                //                 zoom: 6.0,
                                //               ),
                                //               markers: Set<Marker>.of(_markers),
                                //               onMapCreated: (GoogleMapController
                                //                   controller) {
                                //                 _controller
                                //                     .complete(controller);
                                //               },
                                //             ),
                                //           );
                                //         }
                                //       }).toList();
                                //     } else {
                                //       return Center();
                                //     }
                                //   },
                                // ),

                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("AllUsers")
                                      .where('uid', isEqualTo: keuid)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.data!.docs[0]
                                            .get('lastStatus') ==
                                        "0") {
                                      return Container(
                                        child: GoogleMap(
                                          myLocationEnabled: true,
                                          myLocationButtonEnabled: true,
                                          initialCameraPosition: CameraPosition(
                                            target:
                                                LatLng(11.562108, 104.888535),
                                            zoom: 6.0,
                                          ),
                                          markers: Set<Marker>.of(_markers),
                                          onMapCreated:
                                              (GoogleMapController controller) {
                                            _controller.complete(controller);
                                          },
                                        ),
                                      );
                                    } else {
                                      return Center();
                                    }
                                  },
                                ),
                              )),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                floatingActionButton: Container(
                  alignment: Alignment.center,
                  //color: mainColorBlue,
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  margin: EdgeInsets.only(left: 30, bottom: 30),
                  child: Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("AllUsers")
                          .where('uid', isEqualTo: keuid)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.data!.docs[0].get('lastStatus') == "0") {
                          return InkWell(
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width - 100,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: mainColorRed,
                              ),
                              child: Text(
                                texthelp,
                                style: TextStyle(
                                    color: white,
                                    fontWeight: bold,
                                    fontSize: 20),
                              ),
                            ),
                            onTap: () {
                              changeText();
                            },
                          );
                        } else {
                          return Center();
                        }
                      },
                    ),
                  ),
                ),
              )
            : Container(
                child: NotFreinfScreen(widget.id, widget.uid, widget.name),
              ));
  }
}
