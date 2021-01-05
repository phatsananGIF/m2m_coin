import 'package:flutter/material.dart';
import 'package:m2m_coin/detailStore/components/body.dart';

class DetailStoreScree extends StatefulWidget {
  @override
  _DetailStoreScreeState createState() => _DetailStoreScreeState();
}

class _DetailStoreScreeState extends State<DetailStoreScree> {
  @override
  Widget build(BuildContext context) {
    String idSite = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Body(valueIDSite: idSite),
    );
  }
}
