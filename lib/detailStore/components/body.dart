import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:m2m_coin/components/ingredient_progress.dart';
import 'package:m2m_coin/detailStore/components/row_data_info.dart';
import 'package:m2m_coin/services/ClearCoinService.dart';
import 'package:m2m_coin/services/DetailStoreService.dart';

import '../../constants.dart';

class Body extends StatefulWidget {
  //ตัวแปล
  final String valueIDSite;
  Body({Key keyValue, this.valueIDSite}) : super(key: keyValue);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //ตัวแปล
  DetailStoreService detailStoreService = DetailStoreService();
  Map<String, dynamic> returnStatus;

  //method
  Future getPostsFuture() async {
    returnStatus =
        await detailStoreService.getDataToDetailStore(widget.valueIDSite);

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
    print("........เริ่ม DetailStoreScree .......");
    print("valueIDSite : ${widget.valueIDSite}");

    return FutureBuilder(
      future: getPostsFuture(),
      builder: (context, snapshot) {
        print(
            "........เริ่ม Store Builder  body DetailStoreScree page........");

        if (snapshot.hasData) {
          print("-----------> : ${snapshot.data}");

          return RefreshIndicator(
            onRefresh: onPullToRefresh,
            child: Container(
              decoration: BoxDecoration(
                color: cGradientColor1,
                image: DecorationImage(
                  image: AssetImage("assets/images/ux_coin.png"),
                  alignment: Alignment.topRight,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: kDefaultPadding,
                        top: kDefaultPadding * 2.5,
                        right: kDefaultPadding * 10,
                        bottom: kDefaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.keyboard_arrow_left,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                        SizedBox(height: kDefaultPadding),
                        Container(
                          padding: EdgeInsets.only(
                            left: kDefaultPadding,
                            top: kDefaultPadding / 3,
                            right: kDefaultPadding,
                            bottom: kDefaultPadding / 3,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: kLabelCoinColor,
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 30,
                                color: kLabelCoinColor.withOpacity(0.23),
                              ),
                            ],
                          ),
                          child: Text(
                            NumberFormat("#,### ฿")
                                .format(snapshot.data['site']['total_coin']),
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        SizedBox(height: kDefaultPadding),
                        Text(
                          snapshot.data['site']['site_name'],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: kDefaultPadding / 2),
                        RowDataInfo(
                          iconOfText: Icon(
                            Icons.store_mall_directory,
                            size: 16,
                            color: Colors.white,
                          ),
                          dataText:
                              "${snapshot.data['site']['address'] ?? ''} ${snapshot.data['site']['tumbon'] ?? ''} ${snapshot.data['site']['amphur'] ?? ''} ${snapshot.data['site']['province'] ?? ''} ${snapshot.data['site']['postal_code'] ?? ''}",
                        ),
                        SizedBox(height: kDefaultPadding / 1.5),
                        RowDataInfo(
                          iconOfText: Icon(
                            Icons.call,
                            size: 16,
                            color: Colors.white,
                          ),
                          dataText: "${snapshot.data['site']['phone'] ?? '-'}",
                        ),
                        SizedBox(height: kDefaultPadding / 1.5),
                        RowDataInfo(
                          iconOfText: Icon(
                            Icons.question_answer,
                            size: 16,
                            color: Colors.white,
                          ),
                          dataText:
                              "${snapshot.data['site']['contact'] ?? '-'}",
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: kDefaultPadding * 2,
                              top: kDefaultPadding,
                              right: kDefaultPadding,
                            ),
                            child: Text(
                              "Machine in Store",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data['devices'].length,
                              itemBuilder: (context, index) {
                                return listMachineInStore(
                                  data: snapshot.data['devices'][index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Container();
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget listMachineInStore({data}) {
    ClearCoinService clearCoinService = ClearCoinService();
    Size size = MediaQuery.of(context).size;
    double sizecircle = size.height * 0.03;

    var formatter = DateFormat("MMMM d, y hh:mm:ss");
    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(
      data['date_updated'],
    );

    var colorStatus = {
      "0": kDeathColor,
      "1": kRecovercolor,
    };

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        Container(
          margin: EdgeInsets.symmetric(
            vertical: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            color: cGradientColor1,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(22),
              bottomLeft: Radius.circular(22),
            ),
            boxShadow: [kDefaultShadow],
          ),
          child: IconSlideAction(
            iconWidget: SvgPicture.asset("assets/icons/broom.svg"),
            caption: "Clear Coin",
            color: transparent,
            onTap: () {
              print("+++++++ Click event on Slidable ${data['id']}");

              clearCoinService.fromDevice(data['id']).then((result) {
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
          print(">>>>>>>>>Click event on Container");
        },
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
            vertical: kDefaultPadding / 2,
          ),
          height: 130,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: cGradientColor1,
                  boxShadow: [kDefaultShadow],
                ),
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(sizecircle * 0.15),
                            height: sizecircle,
                            width: sizecircle,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  colorStatus[data['status']].withOpacity(.22),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorStatus[data['status']],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: data['serial'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          color: kTitleTextColor,
                                          fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      "     ${NumberFormat("#,### ฿").format(int.parse(data['coin_value']))} \n",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(color: kTitleTextColor),
                                ),
                                TextSpan(
                                  text: formatter.format(tempDate),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(color: kTextLightColor),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      IngredientProgress(
                        ingredient: "Coin in machine",
                        progress: double.parse(data['percent_progress']),
                        leftAmount: int.parse(data['coin_count']),
                        unit: "coin",
                        width: size.width * 0.7,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
