
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onecam/app_localiztion.dart';
import 'package:onecam/src/features/login_register/method.dart';
import 'package:onecam/src/shared/shared_widget.dart';
import 'package:onecam/src/utils/app_con.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController passController = TextEditingController();
  String verificationId = "";
  Method method = Method("login");
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 44,
              color: Colors.grey.shade100,
              child: TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.translate('email')!,
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.grey.shade400)),
                    enabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 44,
              color: Colors.grey.shade100,
              child: TextFormField(
                controller: passController,
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.translate('pass')!,
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.grey.shade400)),
                    enabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0)),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: MediaQuery.of(context).size.width - 50,
              child: Text(
                AppLocalizations.of(context)!.translate('forget')!,
                style: TextStyle(color: grey),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              child: logButton(context, AppLocalizations.of(context)!.translate('Login')!),
              onTap: () {
                FirebaseFirestore.instance
                    .collection('AllUsers')
                    .get()
                    .then((QuerySnapshot querySnapshot) {
                  querySnapshot.docs.forEach((doc) async {
                    if (doc["Phonenumber"] == "+855" + phoneController.text &&
                        doc["password"] == passController.text) {
                      print("hii");
                      method.sendOTP(context,
                          phone: phoneController.text,
                          fname: "fname",
                          lname: "lname",
                          pw: "pw",
                          sex: "sex",
                          dob: "dob");
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => HomeScreen()));
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => BottomNav()));
                    } else {
                      // print("failllllllllllllllll");
                      // Fluttertoast.showToast(msg: "Failll");
                    }
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
