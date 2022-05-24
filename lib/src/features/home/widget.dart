import 'package:flutter/cupertino.dart';
import 'package:onecam/src/utils/app_con.dart';

Widget btn(BuildContext context, String image, String title) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: white,
        border: Border.all(color: mainColorRed.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: mainColorRed.withOpacity(0.1),
            offset: Offset(2, 2),
            blurRadius: 10,
          ),
          BoxShadow(
            color: white,
            offset: -Offset(2, 2),
            blurRadius: 10,
          )
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
            child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Image(
            image: AssetImage(image),
          ),
        )),
        Text(
          title,
          style: TextStyle(color: mainColorRed, fontWeight: bold),
          textScaleFactor: 1.2,
        )
      ],
    ),
  );
}
