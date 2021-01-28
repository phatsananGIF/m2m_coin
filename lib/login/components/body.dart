import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:m2m_coin/constants.dart';
import 'package:m2m_coin/login/components/background.dart';

import 'form_login_builder.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/remuneration.svg",
              height: size.height * 0.25,
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              "m2m coin",
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Text(
                  "Click me",
                  style: TextStyle(color: Colors.white),
                ),
                color: kPrimaryColor,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              ),
            ),
            FormLoginBuilder(),
          ],
        ),
      ),
    );
  }
}
