import 'package:flutter/material.dart';
import 'package:m2m_coin/constants.dart';

import 'category_list.dart';
import 'list_machine.dart';
import 'search_box.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBox(),
        Categorylist(),
        SizedBox(height: kDefaultPadding / 2),
        ListMachine(),
      ],
    );
  }
}
