import 'package:flutter/material.dart';
import 'package:onecam/app_localiztion.dart';
import 'package:onecam/src/features/language/screen/languages.dart';
import 'package:onecam/src/features/login_register/login/screen/login_form.dart';
import 'package:onecam/src/features/login_register/register/register.dart';
import 'package:onecam/src/shared/shared_widget.dart';
import 'package:onecam/src/utils/app_con.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                children: <Widget>[
                  SafeArea(
                    child: AspectRatio(
                      aspectRatio: 16 / 6,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width - 80,
                        height: 160,
                        child: Image(
                          image: AssetImage("assets/images/log.png"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: 20,
                      child: Text(
                        "Welcome to ONE CAM EMERGENCY...!",
                        style: TextStyle(
                            color: Red, fontSize: 18, fontWeight: bold),
                      )),
                  //Spacer(),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text(
                      "Please Sign in or Sign up to continue",
                      style: TextStyle(color: Blue),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  LoginForm(),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "-Sign up with-",
                    style: TextStyle(color: grey),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Flexible(
                      child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                            child: SignButton("assets/images/facebook.png")),
                        Flexible(child: SignButton("assets/images/google.png")),
                        Flexible(child: SignButton("assets/images/apple.png")),
                      ],
                    ),
                  )),
                  Spacer(
                    flex: 1,
                  ),
                  InkWell(
                    child: Text(
                      AppLocalizations.of(context)!
                          .translate("don't have acc")!,
                      style: TextStyle(color: grey, fontWeight: bold),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                      //languageModal(context);
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
