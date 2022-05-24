import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecam/src/utils/app_con.dart';


class NotFreinfScreen extends StatefulWidget {
  //const NotFreinfScreen({ Key? key }) : super(key: key);]
  final String id;
  final String uid;
  final String name;

  NotFreinfScreen(this.id, this.uid, this.name);

  @override
  State<NotFreinfScreen> createState() => _NotFreinfScreenState();
}

class _NotFreinfScreenState extends State<NotFreinfScreen> {
  late final User user = FirebaseAuth.instance.currentUser!;
  var _firebaseInstance = FirebaseFirestore.instance;
  var getmyfri = [];
  var getmyrefri = [];
  var getmyaddfri = [];
  bool isCf = false;
  bool isAdd = false;
  String uid = "";
  var kefri = [];
  var kerefri = [];
  var keaddfri = [];
  String text = "Add Friend";
  String myid = "";
  String action = "check";

  void load() async {
    await Future.delayed(Duration(seconds: 2), () {
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  void getMyList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection('AllUsers')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == user.uid) {
          setState(() {
            getmyfri = doc["fri"];
            myid = doc["id"];
            getmyrefri = doc['reFri'];
            getmyaddfri = doc['addfri'];
            print(myid + "okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
            print(getmyfri);
          });
        }
        setState(() {
          checkListWithId();
        });
      });
    });
  }

  void TransferUserList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["id"] == widget.id) {
          setState(() {
            uid = doc['uid'];
            kefri = doc['fri'];
            kerefri = doc['reFri'];
            keaddfri = doc['addfri'];
          });
        }
      });
    });
  }

  void AddFriend() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(user.uid)
        .update({'addfri': getmyaddfri});
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(uid)
        .update({'reFri': kerefri});
    print(user.uid);
    print(getmyaddfri);
    print(widget.uid);
    print(kerefri);
  }

  void addfri() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance.collection("AllUsers").doc(user.uid).update({
      'addfri': FieldValue.arrayRemove([widget.id])
    });
  }

  void cancelRe() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance.collection("AllUsers").doc(user.uid).update({
      'addfri': FieldValue.arrayRemove([widget.id])
    });
    FirebaseFirestore.instance.collection("AllUsers").doc(uid).update({
      'reFri': FieldValue.arrayRemove([myid])
    });
    print(widget.id);
    print(widget.uid);
    print(myid);
  }

  void checkListWithId() {
    for (int i = 0; i < getmyfri.length; i++) {
      if (widget.id == getmyfri[i].toString()) {
        setState(() {
          action = "Friend";
        });
      }
      print(action + "checkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
      //break;
    }
    for (int j = 0; j < getmyrefri.length; j++) {
      if (widget.id == getmyrefri[j].toString()) {
        setState(() {
          action = "re";
        });
      }
    }
    for (int a = 0; a < getmyaddfri.length; a++) {
      if (widget.id == getmyaddfri[a].toString()) {
        setState(() {
          action = "add";
        });
      }
    }
  }

  void Confirm() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance.collection("AllUsers").doc(user.uid).update({
      'reFri': FieldValue.arrayRemove([widget.id])
    });
    FirebaseFirestore.instance.collection("AllUsers").doc(widget.uid).update({
      'addfri': FieldValue.arrayRemove([myid])
    });
  }

  @override
  void initState() {
    // load();
    TransferUserList();
    getMyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("AllUsers")
                      .where('id'.toString(), isEqualTo: widget.id)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: snapshot.data!.docs.map((doc) {
                          return Column(
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
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 10))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(doc['url']))),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                doc['Username'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: bold,
                                    color: mainColorRed),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width - 130,
                                  height: 40,
                                  child: isAdd == false
                                      ? Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: InkWell(
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: mainColorBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Add Friend",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: white),
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  getmyaddfri.add(widget.id);
                                                  kerefri.add(myid);
                                                  AddFriend();
                                                  isAdd = true;
                                                  print(uid);
                                                  print(myid);
                                                  print(user.uid);
                                                  print(getmyaddfri);
                                                  print(widget.uid);
                                                  print(uid);
                                                  print(kerefri);
                                                });
                                              },
                                            )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: mainColorRed,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                "History",
                                                style: TextStyle(
                                                    fontSize: 18, color: white),
                                              ),
                                            ))
                                          ],
                                        )
                                      : Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: InkWell(
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: mainColorBlue,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  "Cancel Request",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: white),
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  print(widget.id);
                                                  print(widget.uid);
                                                  print(myid);
                                                  cancelRe();
                                                  isAdd = false;
                                                });
                                              },
                                            )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.center,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: mainColorRed,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Text(
                                                "History",
                                                style: TextStyle(
                                                    fontSize: 18, color: white),
                                              ),
                                            ))
                                          ],
                                        )),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
