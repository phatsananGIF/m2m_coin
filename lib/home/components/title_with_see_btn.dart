import 'package:flutter/material.dart';

import '../../constants.dart';

class TitleWithSeeBtn extends StatelessWidget {
  const TitleWithSeeBtn({
    Key key,
    this.title,
    this.date,
    this.press,
  }) : super(key: key);

  final String title;
  final String date;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title\n",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: kTitleTextColor, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: date,
                  style: TextStyle(color: kTextLightColor),
                ),
              ],
            ),
          ),
          Spacer(),
          FlatButton(
            onPressed: press,
            child: Text(
              "See details",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
