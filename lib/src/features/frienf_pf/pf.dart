import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecam/src/utils/app_con.dart';


class ProfileFriend extends StatefulWidget {
  //const ProfileFriend({ Key? key }) : super(key: key);
  final String id;
  ProfileFriend(this.id);

  @override
  State<ProfileFriend> createState() => _ProfileFriendState();
}

class _ProfileFriendState extends State<ProfileFriend> {
  final User user = FirebaseAuth.instance.currentUser!;
  var _firebaseInstance = FirebaseFirestore.instance;
  var fri = [];
  var myfri = [];
  var getSOS = [];
  String check = '0';
  String id = "";
  String friid = "";

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
            getSOS = doc['SOS'];
          });
        }
      });
    });
  }

  void checkSOS() async {
    if (getSOS != null) {
      setState(() {
        check = "1";
      });
    }
  }

  void showFri() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        for (int i = 0; i < fri.length; i++) {
          if (fri[i] == doc['id']) {
            myfri.add({
              "url": doc['url'],
              "Username": doc['Username'],
              "Phonenumber": doc['Phonenumber']
            });
            print(myfri);
          }
        }
      });
    });
  }

  @override
  void initState() {
    getreFriList();
    print("Friend");
    showFri();
    checkSOS();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     shrinkWrap: true,
    //     scrollDirection: Axis.vertical,
    //     itemCount: myfri.length,
    //     itemBuilder: (_, index) {
    //       return Container(
    //         //color: Colors.white,
    //         padding: EdgeInsets.only(top: 5),
    //         child: Column(
    //           children: [
    //             Center(
    //               child: Stack(
    //                 children: [
    //                   Container(
    //                     width: 115,
    //                     height: 115,
    //                     decoration: BoxDecoration(
    //                         border: Border.all(
    //                             width: 4,
    //                             color:
    //                                 Theme.of(context).scaffoldBackgroundColor),
    //                         boxShadow: [
    //                           BoxShadow(
    //                               spreadRadius: 2,
    //                               blurRadius: 10,
    //                               color: Colors.black.withOpacity(0.1),
    //                               offset: Offset(0, 10))
    //                         ],
    //                         shape: BoxShape.circle,
    //                         image: DecorationImage(
    //                             fit: BoxFit.cover, image: NetworkImage(myfri[index]['url']))),
    //                   ),

    //                 ],
    //               ),
    //             ),
    //             SizedBox(height: 10,),
    //             Text(myfri[])
    //           ],
    //         ),
    //       );
    //     });
    return StreamBuilder(
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
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
                                image: NetworkImage(doc['url']))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      doc['Username'],
                      style: TextStyle(
                          fontSize: 20, fontWeight: bold, color: mainColorRed),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 44,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            alignment: Alignment.center,
                            height: 45,
                            decoration: BoxDecoration(
                              color: mainColorBlue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Friend",
                              style: TextStyle(color: white, fontSize: 18),
                            ),
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Container(
                            alignment: Alignment.center,
                            height: 45,
                            decoration: BoxDecoration(
                              color: mainColorRed,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "History",
                              style: TextStyle(color: white, fontSize: 18),
                            ),
                          )),
                        ],
                      ),
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
        });
  }
}
