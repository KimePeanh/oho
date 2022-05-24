import 'package:flutter/material.dart';
import 'package:onecam/src/features/login_register/method.dart';
import 'package:onecam/src/shared/shared_widget.dart';
import 'package:onecam/src/utils/app_con.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late GlobalKey<FormState> _key = GlobalKey<FormState>();
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController passController = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController BDController = TextEditingController();
  String? gender;
  Color femaleClick = Colors.transparent;
  Color femaleText = Red;
  Color maleClick = Colors.transparent;
  Color maleText = Blue;
  Method method = Method("signup");

  void checkgender() {
    if (gender == "Female") {
      setState(() {
        gender = "Female";
        femaleClick = Red;
        femaleText = Colors.white;
        maleClick = Colors.transparent;
        maleText = Blue;
      });
    } else if (gender == "Male") {
      maleClick = Blue;
      maleText = white;
      femaleClick = Colors.transparent;
      femaleText = Red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 44,
                      color: Colors.grey.shade100,
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: InputDecoration(
                            hintText: "First name",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 44,
                      color: Colors.grey.shade100,
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                            hintText: "Last name",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Colors.grey.shade400)),
                            enabledBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0)),
                      ),
                    ),
                  ),
                ],
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
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    prefixIcon: Container(
                      width: 70,
                      height: 44,
                      alignment: Alignment.center,
                      child: Text(
                        "+855",
                        style: TextStyle(color: grey),
                      ),
                    ),
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
                controller: BDController,
                decoration: InputDecoration(
                    hintText: "YYYY-MM-DD",
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
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: Colors.grey.shade400)),
                    enabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0)),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                "Please use your real name to make it easier for next time to recognize you.",
                style: TextStyle(color: grey),
                textAlign: TextAlign.center,
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
                        border: Border.all(color: Red),
                        borderRadius: BorderRadius.circular(8),
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
                        border: Border.all(color: Blue),
                        borderRadius: BorderRadius.circular(8),
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
              height: 50,
            ),
            InkWell(
              child: logButton(context, "Next"),
              onTap: () async {
                method.sendOTP(context,
                    phone: phoneController.text,
                    fname: firstNameController.text,
                    lname: lastNameController.text,
                    pw: passController.text,
                    sex: gender!,
                    dob: BDController.text);
              },
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
