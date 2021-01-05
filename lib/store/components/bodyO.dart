import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:m2m_coin/home/components/list_site_balance.dart';
import 'package:m2m_coin/services/StoreService.dart';
import 'search_box.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ตัวแปล
    StoreService storeService = StoreService();

    return FutureBuilder(
      future: storeService.getSite(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("---> ค่า return มาที่ Build : ${snapshot.data}");

          if (snapshot.data['status'] == "Sucsess") {
            return Column(
              children: [
                SearchBox(),
                Expanded(
                  child: ListSiteBalance(
                    listSites: snapshot.data['sites'],
                    pageName: '/store',
                  ),
                ),
              ],
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
