import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m2m_coin/detailStore/components/body.dart';
import 'package:m2m_coin/detailStore/components/row_data_info.dart';

import '../constants.dart';

class DetailStoreScree extends StatefulWidget {
  @override
  _DetailStoreScreeState createState() => _DetailStoreScreeState();
}

class _DetailStoreScreeState extends State<DetailStoreScree> {
  @override
  Widget build(BuildContext context) {
    String idSite = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: kBodyLightColor,
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
                      color: kPrimaryColor,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kPrimaryColor.withOpacity(0.23),
                        ),
                      ],
                    ),
                    child: Text(
                      "฿ 5,000,000",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                  Text(
                    "Otteri Wash And Dry",
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  RowDataInfo(
                    iconOfText: Icon(Icons.store_mall_directory, size: 16),
                    dataText:
                        "123 456 ตำบลหนองขาม อำเภอศรีราชา จังหวัดชลบุรี 20110",
                  ),
                  SizedBox(height: kDefaultPadding / 1.5),
                  RowDataInfo(
                    iconOfText: Icon(Icons.call, size: 16),
                    dataText: "+66945576306",
                  ),
                  SizedBox(height: kDefaultPadding / 1.5),
                  RowDataInfo(
                    iconOfText: Icon(Icons.question_answer, size: 16),
                    dataText: "https://www.facebook.com/otterisahaphat/",
                  ),
                ],
              ),
            ),
            SizedBox(height: kDefaultPadding * 3),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding * 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Machine in Store",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text("data"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


