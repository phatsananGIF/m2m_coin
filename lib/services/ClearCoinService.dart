import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../constants.dart';

class ClearCoinService {
  //Method
  Future fromSite(String siteID) async {
    /**-- set up POST request arguments*/
    //String url = 'http://192.168.101.232/m2m/clear_coin_from_site/';
    String url = 'http://192.168.1.242/m2m/clear_coin_from_site/';
    

    Map<String, dynamic> returnStatus;

    /**-- make POST request*/
    http.Response response;
    try {
      response = await http.post(url, body: {'site_id': siteID});

      /**-- check the status code for the result*/
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);

        if (jsonResponse['message'] == "Sucsess") {
          return true;
        } else {
          returnStatus = {
            "status": "Failed",
            "message": "Failed to clear coin.",
            "color": kDeathColor,
          };
          return returnStatus;
        }
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
  } //end.fromSite

}
