import 'package:flutter/material.dart';
import 'package:m2m_coin/constants.dart';
import 'package:m2m_coin/machine/components/body.dart';

class MachineScreen extends StatefulWidget {
  @override
  _MachineScreenState createState() => _MachineScreenState();
}

class _MachineScreenState extends State<MachineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
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
      title: Text("Machine"),
      centerTitle: true,
    );
  }
}
