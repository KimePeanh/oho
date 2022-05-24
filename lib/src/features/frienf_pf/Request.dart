import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecam/src/features/frienf_pf/not_friend.dart';
import 'package:onecam/src/utils/app_con.dart';

import 'FriendScreen.dart';


class RequestScreen extends StatefulWidget {
  //const RequestScreen({ Key? key }) : super(key: key);
  final id;
  final name;
  final String uid;
  final String url;
  RequestScreen(this.id, this.name, this.uid, this.url);

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final User user = FirebaseAuth.instance.currentUser!;
  var _firebaseInstance = FirebaseFirestore.instance;
  var getmyFri = [];
  var getmyreFri = [];
  var getmyaddFri = [];
  var getaddFri = [];
  var getFri = [];
  String uid = "";
  String myId = '';
  bool cf = false;
  bool isdel = false;

  void getAllMyList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == user.uid) {
          setState(() {
            myId = doc['id'].toString();
            print(myId + "ggggggggggggggggggggggggggg");
            print(doc['id']);
            print('okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
            getmyFri = doc['fri'];
            getmyaddFri = doc['addfri'];
            getmyreFri = doc['reFri'];
            print(getmyFri.toString() + "myyyyyyyyyyyyyyyyyyy");
          });
        }
      });
    });
  }

  void getList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['id'] == widget.id) {
          setState(() {
            uid = doc['uid'];
            getFri = doc['fri'];
            getaddFri = doc['addfri'];
            print(getaddFri);
          });
        }
      });
    });
  }

  void myconfirmList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance.collection("AllUsers").doc(user.uid).update({
      'reFri': FieldValue.arrayRemove([widget.id])
    });
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(user.uid)
        .update({'fri': getmyFri});
  }

  void confirmList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance.collection("AllUsers").doc(uid).update({
      'addfri': FieldValue.arrayRemove([myId])
    });
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(uid)
        .update({'fri': getFri});
  }

  void unfriend() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance.collection("AllUsers").doc(uid).update({
      'fri': FieldValue.arrayRemove([myId])
    });
    FirebaseFirestore.instance.collection("AllUsers").doc(user.uid).update({
      'fri': FieldValue.arrayRemove([widget.id])
    });
  }

  void delete() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance.collection("AllUsers").doc(uid).update({
      'addfri': FieldValue.arrayRemove([myId])
    });
    FirebaseFirestore.instance.collection("AllUsers").doc(user.uid).update({
      'reFri': FieldValue.arrayRemove([widget.id])
    });
  }

  @override
  void initState() {
    print(widget.uid);
    print(widget.id);
    getAllMyList();
    getList();
    print(myId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(myId + '   jjjjjjjjjjjjjjjjjjjjjjj');
    print(uid);
    print(widget.id);
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
    //                           Container(
    //                               width:
    //                                   MediaQuery.of(context).size.width - 100,
    //                               height: 42,
    //                               child: cf == false
    //                                   ? Row(
    //                                       children: <Widget>[
    //                                         Expanded(
    //                                             child: InkWell(
    //                                           child: Container(
    //                                             alignment: Alignment.center,
    //                                             height: 42,
    //                                             decoration: BoxDecoration(
    //                                               color: mainColorBlue,
    //                                               borderRadius:
    //                                                   BorderRadius.circular(10),
    //                                             ),
    //                                             child: Text(
    //                                               "Confirm",
    //                                               style: TextStyle(
    //                                                   color: white,
    //                                                   fontSize: 18),
    //                                             ),
    //                                           ),
    //                                           onTap: () {
    //                                             setState(() {
    //                                               cf = true;
    //                                               getmyFri.add(widget.id);
    //                                               getFri.add(myId);
    //                                               myconfirmList();
    //                                               confirmList();
    //                                             });
    //                                           },
    //                                         )),
    //                                         SizedBox(
    //                                           width: 10,
    //                                         ),
    //                                         Expanded(
    //                                             child: Container(
    //                                           alignment: Alignment.center,
    //                                           height: 42,
    //                                           decoration: BoxDecoration(
    //                                             color: mainColorRed,
    //                                             borderRadius:
    //                                                 BorderRadius.circular(10),
    //                                           ),
    //                                           child: Text(
    //                                             "Delete",
    //                                             style: TextStyle(
    //                                                 color: white, fontSize: 18),
    //                                           ),
    //                                         )),
    //                                       ],
    //                                     )
    //                                   : Row(
    //                                       children: <Widget>[
    //                                         Expanded(
    //                                             child: InkWell(
    //                                           child: Container(
    //                                             alignment: Alignment.center,
    //                                             height: 42,
    //                                             decoration: BoxDecoration(
    //                                               color: mainColorBlue,
    //                                               borderRadius:
    //                                                   BorderRadius.circular(10),
    //                                             ),
    //                                             child: Text(
    //                                               "Friend",
    //                                               style: TextStyle(
    //                                                   color: white,
    //                                                   fontSize: 18),
    //                                             ),
    //                                           ),
    //                                           onTap: () {
    //                                            unfriend();
    //                                           },
    //                                         )),
    //                                         SizedBox(
    //                                           width: 10,
    //                                         ),
    //                                         Expanded(
    //                                             child: Container(
    //                                           alignment: Alignment.center,
    //                                           height: 42,
    //                                           decoration: BoxDecoration(
    //                                             color: mainColorRed,
    //                                             borderRadius:
    //                                                 BorderRadius.circular(10),
    //                                           ),
    //                                           child: Text(
    //                                             "History",
    //                                             style: TextStyle(
    //                                                 color: white, fontSize: 18),
    //                                           ),
    //                                         )),
    //                                       ],
    //                                     )),
    //                           SizedBox(
    //                             height: 30,
    //                           ),
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
    // );
    return Container(
        child: cf == false
            ?
            Container(
              child: isdel == false?
              Scaffold(
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
                                        color: Colors.black.withOpacity(0.1),
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
                          Container(
                              width: MediaQuery.of(context).size.width - 100,
                              height: 42,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: InkWell(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: mainColorBlue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Confirm",
                                        style:
                                            TextStyle(color: white, fontSize: 18),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        cf = true;
                                        getmyFri.add(widget.id);
                                        getFri.add(myId);
                                        myconfirmList();
                                        confirmList();
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
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: mainColorRed,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Delete",
                                        style:
                                            TextStyle(color: white, fontSize: 18),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        isdel = true;
                                        delete();
                                      });
                                    },
                                  )),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ): NotFreinfScreen(widget.id, uid, widget.name)
            )
            : Container(
                child: FriendProfileScreen(
                    "fri", widget.id, widget.name, widget.uid, widget.url),
              ));
  }
}
