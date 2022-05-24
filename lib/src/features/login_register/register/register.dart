import 'package:flutter/material.dart';
import 'package:onecam/src/utils/app_con.dart';

import 'register_form.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      width: 150,
                      height: 150,
                      child: Image(
                        image: AssetImage("assets/images/logo.png"),
                      ),
                    )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text(
                      "What's Your Name ?",
                      style: TextStyle(color: Blue),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RegisterForm(),      
                  
                  InkWell(
                    child: Text(
                      "Already have an account",
                      style: TextStyle(color: grey, fontWeight: bold),
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
