import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:m2m_coin/graph/components/my_bar_chart.dart';
import 'package:m2m_coin/graph/components/stats_grid.dart';

import '../../constants.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          _buildHeader(),
          _buildRegionTabBar(),
          _buildStatasTabBar(),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.5),
            sliver: SliverToBoxAdapter(
              child: StatsGrid(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: kDefaultPadding),
            sliver: SliverToBoxAdapter(
              child: MyBarChart(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SliverPadding(
      padding: EdgeInsets.all(kDefaultPadding),
      sliver: SliverToBoxAdapter(
        child: Text(
          "Statistics",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRegionTabBar() {
    Size size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          height: size.height * 0.05,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: size.height * 0.04,
              indicatorColor: Colors.white,
            ),
            labelStyle: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.w600),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: [
              Text('My Country'),
              Text('Global'),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }

  Widget _buildStatasTabBar() {
    return SliverPadding(
      padding: EdgeInsets.all(kDefaultPadding),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 3,
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelStyle: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(fontWeight: FontWeight.w600),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Text('Total'),
              Text('Today'),
              Text('Yesterday'),
            ],
            onTap: (index) {},
          ),
        ),
      ),
    );
  }
}
