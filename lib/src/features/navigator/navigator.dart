
import 'package:flutter/material.dart';
import 'package:onecam/src/features/friend/Friend_Screen.dart';
import 'package:onecam/src/features/home/home.dart';
import 'package:onecam/src/features/notificaation/notificationScreen.dart';
import 'package:onecam/src/features/setting/ui_settings.dart';
import 'package:onecam/src/utils/app_con.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNav extends StatefulWidget {
  //const BottomNav({Key? key}) : super(key: key);
  

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _page = 2;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

   final List<Widget> Goto = [
    Container(),
    FriendScreen(),
    HomeScreen(),
    NotificationScreen(),
    SettingPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Goto[_page],
      bottomNavigationBar: CurvedNavigationBar(
      index: _page,
      height: 70,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Colors.transparent,
      items: <Widget>[
        Icon(
          Icons.home,
          size: 30,
          color: Red,
        ),
        Icon(
          Icons.people_alt_rounded,
          size: 30,
          color:  Red,
        ),
        Container(
          width: 50,
          height: 50,
          child: CircleAvatar(
            backgroundColor:  Red,
            child: Text(
              "SOS",
              style: TextStyle(color: white),
            ),
          ),
        ),
        Icon(
          Icons.notifications,
          size: 30,
          color: Red,
        ),
        Icon(
          Icons.menu,
          size: 30,
          color: Red,
        ),
      ],
      onTap: _onItemTapped,
    ),
    );

    
  }
}
