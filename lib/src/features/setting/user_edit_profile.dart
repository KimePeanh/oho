import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onecam/src/shared/shared_widget.dart';
import 'package:onecam/src/utils/app_con.dart';

import 'package:path/path.dart';

// class ProfileUser extends StatefulWidget {
//   const ProfileUser({Key? key}) : super(key: key);

//   @override
//   _ProfileUserState createState() => _ProfileUserState();
// }

// class _ProfileUserState extends State<ProfileUser> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: mainColorRed,
//         toolbarHeight: 100,
//         elevation: 1,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20))),
//         // leading: IconButton(
//         //   onPressed: () {
//         //     Navigator.of(context).pop();
//         //   },
//         //   icon: Icon(
//         //     Icons.arrow_back,
//         //     color: Colors.white,
//         //   ),
//         // ),
//         title: Padding(
//           padding: const EdgeInsets.only(top: 40),
//           child: Text("Edit User Profile"),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: EdgeInsets.only(left: 16, top: 25, right: 16),
//         child: ListView(
//           children: [
//             Center(
//               child: Stack(
//                 children: [
//                   Container(
//                     width: 100,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                           width: 4,
//                           color: Theme.of(context).scaffoldBackgroundColor),
//                       boxShadow: [
//                         BoxShadow(
//                             spreadRadius: 2,
//                             blurRadius: 10,
//                             color: Colors.black.withOpacity(0.1),
//                             offset: Offset(0, 10)),
//                       ],
//                       shape: BoxShape.circle,
//                       // image: DecorationImage(
//                       //     fit: BoxFit.cover,
//                       //     image: NetworkImage(
//                       //         "https://www.pexels.com/photo/woman-crouching-and-looking-at-camera-9921260/")
//                       //         )
//                     ),
//                   ),
//                   Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: 30,
//                         width: 30,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(
//                             width: 2,
//                             color: Theme.of(context).scaffoldBackgroundColor,
//                           ),
//                           color: mainColorRed,
//                         ),
//                         child: Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                       )),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Suos Sreylen",
//                     style: TextStyle(
//                         fontSize: 22,
//                         color: mainColorRed,
//                         fontWeight: FontWeight.w800),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "sreylensuos23@gmail.com",
//                     style: TextStyle(
//                         fontSize: 14,
//                         color: mainColorRed,
//                         fontWeight: FontWeight.w400),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 35,
//             ),
//             Container(
//               width: MediaQuery.of(context).size.width - 30,
//               child: Text(
//                 "Account",
//                 style: TextStyle(color: mainColorRed),
//               ),
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   labelText: "Full Name",
//                   floatingLabelBehavior: FloatingLabelBehavior.always,
//                   hintText: "Suos Sreylen",
//                   hintStyle: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   )),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                   labelText: "Date of Birth",
//                   floatingLabelBehavior: FloatingLabelBehavior.always,
//                   hintText: "01/01/2001",
//                   hintStyle: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   )),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Column(
//               children: <Widget>[
//                 Container(
//                   child: Text(
//                     'Gender',
//                     style:
//                         TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Builder(builder: (context) {
//                       return Container(
//                         margin: const EdgeInsets.symmetric(vertical: 40),
//                         alignment: Alignment.center,
//                         child: GenderPickerWithImage(
//                           showOtherGender: false,
//                           verticalAlignedText: false,

//                           // to show what's selected on app opens, but by default it's Male
//                           selectedGender: Gender.Male,
//                           selectedGenderTextStyle: TextStyle(
//                               color: Color(0xFF8b32a8),
//                               fontWeight: FontWeight.bold),
//                           unSelectedGenderTextStyle: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.normal),
//                           onChanged: (Gender? _gender) {
//                             print(_gender);
//                           },
//                           //Alignment between icons
//                           equallyAligned: true,

//                           animationDuration: Duration(milliseconds: 300),
//                           isCircular: true,
//                           // default : true,
//                           opacityOfGradient: 0.4,
//                           padding: const EdgeInsets.all(3),
//                           size: 50, //default : 40
//                         ),
//                       );
//                     }),
//                   ],
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 RaisedButton(
//                     padding: EdgeInsets.symmetric(horizontal: 50),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     onPressed: () {},
//                     color: mainColorRed,
//                     child: Text(
//                       "SAVE",
//                       style: TextStyle(fontSize: 16, color: Colors.white),
//                     ))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class EditPfScreen extends StatefulWidget {
  const EditPfScreen({Key? key}) : super(key: key);

  @override
  _EditPfScreenState createState() => _EditPfScreenState();
}

class _EditPfScreenState extends State<EditPfScreen> {
  TextEditingController firstnameCon = TextEditingController();
  TextEditingController lastnameCon = TextEditingController();
  TextEditingController DOBCon = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;
  String username = "Sous Sreylen";
  String dateofB = "YYYY-MM-DD";
  //String? url;
  //String email = "sreylensuos23@gmail.com";
  String? gender;
  Color femaleClick = Colors.transparent;
  Color femaleText = mainColorRed;
  Color maleClick = Colors.transparent;
  Color maleText = mainColorBlue;
  Color hintDate = mainColorRed;
  String url = "";
  String name = "";
  String email = "";
  String globalUid = "";
  String Myuid = "";
  String updateUrl = " ";
  var _firebaseInstance = FirebaseFirestore.instance;
  late final DocumentSnapshot userdata;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    //final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance.ref().child(globalUid);
      await ref.putFile(_photo!);
      var dowurl = await ref.getDownloadURL();
      setState(() {
        updateUrl = dowurl;
        updateurl();
      });
    } catch (e) {
      print('error occured');
    }
  }

  void updateurl() async {
    QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
    FirebaseFirestore.instance
        .collection("AllUsers")
        .doc(globalUid)
        .update({'url': updateUrl});
  }

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
            Myuid = doc["uid"];
            name = doc["Username"];
            url = doc["url"];
            email = doc["Phonenumber"];
            globalUid = doc["uid"];
            //id = doc["id"];
            //print(id);
            print(url);
          });
        }
      });
    });
  }

  void checkgender() {
    if (gender == "Female") {
      setState(() {
        gender = "Female";
        femaleClick = mainColorRed;
        femaleText = Colors.white;
        maleClick = Colors.transparent;
        maleText = mainColorBlue;
      });
    } else if (gender == "Male") {
      maleClick = mainColorBlue;
      maleText = white;
      femaleClick = Colors.transparent;
      femaleText = mainColorRed;
    }
  }

  void update() async {
    if (firstnameCon.text != null && lastnameCon.text != null) {
      QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
      FirebaseFirestore.instance
          .collection("AllUsers")
          .doc(globalUid)
          .update({'Username': firstnameCon.text + " " + lastnameCon.text});
    }
  }

  void updateDOB() async {
    if (DOBCon.text != null) {
      QuerySnapshot qn = await _firebaseInstance.collection("AllUsers").get();
      FirebaseFirestore.instance
          .collection("AllUsers")
          .doc(globalUid)
          .update({'date_bd': DOBCon.text});
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: mainColorRed,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        elevation: 1,
        title: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Text(
            "Edit Profile",
            style: TextStyle(fontWeight: bold, fontSize: 20),
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("AllUsers")
              .where('uid', isEqualTo: globalUid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        children: snapshot.data!.docs.map((doc) {
                          return Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Stack(
                                children: [
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: Offset(0, 10)),
                                        ],
                                        //shape: BoxShape.circle,
                                        // image: DecorationImage(
                                        //     fit: BoxFit.cover,
                                        //     image: NetworkImage(doc['url']),
                                        //     )
                                      ),
                                      child: _photo != null
                                          ? CircleAvatar(
                                              // borderRadius:
                                              //     BorderRadius.circular(50)
                                              child: Image.file(
                                                _photo!,
                                                // width: 100,
                                                //height: 100,
                                                //fit: BoxFit.fitHeight,
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  white.withOpacity(0.3),
                                              // borderRadius:
                                              //     BorderRadius.circular(50),
                                              child: Image.network(
                                                doc['url'],
                                                //width: 100,
                                                //height: 100,
                                                //fit: BoxFit.fitHeight,
                                              ),
                                            )),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                            ),
                                            color: mainColorRed,
                                          ),
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        onTap: () {
                                          _showPicker(context);
                                        },
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                doc['Username'],
                                style: TextStyle(
                                    fontSize: 22,
                                    color: mainColorRed,
                                    fontWeight: FontWeight.w800),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                doc['Phonenumber'],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: mainColorRed,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Text(
                                  "Account",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: mainColorRed,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                //height: 40,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: fnameform(),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: lnameform(),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: DOBform(),
                                    ),
                                    InkWell(
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: mainColorRed,
                                        ),
                                      ),
                                      onTap: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime(1900, 3, 5),
                                            maxTime: DateTime(2022, 6, 7),
                                            theme: DatePickerTheme(
                                                headerColor: mainColorRed,
                                                backgroundColor: white,
                                                itemStyle: TextStyle(
                                                    color: mainColorBlue,
                                                    //fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                                doneStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16)),
                                            onChanged: (date) {
                                          print('change $date in time zone ' +
                                              date.timeZoneOffset.inHours
                                                  .toString());
                                        }, onConfirm: (date) {
                                          print('confirm $date');
                                          setState(() {
                                            dateofB = date
                                                .toString()
                                                .substring(0, 11);
                                            hintDate = Colors.black;
                                          });
                                        },
                                            currentTime: DateTime.now(),
                                            locale: LocaleType.en);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width - 80,
                                height: 49,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: InkWell(
                                      child: Container(
                                        height: 49,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: mainColorRed),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: femaleClick,
                                        ),
                                        child: Text(
                                          "Female",
                                          style: TextStyle(
                                            color: femaleText,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          gender = "Female";
                                          checkgender();
                                        });
                                      },
                                    )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: InkWell(
                                      child: Container(
                                        height: 49,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: maleClick,
                                          border:
                                              Border.all(color: mainColorBlue),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "Male",
                                          style: TextStyle(color: maleText),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          gender = "Male";
                                          print(gender);
                                          checkgender();
                                        });
                                      },
                                    )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 80,
                              ),
                              InkWell(
                                child: logButton(context, "Save Now"),
                                onTap: () {
                                  update();
                                  updateDOB();
                                },
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget fnameform() {
    return Container(
      child: TextFormField(
        controller: firstnameCon,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.only(left: 10),
          hintText: "first name",
          hintStyle: TextStyle(color: mainColorRed, fontSize: 15),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: mainColorRed),
          ),
        ),
      ),
    );
  }

  Widget lnameform() {
    return Container(
      child: TextFormField(
        controller: lastnameCon,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.only(left: 10),
          hintText: "last name",
          hintStyle: TextStyle(color: mainColorRed, fontSize: 15),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: mainColorRed),
          ),
        ),
      ),
    );
  }

  Widget DOBform() {
    return Container(
      child: TextFormField(
        controller: DOBCon,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.only(left: 10),
          hintText: dateofB,
          hintStyle: TextStyle(color: hintDate, fontSize: 15),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: mainColorRed),
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
