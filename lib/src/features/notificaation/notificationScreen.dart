import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecam/src/features/frienf_pf/FriendScreen.dart';
import 'package:onecam/src/utils/app_con.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var _firebaseInstance = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User user = FirebaseAuth.instance.currentUser!;
  var notiId = [];
  var notiurl = [];
  var notiname = [];
  var notuid = [];
  var getmyNoti = [];
  var initmyNoti = [];
  getDetail() async {
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['uid'] == user.uid) {
          setState(() {
            initmyNoti = doc['noti'];
            print(initmyNoti);
            print("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
            for (int i = 0; i < initmyNoti.length; i++) {
              notuid.add(initmyNoti[i]['uid']);
              print(notuid);
              print("Okkkkkkkkkkkkkkkkkkkk");
            }
          });
        }
      });
    });
    getId();
  }

  getId() async {
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        for (int j = 0; j < notuid.length; j++) {
          if (doc['uid'] == notuid[j]) {
            setState(() {
              notiId.add(doc['id']);
              notiurl.add(doc['url']);
              notiname.add(doc['Username']);
              print(notiId);
              print("MAMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
            });
          }
        }
      });
    });
  }

  @override
  void initState() {
    getDetail();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColorRed,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: white,
            ),
            onPressed: () {},
          ),
          title: Text("Notification"),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("AllUsers")
              .where('uid', isEqualTo: user.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              getmyNoti = snapshot.data!.docs[0].get('noti');
              print(getmyNoti.toString());
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: getmyNoti.length != 0
                            ? ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: getmyNoti.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: Container(
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
                                                        notiurl[index])),
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
                                                    getmyNoti[index]['date']
                                                        .toString(),
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
                                                    " requested assistance from a Firend.",
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
                                                    getmyNoti[index]['time']
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
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FriendProfileScreen(
                                                      'fri',
                                                      notiId[index],
                                                      notiname[index],
                                                      getmyNoti[index]['uid'],
                                                      notiurl[index])));
                                    },
                                  );
                                })
                            : Container(),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
