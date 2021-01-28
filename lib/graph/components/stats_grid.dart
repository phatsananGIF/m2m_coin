import 'package:flutter/material.dart';
import 'package:m2m_coin/constants.dart';

class StatsGrid extends StatefulWidget {
  @override
  _StatsGridState createState() => _StatsGridState();
}

class _StatsGridState extends State<StatsGrid> {
  //ตัวแปล

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      child: Column(
        children: [
          Flexible(
            child: Row(
              children: [
                _buildStatCard('Total Cases', '1.81 M', Colors.orange),
                _buildStatCard('Desths', '105 K', Colors.red),
              ],
            ),
          ),
          Flexible(
            child: Row(
              children: [
                _buildStatCard('Recovered', '391 K', Colors.green),
                _buildStatCard('Active', '1.31 M', Colors.lightBlue),
                _buildStatCard('Critical', 'N/A', Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(kDefaultPadding * 0.4),
        padding: EdgeInsets.all(kDefaultPadding * 0.5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
            Text(
              count,
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}