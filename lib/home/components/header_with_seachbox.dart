import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class HeaderWithSearchBox extends StatelessWidget {
  final Size size;
  final int totalAmounts;

  const HeaderWithSearchBox({
    Key key,
    @required this.size,
    this.totalAmounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      height: size.height * 0.2,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              //bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total amounts",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.white),
                ),
                Row(
                  children: [
                    Text(
                      NumberFormat("#,###").format(totalAmounts),
                      style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      "฿",
                      style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
