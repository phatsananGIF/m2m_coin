import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m2m_coin/constants.dart';

class MyBottomNavBar extends StatelessWidget {
  final String page;

  const MyBottomNavBar({
    Key key,
    this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SvgPicture svgPictureHome = SvgPicture.asset("assets/icons/home.svg");
    SvgPicture svgPictureGraph = SvgPicture.asset("assets/icons/graph.svg");
    SvgPicture svgPictureInfo = SvgPicture.asset("assets/icons/info.svg");

    if (page == "home") {
      svgPictureHome = SvgPicture.asset("assets/icons/color_home.svg");
    }
    if (page == "graph") {
      svgPictureGraph = SvgPicture.asset("assets/icons/color_graph.svg");
    }
    if (page == "info") {
      svgPictureInfo = SvgPicture.asset("assets/icons/color_info.svg");
    }

    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
      ),
      height: 80,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: svgPictureHome,
            onPressed: () {
              print(">>  tap home <<");
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          IconButton(
            icon: svgPictureGraph,
            onPressed: () {
              print(">>  tap graph <<");
              Navigator.pushReplacementNamed(context, '/graph');
            },
          ),
          IconButton(
            icon: svgPictureInfo,
            onPressed: () {
              print(">>  tap info <<");
              Navigator.pushReplacementNamed(context, '/info');
            },
          ),
        ],
      ),
    );
  }
}
