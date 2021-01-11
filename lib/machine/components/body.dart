import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:m2m_coin/components/ingredient_progress.dart';
import 'package:m2m_coin/constants.dart';
import 'package:m2m_coin/services/ClearCoinService.dart';
import 'package:m2m_coin/services/MachineService.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  //ตัวแปล
  MachineService machineService = MachineService();
  TextEditingController editingController = TextEditingController();
  List dataAll = [];
  String valuefilter;
  Map<String, dynamic> returnStatus;

  int selectedIndex = 0;
  List categories = [
    "All",
    "Full coin",
    "Have coin",
    "No coin",
    "Online",
    "Off online"
  ];

  //method
  Future getPostsFuture(havefilter) async {
    print('ค่าในฟิวเตอร์ : $havefilter');

    returnStatus = await machineService.getDevices();

    if (returnStatus['status'] == "Sucsess") {
      dataAll = returnStatus['devices'];

      if (selectedIndex != 0) {
        print('ค่าใน categories : ${categories[selectedIndex]}');

        if (categories[selectedIndex] == "Full coin") {
          dataAll = returnStatus['devices']
              .where((i) => i['coin_over_max'] == "1")
              .toList();
        } else if (categories[selectedIndex] == "Have coin") {
          dataAll = returnStatus['devices']
              .where((i) => i['coin_value'] != "0")
              .toList();
        } else if (categories[selectedIndex] == "No coin") {
          dataAll = returnStatus['devices']
              .where((i) => i['coin_value'] == "0")
              .toList();
        } else if (categories[selectedIndex] == "Online") {
          dataAll =
              returnStatus['devices'].where((i) => i['status'] == "1").toList();
        } else if (categories[selectedIndex] == "Off online") {
          dataAll =
              returnStatus['devices'].where((i) => i['status'] == "0").toList();
        }
      }

      if (havefilter != null) {
        print('.......havefilter มีค่า.......');
        return dataAll
            .where((list) => (list['serial']
                    .toLowerCase()
                    .contains(havefilter.toLowerCase()) ||
                list['site_name']
                    .toLowerCase()
                    .contains(havefilter.toLowerCase()) ||
                list['coin_value']
                    .toLowerCase()
                    .contains(havefilter.toLowerCase())))
            .toList();
      } else {
        return dataAll;
      }
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
        print("<<<< เริ่ม Machine Builder >>>>");
        print("--->.............. : ${snapshot.data}");
        if (snapshot.hasData) {
          return RefreshIndicator(
            onRefresh: onPullToRefresh,
            child: Column(
              children: [
                searchBox(),
                categorylistState(),
                SizedBox(height: kDefaultPadding / 2),
                _listCustomScrollView(data: snapshot.data),
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

  Widget searchBox() {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 4,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) {
          print("_______onChang__________");
          setState(() {
            valuefilter = value;
          });
        },
        controller: editingController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: SvgPicture.asset("assets/icons/search.svg"),
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.white),
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
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget categorylistState() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2,
        horizontal: kDefaultPadding * 1.2,
      ),
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            print("_______onTap categories $index __________");
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: kDefaultPadding / 2,
              right: index == categories.length - 1 ? kDefaultPadding / 2 : 0,
            ),
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.8),
            decoration: BoxDecoration(
              color: index == selectedIndex
                  ? Colors.white.withOpacity(0.4)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: index == selectedIndex
                  ? null
                  : Border.all(color: Colors.white54),
            ),
            child: Text(
              categories[index],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listCustomScrollView({data}) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 70),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),
          ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return cardMachine(data: data[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget cardMachine({data}) {
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
          height: 165,
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
                      Row(
                        children: [
                          Icon(
                            Icons.store_mall_directory,
                            color: kTextColor,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          SizedBox(
                            width: size.width * 0.8,
                            child: Text(
                              data['site_name'],
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: kTextColor),
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
