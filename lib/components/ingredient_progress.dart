import 'package:flutter/material.dart';

class IngredientProgress extends StatelessWidget {
  const IngredientProgress({
    Key key,
    this.ingredient,
    this.leftAmount,
    this.progress,
    this.unit,
    this.width,
  }) : super(key: key);

  final String ingredient, unit;
  final int leftAmount;
  final double progress, width;

  @override
  Widget build(BuildContext context) {
    Color progressColor = Colors.green;

    if (progress > 0.8) {
      progressColor = Colors.red;
    } else if (progress > 0.6) {
      progressColor = Colors.orange;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ingredient,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 20,
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.black12,
                  ),
                ),
                Container(
                  height: 20,
                  width: width * progress,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: progressColor,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Text("$leftAmount $unit"),
          ],
        ),
      ],
    );
  }
}
