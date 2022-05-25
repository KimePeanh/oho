import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onecam/app_localiztion.dart';
import 'package:onecam/src/features/language/screen/languages.dart';
import 'package:onecam/src/features/login_register/login/screen/loginscreen.dart';
import 'package:onecam/src/features/my_profile/MyProfileScreen.dart';
import 'package:onecam/src/utils/app_con.dart';
import 'change_pass.dart';
import 'user_edit_profile.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var actions;
  String url = "";
  String name = "";
  String email = "";
  String myuid = "";
  var _firebaseInstance = FirebaseFirestore.instance;
  late final DocumentSnapshot userdata;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  getCurrentUser() async {
    final User user = await _auth.currentUser!;
    final uid = user.uid;
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc["uid"] == uid) {
          setState(() {
            name = doc["Username"];
            url = doc["url"];
            email = doc["Phonenumber"];
            myuid = user.uid;
            //id = doc["id"];
            //print(id);
            print(url);
          });
        }
      });
    });
  }

  var allID = [];
  void checkId() async {
    FirebaseFirestore.instance
        .collection("AllUsers")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        allID.add(doc['id']);
        print(allID);
      });
    });
  }

  @override
  void initState() {
    getCurrentUser();
    checkId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: color.AppColor.userbarColor,
    //     elevation: 1,
    //     leading: IconButton(
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //       icon: Icon(
    //         Icons.arrow_back,
    //         color: Colors.white,
    //       ),
    //     ),
    //     title: Text("Settings"),
    //     centerTitle: true,
    //   ),
    //   body: Container(
    //     padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
    //     margin: const EdgeInsets.only(left: 25, top: 25, right: 25),
    //     width: MediaQuery.of(context).size.width,
    //     height: 420,
    //     decoration: BoxDecoration(
    //         color: color.AppColor.userbarColor,
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(10),
    //             bottomLeft: Radius.circular(10),
    //             bottomRight: Radius.circular(10),
    //             topRight: Radius.circular(10))),
    //     child: ListView(
    //       children: [
    //         Row(
    //           children: [
    //             Icon(
    //               Icons.person,
    //               color: Colors.white,
    //             ),
    //             SizedBox(
    //               width: 8,
    //             ),
    //             Text(
    //               "Account",
    //               style: TextStyle(
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.white),
    //             )
    //           ],
    //         ),
    //         Divider(height: 15, thickness: 2, color: Colors.white),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               "About Us",
    //               style: TextStyle(
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.w500,
    //                 color: Colors.grey[900],
    //               ),
    //             ),
    //             Icon(
    //               Icons.arrow_forward_ios,
    //               color: Colors.grey,
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               "Contact Us",
    //               style: TextStyle(
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.w500,
    //                 color: Colors.grey[900],
    //               ),
    //             ),
    //             Icon(
    //               Icons.arrow_forward_ios,
    //               color: Colors.grey,
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               "Term and Conditions",
    //               style: TextStyle(
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.w500,
    //                 color: Colors.grey[900],
    //               ),
    //             ),
    //             Icon(
    //               Icons.arrow_forward_ios,
    //               color: Colors.grey,
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 30,
    //         ),
    //         Row(
    //           children: [
    //             Icon(
    //               Icons.verified_user_rounded,
    //               color: Colors.white,
    //             ),
    //             SizedBox(
    //               width: 8,
    //             ),
    //             Text(
    //               "User Setting",
    //               style: TextStyle(
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.white),
    //             )
    //           ],
    //         ),
    //         Divider(height: 15, thickness: 2, color: Colors.white),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               "Manage Friend List",
    //               style: TextStyle(
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.w500,
    //                 color: Colors.grey[900],
    //               ),
    //             ),
    //             Icon(
    //               Icons.arrow_forward_ios,
    //               color: Colors.grey,
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               "Change Passwords",
    //               style: TextStyle(
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.w500,
    //                 color: Colors.grey[900],
    //               ),
    //             ),
    //             IconButton(
    //               icon: Icon(
    //                 Icons.arrow_forward_ios,
    //                 color: Colors.grey,
    //               ),
    //               onPressed: () {
    //                 Navigator.of(context).push<void>(
    //                   MaterialPageRoute<void>(
    //                     builder: (BuildContext context) => const UserEdit(),
    //                   ),
    //                 );
    //               },
    //             ),
    //           ],
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               "Edit User Profile",
    //               style: TextStyle(
    //                 fontSize: 18,
    //                 fontWeight: FontWeight.w500,
    //                 color: Colors.grey[900],
    //               ),
    //             ),
    //             IconButton(
    //               icon: Icon(
    //                 Icons.arrow_forward_ios,
    //                 color: Colors.grey,
    //               ),
    //               onPressed: () {
    //                 Navigator.of(context).push<void>(
    //                   MaterialPageRoute<void>(
    //                     builder: (BuildContext context) => const ProfileUser(),
    //                   ),
    //                 );
    //               },
    //             ),
    //           ],
    //         ),

    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SafeArea(child: settingAppbar()),
              SizedBox(
                height: 30,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 15,
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 20),
                // height: 180,
                decoration: BoxDecoration(
                    color: mainColorRed,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        //padding: EdgeInsets.only(left: 15),
                        child: Text(
                          "User Setting",
                          style: TextStyle(
                              color: white, fontSize: 18, fontWeight: bold),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              AppLocalizations.of(context)!
                                  .translate("aboutus")!,
                              style: TextStyle(color: white, fontSize: 17),
                            )),
                            Expanded(
                                child: Container(
                              alignment: Alignment.centerRight,
                              //padding: EdgeInsets.only(right: 15),
                              child: Image(
                                  width: 20,
                                  height: 20,
                                  image:
                                      AssetImage("assets/images/info (1).png")),
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 1,
                          // padding: EdgeInsets.only(right: 15),
                          color: white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              AppLocalizations.of(context)!
                                  .translate("contactus")!,
                              style: TextStyle(color: white, fontSize: 17),
                            )),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    //padding: EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.call,
                                      color: white,
                                    )))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 1,
                          // padding: EdgeInsets.only(right: 15),
                          color: white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              AppLocalizations.of(context)!.translate("term")!,
                              style: TextStyle(color: white, fontSize: 17),
                            )),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    //padding: EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.add_box,
                                      color: white,
                                    )))
                          ],
                        ),
                        Container(
                          height: 1,
                          // padding: EdgeInsets.only(right: 15),
                          color: white,
                        ),
                      ],
                    ),
                    InkWell(
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  AppLocalizations.of(context)!
                                      .translate("lang")!,
                                  style: TextStyle(color: white, fontSize: 17),
                                )),
                                Expanded(
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        //padding: EdgeInsets.only(right: 15),
                                        child: Icon(
                                          Icons.call,
                                          color: white,
                                        )))
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 1,
                              // padding: EdgeInsets.only(right: 15),
                              color: white,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        languageModal(context);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 15,
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 10,
                  bottom: 10,
                ),
                //height: 180,
                decoration: BoxDecoration(
                    color: mainColorRed,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        //padding: EdgeInsets.only(left: 15),
                        child: Text(
                          AppLocalizations.of(context)!.translate("setting")!,
                          style: TextStyle(
                              color: white, fontSize: 18, fontWeight: bold),
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              AppLocalizations.of(context)!
                                  .translate("managefri")!,
                              style: TextStyle(color: white, fontSize: 17),
                            )),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    //padding: EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.person_add,
                                      color: white,
                                    )))
                          ],
                        ),
                        Container(
                          height: 1,
                          // padding: EdgeInsets.only(right: 15),
                          color: white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                AppLocalizations.of(context)!
                                    .translate("changepass")!,
                                style: TextStyle(color: white, fontSize: 17),
                              )),
                              Expanded(
                                  child: Container(
                                      alignment: Alignment.centerRight,
                                      //padding: EdgeInsets.only(right: 15),
                                      child: Icon(
                                        Icons.lock,
                                        color: white,
                                      )))
                            ],
                          ),
                          Container(
                            height: 1,
                            // padding: EdgeInsets.only(right: 15),
                            color: white,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserEdit()));
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 60, bottom: 20, right: 30),
        height: 42,
        child: InkWell(
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width - 80,
            height: 42,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: mainColorRed,
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.5),
                    offset: Offset(0, 1),
                  )
                ]),
            child: Text(
              AppLocalizations.of(context)!.translate("logout")!,
              style: TextStyle(color: white, fontWeight: bold, fontSize: 18),
            ),
          ),
          onTap: () {
            FirebaseAuth.instance.signOut().then((onValue) {
              Fluttertoast.showToast(msg: "Logout");
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            });
          },
        ),
      ),
    );
  }

  Widget settingAppbar() {
    // return Container(
    //   width: MediaQuery.of(context).size.width,
    //   padding: EdgeInsets.only(left: 15, right: 15, top: 20),
    //   height: 140,
    //   decoration: BoxDecoration(
    //       color: mainColorRed,
    //       borderRadius: BorderRadius.only(
    //           bottomLeft: Radius.circular(20),
    //           bottomRight: Radius.circular(20)
    //           )
    //           ),
    //   child: InkWell(
    //     child: Container(
    //       child: Row(
    //         children: <Widget>[
    //           Container(
    //             width: 70,
    //             height: 70,
    //             child: CircleAvatar(
    //               backgroundImage: NetworkImage(url),
    //               backgroundColor: mainColorRed,
    //             ),
    //           ),
    //           SizedBox(
    //             width: 10,
    //           ),
    //           Container(
    //             alignment: Alignment.centerLeft,
    //             width: MediaQuery.of(context).size.width - 135,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   name,
    //                   style: TextStyle(
    //                       fontSize: 20, fontWeight: bold, color: white),
    //                 ),
    //                 SizedBox(
    //                   height: 5,
    //                 ),
    //                 Text(
    //                   email,
    //                   style: TextStyle(color: white),
    //                 )
    //               ],
    //             ),
    //           ),
    //           InkWell(
    //               child: Container(
    //                   width: 25,
    //                   height: 25,
    //                   child: CircleAvatar(
    //                       backgroundColor: white,
    //                       child: Icon(
    //                         Icons.edit,
    //                         size: 18,
    //                         color: mainColorRed,
    //                       ))),
    //               onTap: () {
    //                 Navigator.push(
    //                     context,
    //                     MaterialPageRoute(
    //                         builder: (context) => EditPfScreen()));
    //               })
    //         ],
    //       ),
    //     ),
    //     onTap: () {
    //       Navigator.push(
    //           context, MaterialPageRoute(builder: (context) => MyPFScreen()));
    //     },
    //   ),
    // );

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("AllUsers")
            .where('uid', isEqualTo: myuid)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: snapshot.data!.docs.map((doc) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                  height: 140,
                  decoration: BoxDecoration(
                      color: mainColorRed,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: InkWell(
                    child: Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            height: 70,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(doc['url']),
                              backgroundColor: mainColorRed,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: MediaQuery.of(context).size.width - 135,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  doc['Username'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: bold,
                                      color: white),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  doc['Phonenumber'],
                                  style: TextStyle(color: white),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                              child: Container(
                                  width: 25,
                                  height: 25,
                                  child: CircleAvatar(
                                      backgroundColor: white,
                                      child: Icon(
                                        Icons.edit,
                                        size: 18,
                                        color: mainColorRed,
                                      ))),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditPfScreen()));
                              })
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyPFScreen()));
                    },
                  ),
                );
              }).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
