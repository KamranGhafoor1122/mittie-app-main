import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:emarket_user/helper/responsive_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:emarket_user/data/datasource/remote/dio/dio_client.dart';
import 'package:emarket_user/data/datasource/remote/exception/api_error_handler.dart';
import 'package:emarket_user/data/model/response/base/api_response.dart';
import 'package:emarket_user/data/model/response/signup_model.dart';
import 'package:emarket_user/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({@required this.dioClient, @required this.sharedPreferences});
  String smsModule;


  Future<ApiResponse> registration(SignUpModel signUpModel) async {
    try {
      print("url: ${AppConstants.REGISTER_URI}");
      print(signUpModel.toJson());
      Response response = await dioClient.post(
       AppConstants.REGISTER_URI,
        data: signUpModel.toJson(),
      );
      print("url: ${AppConstants.REGISTER_URI}");

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login({String email, String password}) async {
    try {
      print({"email_or_phone": email, "password": password});
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: {"email_or_phone": email, "email": email, "password": password},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //phone login
  Future<ApiResponse> loginByPhone({String phone, String password}) async {
    try {
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: {"phone": phone, "password": password},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }






  Future<http.Response> loginByGoogle({String providerId, String accessToken,String email}) async {
    try {
      print(
          "provider id: $providerId");
      print("access token $accessToken");
      print("email $email");
      var response = await http.post(
        Uri.parse("${AppConstants.BASE_URL}${AppConstants.GOOGLE_LOGIN_URI}"),
        body: <String,dynamic>{
            "email":email,
             "provider_id":providerId,
              "access_token":accessToken
        }
      );
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future<http.Response> loginByApple({String appleId,String email}) async {
    try {
      print(
          "apple id: $appleId");
      print("email $email");
      var response = await http.post(
          Uri.parse("${AppConstants.BASE_URL}${AppConstants.APPLE_LOGIN_URI}"),
          body: <String,dynamic>{
            "email":email,
            "apple_id":appleId,
          }
      );
      return response;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future<ApiResponse> updateToken() async {
    try {
      String _deviceToken = '';
      if(ResponsiveHelper.isMobilePhone()) {
        _deviceToken = await _saveDeviceToken();
      }
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
      Response response = await dioClient.post(
        AppConstants.TOKEN_URI,
        data: {"_method": "put", "cm_firebase_token": _deviceToken},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<String> _saveDeviceToken() async {
    String _deviceToken = '';
    if(Platform.isAndroid) {
      _deviceToken = await FirebaseMessaging.instance.getToken();
    }else if(Platform.isIOS) {
      _deviceToken = await FirebaseMessaging.instance.getAPNSToken();
    }
    if (_deviceToken != null) {
      print('--------Device Token---------- '+_deviceToken);
    }
    return _deviceToken;
  }

  // for forgot password email
  Future<ApiResponse> forgetPassword(String email) async {
    try {
      print({"email_or_phone": email});
      Response response = await dioClient.post(AppConstants.FORGET_PASSWORD_URI, data: {"email_or_phone": email, "email": email});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyToken(String email, String token) async {
    try {
      print({"email_or_phone": email, "reset_token": token});
      Response response = await dioClient.post(AppConstants.VERIFY_TOKEN_URI, data: {"email_or_phone": email, "email": email, "reset_token": token});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resetPassword(String mail, String resetToken, String password, String confirmPassword) async {
    try {
      print({"_method": "put", "reset_token": resetToken, "password": password, "confirm_password": confirmPassword, "email_or_phone": mail});
      Response response = await dioClient.post(
        AppConstants.RESET_PASSWORD_URI,
        data: {"_method": "put", "reset_token": resetToken, "password": password, "confirm_password": confirmPassword, "email_or_phone": mail, "email": mail},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for verify Email
  Future<ApiResponse> checkEmail(String email) async {
    try {
      Response response = await dioClient.post(
          AppConstants.CHECK_EMAIL_URI, data: {"email": email});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyEmail(String email, String token) async {
    try {
      Response response = await dioClient.post(AppConstants.VERIFY_EMAIL_URI, data: {"email": email, "token": token});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //verify phone number

  Future<ApiResponse> checkPhone(String phone) async {
    try {
      Response response = await dioClient.post(
          AppConstants.BASE_URL+AppConstants.CHECK_PHONE_URI+phone, data: {"phone": phone});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyPhone(String phone, String token) async {
    try {
      Response response = await dioClient.post(
          AppConstants.VERIFY_PHONE_URI, data: {"phone": phone.trim(), "token": token});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient.token = token;
    dioClient.dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $token'};

    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    if(!kIsWeb) {
      await FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
    }
    await sharedPreferences.remove(AppConstants.TOKEN);
    await sharedPreferences.remove(AppConstants.CART_LIST);
    await sharedPreferences.remove(AppConstants.USER_ADDRESS);
    await sharedPreferences.remove(AppConstants.SEARCH_ADDRESS);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_NUMBER, number);
    } catch (e) {
      throw e;
    }
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserNumberAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_NUMBER);
  }

  Future<ApiResponse> deleteUser() async {
    try{
      Response response = await dioClient.delete(AppConstants.CUSTOMER_REMOVE);
      return ApiResponse.withSuccess(response);
    }catch(e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }

  }

}
