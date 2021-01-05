import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m2m_coin/components/ingredient_progress.dart';

import '../../constants.dart';

class ListMachine extends StatelessWidget {
  const ListMachine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            itemCount: 10,
            itemBuilder: (context, index) {
              return MachineCard();
            },
          ),
        ],
      ),
    );
  }
}

class MachineCard extends StatelessWidget {
  const MachineCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizecircle = size.height * 0.03;

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
              print("+++++++ Click event on Slidable");
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
          height: 160,
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
                              color: kRecovercolor.withOpacity(.22),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kRecovercolor,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "S001",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(
                                    color: kTextColor,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.store_mall_directory,
                            color: kTextColor,
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "ร้านเครื่องซักผ้าหยอดเหรียญ",
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(color: kTextColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      IngredientProgress(
                        ingredient: "Coin in machine",
                        progress: 0.7,
                        leftAmount: 252,
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
