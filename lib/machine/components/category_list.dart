import 'package:flutter/material.dart';

import '../../constants.dart';

class Categorylist extends StatefulWidget {
  Categorylist({Key key}) : super(key: key);

  @override
  _CategorylistState createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  int selectedIndex = 0;
  List categories = [
    "All",
    "Full coin",
    "Have coin",
    "No coin",
    "Online",
    "Off online"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2,
        horizontal: kDefaultPadding * 1.2,
      ),
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            print("_______onTap categories $index __________");
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: kDefaultPadding / 2,
              right: index == categories.length - 1 ? kDefaultPadding / 2 : 0,
            ),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.8),
            decoration: BoxDecoration(
              color: index == selectedIndex
                  ? Colors.white.withOpacity(0.4)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: index == selectedIndex
                  ? null
                  : Border.all(color: Colors.white54),
            ),
            child: Text(
              categories[index],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
