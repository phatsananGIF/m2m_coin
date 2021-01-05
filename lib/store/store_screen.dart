import 'package:flutter/material.dart';
import 'package:m2m_coin/constants.dart';
import 'package:m2m_coin/store/components/body.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.keyboard_arrow_left),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text("Store"),
      centerTitle: true,
    );
  }
}
