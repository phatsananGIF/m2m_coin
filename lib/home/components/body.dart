import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m2m_coin/components/custom_card_shape_painter.dart';
import 'package:m2m_coin/services/ClearCoinService.dart';
import 'package:m2m_coin/services/HomeService.dart';
import 'package:intl/intl.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../constants.dart';
import 'case_update.dart';
import 'header_with_seachbox.dart';
import 'title_with_more_bbtn.dart';
import 'title_with_see_btn.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //ตัวแปล
  HomeService homeService = HomeService();
  Map<String, dynamic> returnStatus;

  //method
  Future getPostsFuture() async {
    returnStatus = await homeService.getDataToHome();

    if (returnStatus['status'] == "Sucsess") {
      return returnStatus;
    } else {
      print("---> else : $returnStatus");

      Flushbar(
        title: returnStatus['status'],
        message: returnStatus['message'],
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: returnStatus['color'],
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: returnStatus['color'],
      )..show(context);

      return null;
    }
  }

  Future<Null> onPullToRefresh() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: getPostsFuture(),
      builder: (context, snapshot) {
        print("........เริ่ม Store Builder  body Home page.........");

        if (snapshot.hasData) {
          print("--->.............. : ${snapshot.data}");

          var formatter = DateFormat.yMMMMd();
          DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(
            snapshot.data['server_updated'],
          );

          return RefreshIndicator(
            onRefresh: onPullToRefresh,
            child: Column(
              children: [
                HeaderWithSearchBox(
                  size: size,
                  totalAmounts: snapshot.data['total_amounts'],
                ),
                TitleWithSeeBtn(
                  title: "Case update",
                  date: "Newest update ${formatter.format(tempDate)}",
                  press: () {
                    Navigator.pushNamed(context, '/machine');
                  },
                ),
                CaseUpdate(
                  devicesFull: snapshot.data['devices_full'],
                  devicesHaveCoin: snapshot.data['devices_have_coin'],
                  devicesNoCoin: snapshot.data['devices_no_coin'],
                ),
                TitleWithMoreBtn(
                  title: "Store balance",
                  press: () {
                    Navigator.pushNamed(context, '/store').then((value) {
                      setState(() {
                        print("set state at bodyHome");
                      });
                    });
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data['sites'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return cardSite(data: snapshot.data['sites'][index]);
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Container();
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget cardSite({data}) {
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
              print("+++++++ Site ID : ${data['id']}");

              clearCoinService.fromSite(data['id']).then((result) {
                print("------> Clear Coin result : $result ");

                if (result == true) {
                  setState(() {});
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
          print(">>>>>>>>>กดดูรายละเอียดร้านค้า ${data['id']}");

          Navigator.pushNamed(
            context,
            '/detailStore',
            arguments: data['id'],
          ).then((value) {
            setState(() {
              print("set state at bodyHome");
            });
          });
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
                            data['site_name'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            data['address'],
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
                                "${data['amphur']} ${data['province']}",
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
                            NumberFormat("#,### ฿").format(data['total_coin']),
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
