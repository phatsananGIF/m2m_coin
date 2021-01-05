import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:m2m_coin/components/custom_card_shape_painter.dart';
import 'package:m2m_coin/services/ClearCoinService.dart';

import '../../constants.dart';

class ListSiteBalance extends StatelessWidget {
  final List<dynamic> listSites;
  final String pageName;

  const ListSiteBalance({
    Key key,
    this.listSites,
    this.pageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listSites.length,
      itemBuilder: (BuildContext context, int index) {
        return CardSiteBalance(
          dataSites: listSites[index],
          pageName: pageName,
        );
      },
    );
  }
}

class CardSiteBalance extends StatelessWidget {
  final Map<String, dynamic> dataSites;
  final String pageName;

  const CardSiteBalance({
    Key key,
    this.dataSites,
    this.pageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ClearCoinService clearCoinService = ClearCoinService();

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        Container(
          margin: EdgeInsets.only(
            bottom: kDefaultPadding,
          ),
          decoration: BoxDecoration(
            color: cGradientColor2,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: cGradientColor2,
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: IconSlideAction(
            iconWidget: SvgPicture.asset("assets/icons/broom.svg"),
            caption: "Clear Coin",
            color: transparent,
            onTap: () {
              print("+++++++ Site ID : ${dataSites['id']}");

              clearCoinService.fromSite(dataSites['id']).then((result) {
                print("------> result : $result ");

                if (result == true) {
                  Navigator.pushReplacementNamed(context, pageName);
                } else {
                  Flushbar(
                    title: result['status'],
                    message: result['message'],
                    icon: Icon(
                      Icons.info_outline,
                      size: 28.0,
                      color: result['color'],
                    ),
                    duration: Duration(seconds: 3),
                    leftBarIndicatorColor: result['color'],
                  )..show(context);
                }
              });
            },
          ),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          print(">>>>>>>>>กดดูรายละเอียดร้านค้า ${dataSites['id']}");
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: kDefaultPadding,
            right: kDefaultPadding,
            bottom: kDefaultPadding,
          ),
          child: Stack(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [cGradientColor1, cGradientColor2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: cGradientColor2,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: CustomPaint(
                  size: Size(100, 150),
                  painter: CustomCardShapePainter(
                      20, cGradientColor1, cGradientColor2),
                ),
              ),
              Positioned.fill(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SvgPicture.asset(
                        "assets/icons/coin.svg",
                        height: size.width * 0.09,
                        width: size.width * 0.09,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataSites['site_name'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            dataSites['address'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${dataSites['amphur']} ${dataSites['province']}",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            NumberFormat("#,### ฿")
                                .format(dataSites['total_coin']),
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
