import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onecam/src/shared/shared_widget.dart';
import 'package:onecam/src/utils/app_con.dart';


import '../../../main.dart';
import 'button_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: <Widget>[
            SafeArea(child: Appbar(context, "SOS")),
            SizedBox(
              height: 50,
            ),
            Text(
              "Urgent Emergency",
              style: TextStyle(
                  color: mainColorBlue, fontSize: 20, fontWeight: bold),
            ),
            ButtonHome(),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
                color: Colors.blue,
                onPressed: () {
                  print("here");
                 
                },
                child: Text("Subscribe"))
          ],
        ),
      )),
      //bottomNavigationBar: BottomNav(),
    );
  }
}
