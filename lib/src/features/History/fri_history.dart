import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecam/src/utils/app_con.dart';

class FriHistory extends StatefulWidget {
  final String uid;
  FriHistory(this.uid);

  @override
  State<FriHistory> createState() => _FriHistoryState();
}

class _FriHistoryState extends State<FriHistory> {
  String keUrl = "";
  // final User user = FirebaseAuth.instance.currentUser!;
  var _firebaseInstance = FirebaseFirestore.instance;
  var getSOSlist = [];
  var getHelpList = [];
  var getMyHelp = [];
  String username = "";
  void getMyList() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection('AllUsers')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == widget.uid) {
          setState(() {
            getSOSlist = doc['SOS'];
            getHelpList = doc['HelpList'];
            getMyHelp = doc['MyHelp'];
            keUrl = doc['url'];
            username = doc['Username'];
          });
        }
      });
    });
  }

  @override
  void initState() {
    print(widget.uid);
    //getCurrentUser();
    getMyList();
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
                                            image: NetworkImage(keUrl)),
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
                                          image: NetworkImage(
                                              getHelpList[index]['url'])),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          getHelpList[index]['date'].toString(),
                                          style: TextStyle(
                                              color: white,
                                              fontSize: 18,
                                              fontWeight: bold),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${getHelpList[index]['name'].toString()} helped ${username}.",
                                          style: TextStyle(
                                            color: white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          getHelpList[index]['time'].toString(),
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
                                            getMyHelp[index]['date'].toString(),
                                            style: TextStyle(
                                                color: white,
                                                fontSize: 18,
                                                fontWeight: bold),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            " requested assistance from a Firend.",
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
