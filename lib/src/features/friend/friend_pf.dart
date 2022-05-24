import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:onecam/src/features/frienf_pf/FriendScreen.dart';
import 'package:onecam/src/utils/app_con.dart';


// class FriendProfile extends StatefulWidget {
//   //const FriendProfile({Key? key}) : super(key: key);

//   @override
//   _FriendProfileState createState() => _FriendProfileState();
// }

// class _FriendProfileState extends State<FriendProfile> {
//   final User user = FirebaseAuth.instance.currentUser!;
//   var _firebaseInstance = FirebaseFirestore.instance;
//   var refri = [];
//   var fri = [];
//   var getrefri = [];
//   var userfri = [];
//   var myfri = [];
//   var Test = [];
//   var getFri = [];
//   var getRefri = [];
//   var newRefri = [];
//   String id = "";
//   String myid = "";
//   String friid = "";

//   void getreFriList() async {
//     QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
//     FirebaseFirestore.instance
//         .collection('AllUsers')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         if (doc['uid'] == user.uid) {
//           setState(() {
//             myid = doc['id'];
//             refri = doc["reFri"];
//             fri = doc["fri"];
//             print("innnnnnnnnn");
//             print(refri);
//             print(fri);
//             print(user.uid);
//             print("innnnnnnnnn");
//           });
//         }
//       });
//     });
//   }

//   void showreFri() async {
//     QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
//     FirebaseFirestore.instance
//         .collection("AllUsers")
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         for (int i = 0; i < refri.length; i++) {
//           if (refri[i] == doc['id']) {
//             userfri.add({
//               "url": doc['url'],
//               "Username": doc['Username'],
//               "Phonenumber": doc['Phonenumber'],
//               "id": doc['id'],
//             });
//             print(doc['id']);
//           }
//         }
//       });
//     });
//   }

//   void showFri() async {
//     QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
//     FirebaseFirestore.instance
//         .collection("AllUsers")
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         for (int i = 0; i < fri.length; i++) {
//           if (fri[i] == doc['id']) {
//             myfri.add({
//               'id': doc['id'],
//               "url": doc['url'],
//               "Username": doc['Username'],
//               "Phonenumber": doc['Phonenumber'],
//               'uid': doc['uid']
//             });
//             print(myfri);
//           }
//         }
//       });
//     });
//   }

//   @override
//   void initState() {
//     getreFriList();
//     showreFri();
//     print("Friend");
//     showFri();
//     print(userfri.length);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print(userfri);
//     return ListView.builder(
//         shrinkWrap: true,
//         scrollDirection: Axis.vertical,
//         itemCount: myfri.length,
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
//                             backgroundImage: NetworkImage(myfri[index]["url"]),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Expanded(
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: MediaQuery.of(context).size.width - 250,
//                                 child: Text(
//                                   myfri[index]["Username"],
//                                   style: TextStyle(
//                                       color: mainColorRed,
//                                       fontSize: 19,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Flexible(
//                                 child: InkWell(
//                                   child: Container(
//                                     alignment: Alignment.center,
//                                     height: 40,
//                                     width: 110,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.withOpacity(0.4),
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Text(
//                                       "Delete",
//                                       style:
//                                           TextStyle(fontSize: 17, color: white),
//                                     ),
//                                   ),
//                                   onTap: () async {
//                                     QuerySnapshot qn = await _firebaseInstance
//                                         .collection("AllUsers")
//                                         .get();
//                                     FirebaseFirestore.instance
//                                         .collection("AllUsers")
//                                         .doc(user.uid)
//                                         .update({
//                                       'fri': FieldValue.arrayRemove(
//                                           [myfri[index]['id']]),
//                                     });
//                                     FirebaseFirestore.instance
//                                         .collection("AllUsers")
//                                         .doc(myfri[index]['uid'])
//                                         .update({
//                                       'fri': FieldValue.arrayRemove([myid])
//                                     });
//                                   },
//                                 ),
//                               ),
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
//                       builder: (context) => FriendProfileScreen(
//                           "fri",
//                           myfri[index]['id'].toString(),
//                           myfri[index]['Username'],
//                           myfri[index]['uid'],
//                           myfri[index]['url'])));
//             },
//           );
//         });
//   }
// }

class HotFriend extends StatefulWidget {
  const HotFriend({Key? key}) : super(key: key);

  @override
  State<HotFriend> createState() => _HotFriendState();
}

class _HotFriendState extends State<HotFriend> {
  var _firebaseInstance = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User user = FirebaseAuth.instance.currentUser!;
  var getMyfriList = [];
  String myid = "";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("AllUsers")
            .where('uid', isEqualTo: user.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // return StreamBuilder(
          //   stream: FirebaseFirestore.instance
          //   .collection("AllUsers")
          //   .where('id', isEqualTo: getMyfriList[])
          //   .snapshots(),
          //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

          //     });
          if (snapshot.hasData) {
            getMyfriList = snapshot.data!.docs[0].get('fri');
            myid = snapshot.data!.docs[0].get('id');
            print(getMyfriList);
            return Container(
                child: getMyfriList.length != 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: getMyfriList.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("AllUsers")
                                  .where('id', isEqualTo: getMyfriList[index])
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
                                                              doc['url']),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width -
                                                              250,
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
                                                          width: 10,
                                                        ),
                                                        Flexible(
                                                          child: InkWell(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height: 40,
                                                              width: 110,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.4),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                              child: Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color:
                                                                        white),
                                                              ),
                                                            ),
                                                            onTap: () async {
                                                              QuerySnapshot qn =
                                                                  await _firebaseInstance
                                                                      .collection(
                                                                          "AllUsers")
                                                                      .get();
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "AllUsers")
                                                                  .doc(user.uid)
                                                                  .update({
                                                                'fri': FieldValue
                                                                    .arrayRemove([
                                                                  doc['id']
                                                                ]),
                                                              });
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      "AllUsers")
                                                                  .doc(doc[
                                                                      'uid'])
                                                                  .update({
                                                                'fri': FieldValue
                                                                    .arrayRemove(
                                                                        [myid])
                                                              });
                                                            },
                                                          ),
                                                        ),
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
                                                    FriendProfileScreen(
                                                        "fri",
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
