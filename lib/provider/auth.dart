import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sirbanks_driver/model/http_exception.dart';
import 'package:sirbanks_driver/model/user.dart';
import '../config.dart' as config;

class Auth with ChangeNotifier {
  String _token;
  String _accessTokenType;
  String walletNumber, walletBalance;
  DateTime _expiryDate;
  String weblink;
  String transactionref;

  User user = User();

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String get accessTokenType {
    if (_accessTokenType != null) {
      return _accessTokenType;
    }
    return null;
  }

  Future<void> signUp(User user, derviceName, deviceUUID) async {
    var data = jsonEncode({
      "email": user.email,
      "password": user.password,
      "phone": user.phone,
      "deviceToken": deviceUUID,
      "devicePlatform": derviceName
    });
    print(data);
    try {
      final response = await http.post(
        "${config.baseUrl}/onboarding/initiate/?role=driver",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      if (resData["status"] != "success") {
        if (resData["status"] == "error") {
          throw HttpException(resData["message"]);
        } else {
          throw HttpException(resData["error"]);
        }
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(String email, String password) async {
    var data = jsonEncode({"phoneOrEmail": email.toString(), "password": password.toString()});
    try {
      final response = await http.post(
        "${config.baseUrl}/auth/driver/login",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(utf8.decode(response.bodyBytes));

      print(resData);
      print(response.statusCode);
      print(data);
      if (resData["status"] != "success") {
        throw HttpException(resData["message"]);
      }

      if (resData["status"] == "success") {
        _token = resData["data"]["token"];
        User userdata = User();
        userdata.id = resData["data"]["id"];

        userdata.phone = resData["data"]["phone"];
        userdata.email = resData["data"]["email"];
        // userdata.pictureUrl = resData["data"]["user"]["avatar"].toString();
        user = userdata;

        // _autoLogout();
      }
      print("here is $token");
      //   "status": "success",
      // "data": {
      //     "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwY2MwNTczOGE0OGU0NmFmZmE5MGE4NiIsInJvbGUiOiJkcml2ZXIiLCJpYXQiOjE2MjM5OTY5MDcsImV4cCI6MTY1NTUzMjkwN30.W4OBfXn_7jEY9zQwOM1BTjYGPqSEO-IYONeW9fAZ6DE",
      //     "user": {
      //         "id": "60cc05738a48e46affa90a86",
      //         "email": "ikechukwu0995@gmail.com",
      //         "phone": "+2349027755627",
      //         "firstName": "chiwendu",
      //         "lastName": "ot",
      //         "avatar": "https://res.cloudinary.com/viola/image/upload/v1575029224/wb9azacz6mblteapgtr9.png",
      //         "isEmailVerified": true,
      //         "onboardingStatus": "personal_details"
      //     }
      // }

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': token,
        'userId': user.id,
        "userPhone": user.phone,
        "userEmail": user.email,
        // "pictureUrl": user.pictureUrl,
      });
      prefs.setString("userData", userData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> verifyOtp(String phone, String phoneToken) async {
    var data = jsonEncode({
      "phone": "+2348141240575", 
      "otp": phoneToken
      }
    );

    try {
      final response = await http.post(
        "${config.baseUrl}/onboarding/complete",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      print(data);
      if (resData['status']!="success") {
        throw HttpException(resData["message"]);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> resendOtp(int userId) async {
    var data = jsonEncode({
      "user_id": userId,
    });

    try {
      final response = await http.post(
        "${config.baseUrl}/resend_phone_token",
        headers: {"content-type": "application/json"},
        body: data,
      );
      var resData = jsonDecode(response.body);

      print(resData);
      print(data);
      if (resData["success"] == null) {
        throw HttpException(resData["error"]);
      }

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(milliseconds: 2000), () {
      print(prefs.getString('userData'));
      if (!prefs.containsKey("userData")) {
        return false;
      }

      final extractedUserData = json.decode(prefs.getString("userData"));

      _token = extractedUserData["token"];
      user.id = extractedUserData["userId"];
      user.email = extractedUserData["userEmail"];
      user.phone = extractedUserData["userPhone"];
      // user.pictureUrl = extractedUserData["pictureUrl"];
      notifyListeners();
      // _autoLogout();
      return true;
    });
  }

  void logout() async {
    _token = null;
    user = null;
    // if (_authTimer != null) {
    //   _authTimer.cancel();
    //   _authTimer = null;
    // }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("userData");
    this.user = User();
  }
}
