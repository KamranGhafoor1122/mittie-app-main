

import 'package:emarket_user/data/datasource/remote/dio/dio_client.dart';
import 'package:emarket_user/data/model/response/brand_model.dart';
import 'package:emarket_user/data/model/response/field_officer_model.dart';
import 'package:emarket_user/utill/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class BrandsProvider with ChangeNotifier{
  List<BrandsModel> _brandsList;
  Future<void> getBrands() async{
       String url = "${AppConstants.BASE_URL}${AppConstants.GET_BRANDS_URI}";
       print("fo url: $url");
       http.Response response = await http.get(Uri.parse(url));
       print("get fo body: ${response.statusCode} ---${response.body}");
       if(response.statusCode == 200){
            brandsModel = brandsModelFromJson(response.body);
       }
       else{
         brandsModel = [];
       }
  }

  List<BrandsModel> get brandsList=> _brandsList;

  set brandsModel(List<BrandsModel> value) {
    _brandsList = value;
    notifyListeners();
  }
}