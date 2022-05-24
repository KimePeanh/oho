import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onecam/src/utils/app_con.dart';


class UserEdit extends StatefulWidget {
  const UserEdit({Key? key}) : super(key: key);

  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  String url = "";
  String name = "";
  String email = "";
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
            //id = doc["id"];
            //print(id);
            print(url);
          });
        }
      });
    });
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColorRed,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text("Change Passwords"),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
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
                                fit: BoxFit.cover, image: NetworkImage(url))),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: mainColorRed,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                            fontSize: 22,
                            color: mainColorRed,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        email,
                        style: TextStyle(
                            fontSize: 14,
                            color: mainColorRed,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                // buildTextField("Full Name", "Suos Sreylen", false),
                // buildTextField("E-mail", "sreylensuos23@gmail.com", false),
                buildTextField("Current Password", "*******", true),
                buildTextField("Password", "****", true),
                buildTextField("Confirm New Password", "****", true),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
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
                          "Save Now",
                          style: TextStyle(
                              color: white, fontWeight: bold, fontSize: 18),
                        ),
                      ),
                      onTap: () {},
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: mainColorRed,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
