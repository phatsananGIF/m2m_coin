import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class ChartService {
  //ตัวแปล
  SharedPreferences _prefs;

  //Method
  Future getDataToChart(String tabSelect) async {
    _prefs = await SharedPreferences.getInstance();
    String userid = _prefs.getString('id');

    /**-- set up POST request arguments*/
    //String url = 'http://192.168.101.232/m2m/Chart/';
    String url = 'http://192.168.1.126/m2m/Chart/';

    Map<String, dynamic> returnStatus;

    /**-- make POST request*/
    http.Response response;
    try {
      response =
          await http.post(url, body: {'user_id': userid, 'tabSelect': tabSelect});

      /**-- check the status code for the result*/
      if (response.statusCode == 200) {
        var dataResponse = convert.jsonDecode(response.body);

        return dataResponse;
      } else {
        returnStatus = {
          "status": "ERROR",
          "message": "Request failed with status: ${response.statusCode}.",
          "color": kDeathColor,
        };
        return returnStatus;
      }
    } catch (e) {
      returnStatus = {
        "status": "ERROR",
        "message": "Connection failed.",
        "color": kDeathColor,
      };
      return returnStatus;
    }
  }
}
