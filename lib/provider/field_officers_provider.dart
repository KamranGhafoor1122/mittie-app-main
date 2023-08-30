

import 'package:emarket_user/data/datasource/remote/dio/dio_client.dart';
import 'package:emarket_user/data/model/response/field_officer_model.dart';
import 'package:emarket_user/utill/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class FieldOfficersProvider with ChangeNotifier{
  List<FieldOfficerModel> _fieldOfficersList;
  Future<void> getFieldOfficersByLocation(String address) async{
       String url = "${AppConstants.BASE_URL}${AppConstants.FIELD_OFFICERS_URI}$address";
       print("fo url: $url");
       http.Response response = await http.get(Uri.parse(url));
       print("get fo body: ${response.statusCode} ---${response.body}");
       if(response.statusCode == 200){
            fieldOfficersList = fieldOfficerModelFromJson(response.body);
       }
       else{
         fieldOfficersList = [];
       }
  }

  List<FieldOfficerModel> get fieldOfficersList => _fieldOfficersList;

  set fieldOfficersList(List<FieldOfficerModel> value) {
    _fieldOfficersList = value;
    notifyListeners();
  }
}