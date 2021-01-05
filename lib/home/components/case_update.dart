import 'package:flutter/material.dart';

import '../../constants.dart';

class CaseUpdate extends StatelessWidget {
  final int devicesFull;
  final int devicesHaveCoin;
  final int devicesNoCoin;

  const CaseUpdate({
    Key key,
    this.devicesFull,
    this.devicesHaveCoin,
    this.devicesNoCoin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        top: kDefaultPadding / 2,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
        padding: EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 30,
              color: kPrimaryColor.withOpacity(0.23),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Counter(
              number: devicesFull,
              title: "full coin",
              color: kDeathColor,
            ),
            Counter(
              number: devicesHaveCoin,
              title: "have coin",
              color: kRecovercolor,
            ),
            Counter(
              number: devicesNoCoin,
              title: "no coin",
              color: kBodyTextColor,
            ),
          ],
        ),
      ),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({
    Key key,
    this.number,
    this.color,
    this.title,
  }) : super(key: key);

  final int number;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizeSmall = size.height * 0.04;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(sizeSmall * 0.2),
          height: sizeSmall,
          width: sizeSmall,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: sizeSmall * 0.1,
              ),
            ),
          ),
        ),
        Text(
          "$number",
          style: Theme.of(context).textTheme.headline4.copyWith(color: color),
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: kTextLightColor),
        ),
      ],
    );
  }
}
