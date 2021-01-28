import 'package:flutter/material.dart';
import 'package:m2m_coin/constants.dart';
import 'package:m2m_coin/graph/graph_screen.dart';
import 'package:m2m_coin/home/home_screen.dart';
import 'package:m2m_coin/info/info_screen.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  //ตัวแปล
  int currentIndex = 0;

  final tabsWidget = [
    HomeScreen(),
    GraphScreen(),
    InfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: tabsWidget[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -10),
              blurRadius: 35,
              color: kPrimaryColor.withOpacity(0.38),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: unselecColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: size.width * 0.06),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timeline, size: size.width * 0.06),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info, size: size.width * 0.06),
              title: Text(''),
            ),
          ],
        ),
      ),
    );
  }
}
