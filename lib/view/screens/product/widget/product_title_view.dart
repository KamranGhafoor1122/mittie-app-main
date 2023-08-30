import 'package:emarket_user/data/model/response/product_model.dart';
import 'package:emarket_user/helper/price_converter.dart';
import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/provider/auth_provider.dart';
import 'package:emarket_user/provider/product_provider.dart';
import 'package:emarket_user/provider/wishlist_provider.dart';
import 'package:emarket_user/utill/color_resources.dart';
import 'package:emarket_user/utill/dimensions.dart';
import 'package:emarket_user/utill/styles.dart';
import 'package:emarket_user/view/base/custom_snackbar.dart';
import 'package:emarket_user/view/base/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../helper/responsive_helper.dart';


class ProductTitleView extends StatelessWidget {
  final Product productModel;
  ProductTitleView({@required this.productModel});

  @override
  Widget build(BuildContext context) {
    final bool _isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    double _startingPrice;
    double _endingPrice;
    if(productModel.variations.length != 0) {
      List<double> _priceList = [];
      productModel.variations.forEach((variation) => _priceList.add(variation.price));
      _priceList.sort((a, b) => a.compareTo(b));
      _startingPrice = _priceList[0];
      if(_priceList[0] < _priceList[_priceList.length-1]) {
        _endingPrice = _priceList[_priceList.length-1];
      }
    }else {
      _startingPrice = productModel.price;
    }

    return ResponsiveHelper.isDesktop(context)
        ? Consumer<ProductProvider>(builder: (context, product, child){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(
              productModel.name ?? '',
              style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_THIRTY),
              maxLines: 2, overflow: TextOverflow.ellipsis,
            ),
              const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              Row(
                children: [
                  RatingBar(rating: productModel.rating != null ? productModel.rating.length > 0 ? double.parse(productModel.rating[0].average) : 0.0 : 0.0,size: 21),
                  const SizedBox(width: 30),

                  productModel.discount > 0 ? Flexible(
                    child: Text(
                      '${PriceConverter.convertPrice(context, _startingPrice)}'
                          '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice)}' : ''}',
                      style: rubikRegular.copyWith(color: ColorResources.RED_COLOR, decoration: TextDecoration.lineThrough,fontSize: Dimensions.FONT_SIZE_LARGE),
                    ),
                  ) : SizedBox(),

                  const SizedBox(width: 10),
                  Text(
                    '${PriceConverter.convertPrice(context, _startingPrice, discount: productModel.discount, discountType: productModel.discountType)}'
                        '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, discount: productModel.discount, discountType: productModel.discountType)}' : ''}',
                    style: rubikBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.FONT_SIZE_THIRTY),
                  ),
                ],
              ),

            ],);
    })
        : Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Consumer<ProductProvider>(
        builder: (context, product, child) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Row(children: [
              Expanded(child: Text(
                productModel.name ?? '',
                style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                maxLines: 2, overflow: TextOverflow.ellipsis,
              )),
            ]),


            SizedBox(height: 5),


            Row(
              children: [
                Expanded(child: Row(
                  children: [
                    Image.asset("assets/image/star.png",height: 18,width: 18,),
                    SizedBox(
                      width: 7,
                    ),

                    Text(productModel.rating != null ? productModel.rating.length > 0 ? double.parse(productModel.rating[0].average).toStringAsFixed(1) : '0.0' : '0.0', style: rubikRegular.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    )),
                  ],
                )),
                Container(
                  height: 35,
                  width: 2,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: 10,
                ),


                Expanded(child: Row(
                  children: [
                    Image.asset("assets/image/delivery truck.png",height: 25,width: 25,),
                    SizedBox(
                      width: 7,
                    ),

                    Text("FREE DELIVERY", style: rubikRegular.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: Dimensions.FONT_SIZE_LARGE,
                    )),
                  ],
                )),

              ],
            ),

            SizedBox(height: 5),

            Row(children: [
              Flexible(
                child: Text(
                  '${PriceConverter.convertPrice(context, _startingPrice, discount: productModel.discount, discountType: productModel.discountType)}'
                      '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, discount: productModel.discount, discountType: productModel.discountType)}' : ''}',
                  style: rubikBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                  ),
                ),
              ),
              SizedBox(width: 10),

              productModel.discount > 0 ? Flexible(
                child: Text(
                  '${PriceConverter.convertPrice(context, _startingPrice)}'
                      '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice)}' : ''}',
                  style: rubikRegular.copyWith(color: Theme.of(context).hintColor, decoration: TextDecoration.lineThrough),
                ),
              ) : SizedBox(),

              Spacer(),
              Image.asset("assets/image/share.png",height: 30,width: 30,),
            ]),

/*
            Row(children: [


              SizedBox(width: 5),

              RatingBar(rating: productModel.rating != null ? productModel.rating.length > 0 ? double.parse(productModel.rating[0].average) : 0.0 : 0.0),

            ]),
*/

          ]);
        },
      ),
    );
  }
}
