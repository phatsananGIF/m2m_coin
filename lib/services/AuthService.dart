import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../constants.dart';

class AuthService {
  //ตัวแปล
  var datauser = new Map<String, dynamic>();
  SharedPreferences _prefs;

  //Method
  Future login(Map<String, dynamic> values) async {
    /**-- set up POST request arguments*/
    //String url = 'http://192.168.101.168/m2m/login/';
    String url = 'http://192.168.1.126/m2m/login/';
    

    Map<String, dynamic> returnStatus;

    /**-- make POST request*/
    http.Response response;
    try {
      response = await http.post(url, body: values);

      /**-- check the status code for the result*/
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);

        if (jsonResponse['message'] == "Sucsess") {
          print("message ===>>> ${jsonResponse['message']}");
          setSharedPreferences(jsonResponse['data']);
          return true;
        } else {
          returnStatus = {
            "status": "Failed login",
            "message": "Invalid username or password.",
            "color": kBlueColor,
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
  }

  void setSharedPreferences(dataUser) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('is_login', true);
    _prefs.setString('id', dataUser['id']);
    _prefs.setString('level', dataUser['level']);
    _prefs.setString('user_name', dataUser['user_name']);
    _prefs.setString('first_name', dataUser['first_name']);
    _prefs.setString('last_name', dataUser['last_name']);
    _prefs.setString('email', dataUser['email']);
  }

  Future getDataUser() async {
    _prefs = await SharedPreferences.getInstance();
    datauser['is_login'] = _prefs.getBool('is_login');
    datauser['id'] = _prefs.getString('id');
    datauser['level'] = _prefs.getString('level');
    datauser['user_name'] = _prefs.getString('user_name');
    datauser['first_name'] = _prefs.getString('first_name');
    datauser['last_name'] = _prefs.getString('last_name');
    datauser['email'] = _prefs.getString('email');

    return datauser;
  }

  Future isLogin() async {
    _prefs = await SharedPreferences.getInstance();
    /** เช็ค IS_LOGIN ว่ามีค่าอยูหรือไม่ ถ้าไม่มีจะ reture false */
    return _prefs.getBool('is_login') ?? false;
  }

  Future logout() async {
    _prefs = await SharedPreferences.getInstance();
    /** remove เฉพาะ IS_LOGIN และ delayed 1 วิ */
    _prefs.remove('is_login');
    return await Future<Void>.delayed(Duration(seconds: 1));
  }
}
