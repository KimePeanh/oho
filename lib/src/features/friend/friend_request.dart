import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecam/src/features/frienf_pf/Request.dart';
import 'package:onecam/src/utils/app_con.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

// class Friend_Request extends StatefulWidget {
//   const Friend_Request({Key? key}) : super(key: key);

//   @override
//   _Friend_RequestState createState() => _Friend_RequestState();
// }

// class _Friend_RequestState extends State<Friend_Request> {
//   var getFriend_RequestList = [];
//   var ShowRequestList = [];
//   var getmyFri = [];
//   var getmyreFri = [];
//   var getmyaddFri = [];
//   var getaddFri = [];
//   var getFri = [];
//   String uid = "";
//   String id = "";
//   String myId = '';
//   bool cf = false;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final User user = FirebaseAuth.instance.currentUser!;
//   var _firebaseInstance = FirebaseFirestore.instance;
//   RefreshController _refreshController =
//       RefreshController(initialRefresh: false);
//   void getreFriList() async {
//     QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
//     FirebaseFirestore.instance
//         .collection('AllUsers')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         if (doc['uid'] == user.uid) {
//           setState(() {
//             getFriend_RequestList = doc["reFri"];
//           });
//         }
//       });
//     });
//   }

//   void _onRefresh() async {
//     await Future.delayed(Duration(milliseconds: 1000));
//     _refreshController.refreshCompleted();
//   }

//   void _onLoading() async {
//     await Future.delayed(Duration(milliseconds: 1000));

//     if (mounted) setState(() {});
//     _refreshController.loadComplete();
//   }

//   void getAllMyList() async {
//     QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
//     FirebaseFirestore.instance
//         .collection("AllUsers")
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         if (doc['uid'] == user.uid) {
//           setState(() {
//             myId = doc['id'].toString();
//             print(myId + "ggggggggggggggggggggggggggg");
//             print(doc['id']);
//             print('okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
//             getmyFri = doc['fri'];
//             getmyaddFri = doc['addfri'];
//             getmyreFri = doc['reFri'];
//             print(getmyFri.toString() + "myyyyyyyyyyyyyyyyyyy");
//           });
//         }
//       });
//     });
//   }

//   void getList() async {
//     QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
//     FirebaseFirestore.instance
//         .collection("AllUsers")
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         if (doc['id'] == id) {
//           setState(() {
//             uid = doc['uid'];
//             getFri = doc['fri'];
//             getaddFri = doc['addfri'];
//             print(getaddFri);
//           });
//         }
//       });
//     });
//   }

//   void myconfirmList() async {
//     QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
//     FirebaseFirestore.instance.collection("AllUsers").doc(user.uid).update({
//       'reFri': FieldValue.arrayRemove([id])
//     });
//     FirebaseFirestore.instance
//         .collection("AllUsers")
//         .doc(user.uid)
//         .update({'fri': getmyFri});
//   }

//   void confirmList() async {
//     QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
//     FirebaseFirestore.instance.collection("AllUsers").doc(uid).update({
//       'addfri': FieldValue.arrayRemove([myId])
//     });
//     FirebaseFirestore.instance
//         .collection("AllUsers")
//         .doc(uid)
//         .update({'fri': getFri});
//   }

//   void Friend_RequestData() async {
//     QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
//     FirebaseFirestore.instance
//         .collection("AllUsers")
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         for (int i = 0; i < getFriend_RequestList.length; i++) {
//           if (getFriend_RequestList[i] == doc['id']) {
//             setState(() {
//               ShowRequestList.add({
//                 "url": doc['url'],
//                 "Username": doc['Username'],
//                 "Phonenumber": doc['Phonenumber'],
//                 "id": doc['id'],
//                 'uid': doc['uid']
//               });
//               print(doc['id']);
//             });
//           }
//         }
//       });
//     });
//   }

//   void confirm_fri() async {
//     StreamBuilder(
//       stream: FirebaseFirestore.instance
//           .collection("AllUsers")
//           .where('uid', isEqualTo: user.uid)
//           .snapshots(),
//       builder: (context, AsyncSnapshot snapshot) {
//         if (snapshot.hasData) {
//           setState(() {
//             getFriend_RequestList = snapshot.data['reFri'];
//             print(getFriend_RequestList);
//           });
//           return snapshot.data['reFri'];
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }

//   @override
//   void initState() {
//     getreFriList();
//     print("Hi");
//     Friend_RequestData();
//     confirm_fri();
//     getAllMyList();
//     getList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         shrinkWrap: true,
//         scrollDirection: Axis.vertical,
//         itemCount: ShowRequestList.length,
//         itemBuilder: (_, index) {
//           return InkWell(
//             child: Container(
//               //color: Colors.white,
//               padding: EdgeInsets.only(top: 5),
//               child: Column(
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width - 10,
//                     height: 70,
//                     padding: EdgeInsets.only(left: 20),
//                     child: Row(
//                       children: <Widget>[
//                         Container(
//                           width: 70,
//                           height: 70,
//                           child: CircleAvatar(
//                             backgroundColor: mainColorRed,
//                             backgroundImage:
//                                 NetworkImage(ShowRequestList[index]["url"]),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 8,
//                         ),
//                         Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.only(left: 10),
//                                 //color: mainColorBlue,
//                                 //width: MediaQuery.of(context).size.width - 250,
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   ShowRequestList[index]["Username"],
//                                   style: TextStyle(
//                                       color: mainColorRed,
//                                       fontSize: 19,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width - 140,
//                                 height: 30,
//                                 child: Row(
//                                   //mainAxisAlignment: MainAxisAlignment.start,
//                                   children: <Widget>[
//                                     Expanded(
//                                         child: InkWell(
//                                       child: Container(
//                                         height: 30,
//                                         alignment: Alignment.center,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(5),
//                                             color: mainColorRed),
//                                         child: Text(
//                                           "Confirm",
//                                           style: TextStyle(color: white),
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         setState(() {
//                                           id = ShowRequestList[index]['id'];
//                                           getmyFri.add(id);
//                                           getFri.add(myId);
//                                           myconfirmList();
//                                           confirmList();
//                                           print(myId);
//                                           print(id);
//                                         });
//                                       },
//                                     )),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Expanded(
//                                         child: Container(
//                                       height: 30,
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           color: grey.withOpacity(0.6)),
//                                       child: Text(
//                                         "Delete",
//                                         style: TextStyle(color: white),
//                                       ),
//                                     )),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => RequestScreen(
//                           ShowRequestList[index]['id'].toString(),
//                           ShowRequestList[index]['Username'],
//                           ShowRequestList[index]['uid'],
//                           ShowRequestList[index]['url'])));
//             },
//           );
//         });

//     // return StreamBuilder(
//     //   stream: FirebaseFirestore.instance
//     //       .collection("AllUsers")
//     //       .where('uid', isEqualTo: user.uid)
//     //       .snapshots(),
//     //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     //     if (snapshot.hasData) {
//     //       snapshot.data!.docs.map((doc) {
//     //         getFriend_RequestList = doc['reFri'];
//     //         print("Friend Request List get here");
//     //         print(getFriend_RequestList);
//     //       }).toList();
//     //       for (int i = 0; i < getFriend_RequestList.length; i++) {
//     //         return StreamBuilder(
//     //           stream: FirebaseFirestore.instance
//     //               .collection("AllUser")
//     //               .where('id', isEqualTo: getFriend_RequestList[i])
//     //               .snapshots(),
//     //           builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
//     //             if (snap.hasData) {
//     //               print("Test get[i]");
//     //               print(getFriend_RequestList[i]);
//     //               print(FirebaseFirestore.instance
//     //                   .collection("AllUsers")
//     //                   .where('id', isEqualTo: getFriend_RequestList[i]).snapshots());
//     //               return Column(
//     //                 children: snap.data!.docs.map((d) {
//     //                   return ListView.builder(
//     //                       shrinkWrap: true,
//     //                       scrollDirection: Axis.vertical,
//     //                       itemCount: getFriend_RequestList.length,
//     //                       itemBuilder: (_, index) {
//     //                         return Container(
//     //                           padding: EdgeInsets.only(top: 5),
//     //                           child: Column(
//     //                             children: [
//     //                               Container(
//     //                                 width:
//     //                                     MediaQuery.of(context).size.width - 10,
//     //                                 height: 70,
//     //                                 padding: EdgeInsets.only(left: 20),
//     //                                 child: Row(
//     //                                   children: <Widget>[
//     //                                     Container(
//     //                                       width: 70,
//     //                                       height: 70,
//     //                                       child: CircleAvatar(
//     //                                         backgroundColor: mainColorRed,
//     //                                         backgroundImage:
//     //                                             NetworkImage(d['url']),
//     //                                       ),
//     //                                     ),
//     //                                     SizedBox(
//     //                                       width: 8,
//     //                                     ),
//     //                                     Expanded(
//     //                                       child: Column(
//     //                                         mainAxisAlignment:
//     //                                             MainAxisAlignment.center,
//     //                                         children: [
//     //                                           Container(
//     //                                             padding:
//     //                                                 EdgeInsets.only(left: 10),
//     //                                             //color: mainColorBlue,
//     //                                             //width: MediaQuery.of(context).size.width - 250,
//     //                                             alignment: Alignment.centerLeft,
//     //                                             child: Text(
//     //                                               d['Username'],
//     //                                               style: TextStyle(
//     //                                                   color: mainColorRed,
//     //                                                   fontSize: 19,
//     //                                                   fontWeight:
//     //                                                       FontWeight.bold),
//     //                                             ),
//     //                                           ),
//     //                                           SizedBox(
//     //                                             height: 5,
//     //                                           ),
//     //                                           Container(
//     //                                             width: MediaQuery.of(context)
//     //                                                     .size
//     //                                                     .width -
//     //                                                 140,
//     //                                             height: 30,
//     //                                             child: Row(
//     //                                               //mainAxisAlignment: MainAxisAlignment.start,
//     //                                               children: <Widget>[
//     //                                                 Expanded(
//     //                                                     child: Container(
//     //                                                   height: 30,
//     //                                                   alignment:
//     //                                                       Alignment.center,
//     //                                                   decoration: BoxDecoration(
//     //                                                       borderRadius:
//     //                                                           BorderRadius
//     //                                                               .circular(5),
//     //                                                       color: mainColorRed),
//     //                                                   child: Text(
//     //                                                     "Confirm",
//     //                                                     style: TextStyle(
//     //                                                         color: white),
//     //                                                   ),
//     //                                                 )),
//     //                                                 SizedBox(
//     //                                                   width: 5,
//     //                                                 ),
//     //                                                 Expanded(
//     //                                                     child: Container(
//     //                                                   height: 30,
//     //                                                   alignment:
//     //                                                       Alignment.center,
//     //                                                   decoration: BoxDecoration(
//     //                                                       borderRadius:
//     //                                                           BorderRadius
//     //                                                               .circular(5),
//     //                                                       color:
//     //                                                           grey.withOpacity(
//     //                                                               0.6)),
//     //                                                   child: Text(
//     //                                                     "Delete",
//     //                                                     style: TextStyle(
//     //                                                         color: white),
//     //                                                   ),
//     //                                                 )),
//     //                                               ],
//     //                                             ),
//     //                                           )
//     //                                         ],
//     //                                       ),
//     //                                     ),
//     //                                     SizedBox(
//     //                                       width: 10,
//     //                                     ),
//     //                                   ],
//     //                                 ),
//     //                               ),
//     //                             ],
//     //                           ),
//     //                         );
//     //                       });
//     //                 }).toList(),
//     //               );
//     //               // snap.data!.docs.map((documents) {
//     //               //   print("Username");
//     //               //   print(documents['Username']);
//     //               //   return ListView.builder(
//     //               //       shrinkWrap: true,
//     //               //       scrollDirection: Axis.vertical,
//     //               //       itemCount: getFriend_RequestList.length,
//     //               //       itemBuilder: (_, index) {
//     //               //         return Container(
//     //               //           //color: Colors.white,
//     //               //           padding: EdgeInsets.only(top: 5),
//     //               //           child: Column(
//     //               //             children: [
//     //               //               Container(
//     //               //                 width: MediaQuery.of(context).size.width - 10,
//     //               //                 height: 70,
//     //               //                 padding: EdgeInsets.only(left: 20),
//     //               //                 child: Row(
//     //               //                   children: <Widget>[
//     //               //                     Container(
//     //               //                       width: 70,
//     //               //                       height: 70,
//     //               //                       child: CircleAvatar(
//     //               //                         backgroundColor: mainColorRed,
//     //               //                         backgroundImage:
//     //               //                             NetworkImage(documents['url']),
//     //               //                       ),
//     //               //                     ),
//     //               //                     SizedBox(
//     //               //                       width: 8,
//     //               //                     ),
//     //               //                     Expanded(
//     //               //                       child: Column(
//     //               //                         mainAxisAlignment:
//     //               //                             MainAxisAlignment.center,
//     //               //                         children: [
//     //               //                           Container(
//     //               //                             padding:
//     //               //                                 EdgeInsets.only(left: 10),
//     //               //                             //color: mainColorBlue,
//     //               //                             //width: MediaQuery.of(context).size.width - 250,
//     //               //                             alignment: Alignment.centerLeft,
//     //               //                             child: Text(
//     //               //                               documents['Username'],
//     //               //                               style: TextStyle(
//     //               //                                   color: mainColorRed,
//     //               //                                   fontSize: 19,
//     //               //                                   fontWeight:
//     //               //                                       FontWeight.bold),
//     //               //                             ),
//     //               //                           ),
//     //               //                           SizedBox(
//     //               //                             height: 5,
//     //               //                           ),
//     //               //                           Container(
//     //               //                             width: MediaQuery.of(context)
//     //               //                                     .size
//     //               //                                     .width -
//     //               //                                 140,
//     //               //                             height: 30,
//     //               //                             child: Row(
//     //               //                               //mainAxisAlignment: MainAxisAlignment.start,
//     //               //                               children: <Widget>[
//     //               //                                 Expanded(
//     //               //                                     child: Container(
//     //               //                                   height: 30,
//     //               //                                   alignment: Alignment.center,
//     //               //                                   decoration: BoxDecoration(
//     //               //                                       borderRadius:
//     //               //                                           BorderRadius
//     //               //                                               .circular(5),
//     //               //                                       color: mainColorRed),
//     //               //                                   child: Text(
//     //               //                                     "Confirm",
//     //               //                                     style: TextStyle(
//     //               //                                         color: white),
//     //               //                                   ),
//     //               //                                 )),
//     //               //                                 SizedBox(
//     //               //                                   width: 5,
//     //               //                                 ),
//     //               //                                 Expanded(
//     //               //                                     child: Container(
//     //               //                                   height: 30,
//     //               //                                   alignment: Alignment.center,
//     //               //                                   decoration: BoxDecoration(
//     //               //                                       borderRadius:
//     //               //                                           BorderRadius
//     //               //                                               .circular(5),
//     //               //                                       color: grey
//     //               //                                           .withOpacity(0.6)),
//     //               //                                   child: Text(
//     //               //                                     "Delete",
//     //               //                                     style: TextStyle(
//     //               //                                         color: white),
//     //               //                                   ),
//     //               //                                 )),
//     //               //                               ],
//     //               //                             ),
//     //               //                           )
//     //               //                         ],
//     //               //                       ),
//     //               //                     ),
//     //               //                     SizedBox(
//     //               //                       width: 10,
//     //               //                     ),
//     //               //                   ],
//     //               //                 ),
//     //               //               ),
//     //               //             ],
//     //               //           ),
//     //               //         );
//     //               //       });
//     //               // }).toList();
//     //             } else {
//     //               return Center(
//     //                 child: CircularProgressIndicator(),
//     //               );
//     //             }
//     //           },
//     //         );
//     //       }
//     //     } else {
//     //       return Container();
//     //     }
//     //     return Container();
//     //   },
//     // );

//     // return StreamBuilder(
//     //     stream: FirebaseFirestore.instance
//     //         .collection("AllUsers")
//     //         .where('uid', isEqualTo: user.uid)
//     //         .snapshots(),
//     //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//     //       if (snapshot.hasData) {
//     //         return Column(
//     //           children: snapshot.data!.docs.map((doc) {
//     //             //getFriend_RequestList = doc['reFri'];
//     //             //print(getFriend_RequestList);
//     //             return Container();
//     //           }).toList(),
//     //         );
//     //       } else {
//     //         print("ok");
//     //         return CircularProgressIndicator();
//     //       }
//     //       //return CircularProgressIndicator();
//     //     });
//   }
// }

class HotRefriScreen extends StatefulWidget {
  const HotRefriScreen({Key? key}) : super(key: key);

  @override
  State<HotRefriScreen> createState() => _HotRefriScreenState();
}

class _HotRefriScreenState extends State<HotRefriScreen> {
  final User user = FirebaseAuth.instance.currentUser!;
  var _firebaseInstance = FirebaseFirestore.instance;
  var getReFri = [];
  String myid = "";
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("AllUsers")
            .where('uid', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            getReFri = snapshot.data!.docs[0].get('reFri');
            myid = snapshot.data!.docs[0].get('id');
            print(getReFri);
            return Container(
                child: getReFri.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: getReFri.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("AllUsers")
                                  .where('id', isEqualTo: getReFri[index])
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                      children: snapshot.data!.docs.map((doc) {
                                    return InkWell(
                                      child: Container(
                                        //color: Colors.white,
                                        padding: EdgeInsets.only(top: 5),
                                        child: Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  10,
                                              height: 70,
                                              padding:
                                                  EdgeInsets.only(left: 20),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: 70,
                                                    height: 70,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          mainColorRed,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              doc["url"]),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          //color: mainColorBlue,
                                                          //width: MediaQuery.of(context).size.width - 250,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            doc["Username"],
                                                            style: TextStyle(
                                                                color:
                                                                    mainColorRed,
                                                                fontSize: 19,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              140,
                                                          height: 30,
                                                          child: Row(
                                                            //mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Expanded(
                                                                  child:
                                                                      InkWell(
                                                                child:
                                                                    Container(
                                                                  height: 30,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color:
                                                                          mainColorRed),
                                                                  child: Text(
                                                                    "Confirm",
                                                                    style: TextStyle(
                                                                        color:
                                                                            white),
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    // id = ShowRequestList[index]['id'];
                                                                    // getmyFri.add(id);
                                                                    // getFri.add(myId);
                                                                    // myconfirmList();
                                                                    // confirmList();
                                                                    // print(myId);
                                                                    // print(id);
                                                                  });
                                                                },
                                                              )),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Expanded(
                                                                  child:
                                                                      Container(
                                                                height: 30,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                5),
                                                                    color: grey
                                                                        .withOpacity(
                                                                            0.6)),
                                                                child: Text(
                                                                  "Delete",
                                                                  style: TextStyle(
                                                                      color:
                                                                          white),
                                                                ),
                                                              )),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RequestScreen(
                                                        doc['id'].toString(),
                                                        doc['Username'],
                                                        doc['uid'],
                                                        doc['url'])));
                                      },
                                    );
                                  }).toList());
                                  //     Container(
                                  //       width: 70,
                                  //       height: 70,
                                  //       child: CircleAvatar(
                                  //         backgroundColor: mainColorRed,
                                  //         backgroundImage: NetworkImage(),
                                  //       ),
                                  //     )
                                  //   ],
                                  // );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              });
                        })
                    : Container());
          } else {
            return Container();
          }
        });
  }
}
