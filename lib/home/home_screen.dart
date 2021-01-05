import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m2m_coin/components/my_bottom_nav_bar.dart';
import 'package:m2m_coin/home/components/body.dart';
import 'package:m2m_coin/services/AuthService.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //ตัวแปล
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: SvgPicture.asset("assets/icons/notification.svg"),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () {
            print(">>>>>>>>>>>>>>> Click logout");
            authService.logout();
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (Route<dynamic> route) => false);
          },
        ),
      ],
    );
  }
}
