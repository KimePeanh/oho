import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onecam/src/utils/app_con.dart';

Widget SignButton(String iamgepath) {
  return Container(
    width: 88,
    height: 41,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0, 2),
          )
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 27,
          height: 27,
          child: Image(
            fit: BoxFit.contain,
            image: AssetImage(iamgepath),
          ),
        ),
      ],
    ),
  );
}

Widget logButton(BuildContext context, String nameButton) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width - 100,
    height: 52,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Red,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0, 2),
          )
        ]),
    child: Text(
      nameButton,
      style: TextStyle(color: white),
    ),
  );
}
Widget Appbar(BuildContext context, String title) {
  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height: 100,
    decoration: BoxDecoration(
        color: mainColorRed,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
    child: Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          Container(
            width: 70,
          ),
          Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width - 140,
              child: Text(
                title,
                style: TextStyle(fontWeight: bold, fontSize: 20, color: white),
              )),
          InkWell(
            child: Container(
              width: 70,
              child: Icon(
                Icons.search,
                color: white,
                size: 30,
              ),
            ),
            onTap: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          )
        ],
      ),
    ),
  );
}