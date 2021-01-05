import 'package:flutter/material.dart';
import 'package:m2m_coin/home/components/list_site_balance.dart';
import 'package:m2m_coin/services/HomeService.dart';
import 'package:intl/intl.dart';
import 'package:flushbar/flushbar.dart';

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

  //method
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
    HomeService homeService = HomeService();

    return FutureBuilder(
      future: homeService.getDataToHome(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("---> ค่ามาที่ Build page home body : ${snapshot.data}");

          if (snapshot.data['status'] == "Sucsess") {
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
                    child: ListSiteBalance(
                      listSites: snapshot.data['sites'],
                      pageName: '/home',
                    ),
                  ),
                ],
              ),
            );
          } else {
            print("---> else : ${snapshot.data}");

            return Flushbar(
              title: snapshot.data['status'],
              message: snapshot.data['message'],
              icon: Icon(
                Icons.info_outline,
                size: 28.0,
                color: snapshot.data['color'],
              ),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: snapshot.data['color'],
            )..show(context);
          }
        } else if (snapshot.hasError) {
          return Container();
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
