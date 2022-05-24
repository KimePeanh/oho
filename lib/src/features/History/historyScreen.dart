import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:onecam/src/utils/app_con.dart';


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final database = FirebaseDatabase.instance.ref();
  var _firebaseInstance = FirebaseFirestore.instance;
  int a = 0;
  String lat = "";
  String lng = '';
  String date = "";
  String time = "";
  var hi = [];
  String url = "";
  String myname = "";
  var getSOSlist = [];
  var getHelpList = [];
  var getMyHelp = [];
  String username = "";
  final User user = FirebaseAuth.instance.currentUser!;
  void getData() async {
    database.child(user.uid).child("Count").once().then((DataSnapshot) {
      setState(() {
        a = DataSnapshot.snapshot.value as int;
        for (int i = 1; i <= a; i++) {
          database.child(user.uid).child('${i}').once().then((value) {
            print(value.snapshot.value.toString());
            setState(() {
              hi.add(value.snapshot.value);
              print(hi);
            });
          });
        }
      });
    });
    //  database.child(user.uid).child("2").once().then((value) {
    //   print(value.snapshot.value.toString());
    // });
  }

  void getMyData() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection('AllUsers')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == user.uid) {
          setState(() {
            url = doc['url'];
            myname = doc['Username'];
          });
        }
      });
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
            getSOSlist = doc['SOS'];
            getHelpList = doc['HelpList'];
            getMyHelp = doc['MyHelp'];
            username = doc['Username'];
            print(getHelpList);
            print(getMyHelp);
          });
        }
      });
    });
  }

  var g = [];
  void getEachData() {
    for (int i = 0; i < hi.length; i++) {
      print(hi[0]);
      //g.add({'lat': hi[0]});

      setState(() {
        g.add(hi[0]);
      });
    }
  }

  //void getAllData
  @override
  void initState() {
    getData();
    getMyList();
    //getEachData();
    getMyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColorRed,
        toolbarHeight: 100,
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        title: Text(
          "History",
          style: TextStyle(fontSize: 25, fontWeight: bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                  child: getSOSlist.length != 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: getSOSlist.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  bottom: 12, left: 10, right: 10),
                              height: 85,
                              //width: MediaQuery.of(context).size.width - 20,
                              decoration: BoxDecoration(
                                  color: Color(0xffABB7C3).withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 90,
                                    height: 85,
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      //padding: EdgeInsets.all(30),
                                      //color: mainColorRed,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(url)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            getSOSlist[index]['date']
                                                .toString(),
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 18,
                                                fontWeight: bold),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${username} requested assistance from a Firend.",
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            getSOSlist[index]['time']
                                                .toString(),
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 18,
                                                fontWeight: bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                  Container(
                                    width: 40,
                                    height: 85,
                                    child: Icon(
                                      Icons.more_horiz,
                                      color: white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                      : Container()),
              Container(
                child: getHelpList.length != 0
                    ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: getHelpList.length,
                        itemBuilder: (context, index) {
                          return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("AllUsers")
                                  .where('uid',
                                      isEqualTo: getHelpList[index]['uid'])
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: snapshot.data!.docs.map((doc) {
                                      return Container(
                                        margin: EdgeInsets.only(
                                            bottom: 12, left: 10, right: 10),
                                        height: 85,
                                        //width: MediaQuery.of(context).size.width - 20,
                                        decoration: BoxDecoration(
                                            color: Color(0xffABB7C3)
                                                .withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 90,
                                              height: 85,
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: 70,
                                                height: 70,
                                                //padding: EdgeInsets.all(30),
                                                //color: mainColorRed,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          doc['url'])),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                                child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "",
                                                      // getHelpList[index]['date'].toString(),
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 18,
                                                          fontWeight: bold),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      
                                                     " ${doc['Username']} helped you.",
                                                      style: TextStyle(
                                                        color: white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "",
                                                      style: TextStyle(
                                                          color: white,
                                                          fontSize: 18,
                                                          fontWeight: bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                            Container(
                                              width: 40,
                                              height: 85,
                                              child: Icon(
                                                Icons.more_horiz,
                                                color: white,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  );
                                } else {
                                  return Center();
                                }
                              });
                        })
                    : Container(),
              ),
              Container(
                  child: getMyHelp.length != 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: getMyHelp.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  bottom: 12, left: 10, right: 10),
                              height: 85,
                              //width: MediaQuery.of(context).size.width - 20,
                              decoration: BoxDecoration(
                                  color: Color(0xffABB7C3).withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 90,
                                    height: 85,
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      //padding: EdgeInsets.all(30),
                                      //color: mainColorRed,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // image: DecorationImage(
                                        //     fit: BoxFit.cover,
                                        //     image: NetworkImage(keUrl)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "getMyHelp[index]['date'].toString()",
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 18,
                                                fontWeight: bold),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "You Help",
                                            style: TextStyle(
                                              color: white,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            getMyHelp[index]['time'].toString(),
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 18,
                                                fontWeight: bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                  Container(
                                    width: 40,
                                    height: 85,
                                    child: Icon(
                                      Icons.more_horiz,
                                      color: white,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          })
                      : Container()),
            ],
          ),
        ),
      ),
    );
  }
}
