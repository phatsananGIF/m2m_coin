import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../constants.dart';

class DetailStoreService {
  //Method
  Future getDataToDetailStore(String siteID) async {
    /**-- set up POST request arguments*/
    //String url = 'http://192.168.101.168/m2m/detail_store';
    String url = 'http://192.168.1.126/m2m/detail_store';
    

    Map<String, dynamic> returnStatus;

    /**-- make POST request*/
    http.Response response;
    try {
      response = await http.post(url, body: {'site_id': siteID});

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
  } //end.getDataToDetailStore

}
