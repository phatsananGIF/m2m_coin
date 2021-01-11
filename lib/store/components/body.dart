import 'package:intl/intl.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m2m_coin/components/custom_card_shape_painter.dart';
import 'package:m2m_coin/services/ClearCoinService.dart';
import 'package:m2m_coin/services/StoreService.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //ตัวแปล
  StoreService storeService = StoreService();
  TextEditingController editingController = TextEditingController();
  List dataAll = [];
  String valuefilter;
  Map<String, dynamic> dataStatus;

  //method
  Future getPostsFuture(havefilter) async {
    print('ค่าในฟิวเตอร์ : $havefilter');

    dataStatus = await storeService.getSite();

    if (dataStatus['status'] == "Sucsess") {
      dataAll = dataStatus['sites'];

      if (havefilter != null) {
        print('.......havefilter มีค่า.......');
        return dataAll
            .where((list) => (list['site_name']
                    .toLowerCase()
                    .contains(havefilter.toLowerCase()) ||
                list['address']
                    .toLowerCase()
                    .contains(havefilter.toLowerCase())))
            .toList();
      } else {
        return dataAll;
      }
    } else {
      print("---> else : $dataStatus");

      Flushbar(
        title: dataStatus['status'],
        message: dataStatus['message'],
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: dataStatus['color'],
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: dataStatus['color'],
      )..show(context);
      return dataAll = [];
    }
  }

  Future<Null> onPullToRefresh() async {
    await Future.delayed(
      Duration(seconds: 2),
    );
    setState(() {
      valuefilter = null;
      editingController.clear();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPostsFuture(valuefilter),
      builder: (context, snapshot) {
        print("<<<< เริ่ม Store Builder >>>>");
        print("--->.............. : ${snapshot.data}");
        if (snapshot.hasData) {
          return RefreshIndicator(
            onRefresh: onPullToRefresh,
            child: Column(
              children: [
                Expanded(child: _listCustomScrollView(data: snapshot.data)),
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

  Widget _listCustomScrollView({data}) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            searchBox(),
          ]),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return cardSite(data: data[index]);
          }, childCount: data.length),
        ),
      ],
    );
  }

  Widget searchBox() {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.1 - 50,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(kDefaultPadding),
            padding: EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding / 4,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                print("_______onChang__________");

                setState(() {
                  valuefilter = value;
                });
              },
              controller: editingController,
              style: TextStyle(color: kPrimaryColor),
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                icon: SvgPicture.asset("assets/icons/search_color.svg"),
                hintText: "Search",
                hintStyle: TextStyle(
                  color: kPrimaryColor.withOpacity(0.5),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    print("________onPressed_____________");

                    setState(() {
                      valuefilter = null;
                      editingController.clear();
                    });
                  },
                  icon: Icon(
                    Icons.clear,
                    size: 20,
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
                  //Navigator.puListSiteBalanceeName);
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
