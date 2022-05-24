import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecam/src/utils/app_con.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'friend_pf.dart';
import 'friend_request.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String Tab = "Friend_Request";
  String tittle = "Friend Request";
  String tFriend = "Friend";
  Color ReColor = Colors.grey.withOpacity(0.4);
  Color FriColor = Color(0xffC33232).withOpacity(0.4);

  void CheckTab() {
    if (Tab == "Friend_Request") {
      setState(() {
        tittle = "Friend Request";
        ReColor = Colors.grey.withOpacity(0.4);
        FriColor = Color(0xffC33232).withOpacity(0.4);
      });
    } else {
      setState(() {
        tittle = "Friend List";
        ReColor = Color(0xffC33232).withOpacity(0.4);
        FriColor = Colors.grey.withOpacity(0.4);
      });
    }
  }
   var getFriend_RequestList = [];
  var ShowRequestList = [];
  var getmyFri = [];
  var getmyreFri = [];
  var getmyaddFri = [];
  var getaddFri = [];
  var getFri = [];
  String uid = "";
  String id = "";
  String myId = '';
  bool cf = false;
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final User user = FirebaseAuth.instance.currentUser!;
  var _firebaseInstance = FirebaseFirestore.instance;
  void getreFriList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection('AllUsers')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == user.uid) {
          setState(() {
            getFriend_RequestList = doc["reFri"];
          });
        }
      });
    });
  }
    void _onRefresh() async{
    //await Future.delayed(Duration(milliseconds: 1000));
   setState(() {
      getreFriList();
    print("Hi");
    Friend_RequestData();
    confirm_fri();
    getAllMyList();
    getList();
        _refreshController.refreshCompleted();
   });

  }
    void _onLoading() async{
    await Future.delayed(Duration(milliseconds: 1000));
    
    if(mounted)
    setState(() {

    });
    _refreshController.loadComplete();
  }


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
        if (doc['id'] == id) {
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
      'reFri': FieldValue.arrayRemove([id])
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

  void Friend_RequestData() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        for (int i = 0; i < getFriend_RequestList.length; i++) {
          if (getFriend_RequestList[i] == doc['id']) {
            setState(() {
              ShowRequestList.add({
                "url": doc['url'],
                "Username": doc['Username'],
                "Phonenumber": doc['Phonenumber'],
                "id": doc['id']
              });
              print(doc['id']);
            });
          }
        }
      });
    });
  }

  void confirm_fri() async {
    StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("AllUsers")
          .where('uid', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          setState(() {
            getFriend_RequestList = snapshot.data['reFri'];
            print(getFriend_RequestList);
          });
          return snapshot.data['reFri'];
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  void initState() {
    //CheckTab();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SafeArea(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: 180,
                decoration: BoxDecoration(
                    color: mainColorRed,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      tittle,
                      style: TextStyle(
                          fontSize: 17, fontWeight: bold, color: white),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          width: MediaQuery.of(context).size.width - 150,
                          height: 40,
                          child: Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ReColor),
                                  child: Text(
                                    "Friend Request",
                                    style: TextStyle(color: white),
                                  ),
                                ),
                                onTap: () {
                                  Tab = "Friend_Request";
                                  CheckTab();
                                },
                              )),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: InkWell(
                                child: Container(
                                  height: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: FriColor),
                                  child: Text(
                                    tFriend,
                                    style: TextStyle(color: white),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    Tab = "Firend";
                                  });
                                  CheckTab();
                                  //print(object)
                                },
                              ))
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
              Tab == "Friend_Request"
                  ? HotRefriScreen()
                  : HotFriend(),
            ],
          ),
        ),
      ),
      
    );
  }
}
