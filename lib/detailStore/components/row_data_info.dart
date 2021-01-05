import 'package:flutter/material.dart';

class RowDataInfo extends StatelessWidget {
  final Icon iconOfText;
  final String dataText;

  const RowDataInfo({
    Key key,
    this.iconOfText,
    this.dataText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: iconOfText,
        ),
        Expanded(
          flex: 8,
          child: Text(
            dataText,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
