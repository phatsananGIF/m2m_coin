import 'package:flutter/material.dart';
import 'package:m2m_coin/home/home_screen.dart';
import 'package:m2m_coin/login/login_screen.dart';
import 'package:m2m_coin/machine/machine_screen.dart';
import 'package:m2m_coin/services/AuthService.dart';
import 'package:m2m_coin/store/store_screen.dart';

import 'constants.dart';
import 'detailStore/detail_store_screen.dart';

bool isLogin;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthService authService = AuthService();
  isLogin = await authService.isLogin();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'm2m coin',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => isLogin == false ? LoginScreen() : HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/machine': (context) => MachineScreen(),
        '/store': (context) => StoreScreen(),
        '/detailStore': (context) => DetailStoreScree(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
