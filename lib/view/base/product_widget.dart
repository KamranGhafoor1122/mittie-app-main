
import 'package:emarket_user/provider/cart_provider.dart';
import 'package:emarket_user/utill/routes.dart';
import 'package:emarket_user/view/base/on_hover.dart';
import 'package:emarket_user/view/base/title_widget.dart';
import 'package:emarket_user/view/screens/product/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:emarket_user/data/model/response/product_model.dart';
import 'package:emarket_user/helper/price_converter.dart';
import 'package:emarket_user/provider/splash_provider.dart';
import 'package:emarket_user/provider/theme_provider.dart';
import 'package:emarket_user/utill/color_resources.dart';
import 'package:emarket_user/utill/dimensions.dart';
import 'package:emarket_user/utill/images.dart';
import 'package:emarket_user/utill/styles.dart';
import 'package:emarket_user/view/base/rating_bar.dart';
import 'package:provider/provider.dart';

import '../../data/model/response/cart_model.dart';
import '../../helper/responsive_helper.dart';
import '../../localization/language_constrants.dart';
import '../../provider/auth_provider.dart';
import '../../provider/wishlist_provider.dart';
import 'custom_snackbar.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  ProductWidget({@required this.product});

  @override
  Widget build(BuildContext context) {

    final bool _isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn();

    bool isExistInCart = false;

    final CartProvider _cartProvider = Provider.of<CartProvider>(context, listen: true);
    double _startingPrice;
    double _endingPrice;
    int _stock = 0;
    Variation _variation = Variation();
    List _tabChildren;
    double priceWithQuantity;
    CartModel _cartModel;
    List _variationList;
    if(product.variations.length != 0) {
      List<double> _priceList = [];
      product.variations.forEach((variation) => _priceList.add(variation.price));
      _priceList.sort((a, b) => a.compareTo(b));
      _startingPrice = _priceList[0];
      if(_priceList[0] < _priceList[_priceList.length-1]) {
        _endingPrice = _priceList[_priceList.length-1];
      }
    } else {
      _startingPrice = product.price;
    }


    _variationList = [];

    String variationType = '';
    bool isFirst = true;
    _variationList.forEach((variation) {
      if(isFirst) {
        variationType = '$variationType$variation';
        isFirst = false;
      }else {
        variationType = '$variationType-$variation';
      }
    });

    double price = product.price;

    _stock = product.totalStock;
    for(Variation variation in product.variations) {
      if(variation.type == variationType) {
        price = variation.price;
        _variation = variation;
        _stock = variation.stock;
        break;
      }
    }
    double priceWithDiscount = PriceConverter.convertWithDiscount(context, price, product.discount, product.discountType);

    _cartModel = CartModel(
      price, priceWithDiscount, [_variation],
      (price - PriceConverter.convertWithDiscount(context, price, product.discount, product.discountType)),
       0, price - PriceConverter.convertWithDiscount(context, price, product.tax, product.taxType),
      _stock, product,
    );
    isExistInCart = Provider.of<CartProvider>(context).isExistInCart(_cartModel, false, null);
    if(isExistInCart) {
      priceWithQuantity = priceWithDiscount * _cartProvider.cartList[_cartProvider.getCartProductIndex(_cartModel, false, null)].quantity;
    }else {
      priceWithQuantity = priceWithDiscount * 0;
    }

     double _discountedPrice = PriceConverter.convertWithDiscount(context, product.price, product.discount, product.discountType);

    return ResponsiveHelper.isDesktop(context)
        ? OnHover(
          isItem: true,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                Routes.getProductDetailsRoute(product.id),
                // arguments: ProductDetailsScreen(product: product),
              );
            },
            hoverColor: Colors.transparent,
            child: Stack(
              children: [
                Container(
                  // margin: const EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorResources.getWebCardColor(context),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(
                          color: ColorResources.COLOR_BLACK.withOpacity(0.08),
                          blurRadius: 8, spreadRadius: 0,offset: Offset(0,3)
                      )]
                  ),
                  child: Column(children: [
                    Expanded(flex: 6,child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      child: FadeInImage.assetNetwork(
                        width: double.infinity,
                        placeholder: Images.placeholder(context),
                        fit: BoxFit.cover,
                        image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${product.image[0]}',
                        imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder(context),  fit: BoxFit.cover),
                      ),
                    ),
                    ),
                    Expanded(flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(product.name, style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.getBlackAndWhiteColor(context)), maxLines: 1, overflow: TextOverflow.ellipsis),
                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                            // RatingBar(rating: offerProduct.offerProductList[_currentIndex].rating.length > 0 ? double.parse(offerProduct.offerProductList[_currentIndex].rating[0].average) : 0.0, size: Dimensions.PADDING_SIZE_DEFAULT),
                            RatingBar(rating: product.rating.length > 0 ? double.parse(product.rating[0].average) : 0.0, size: 10),

                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                          product.price > _discountedPrice ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            child: Text(
                                '${PriceConverter.convertPrice(context, _startingPrice, asFixed: 1)}'
                                    '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, asFixed: 1)}' : ''}',
                                style: TextStyle(decoration: TextDecoration.lineThrough,fontWeight: FontWeight.w400)
                            ),
                          ) : SizedBox(),

                          Text(
                            '${PriceConverter.convertPrice(context, _startingPrice, discount: product.discount,
                                discountType: product.discountType, asFixed: 1)}''${_endingPrice!= null
                                ? ' - ${PriceConverter.convertPrice(context, _endingPrice, discount: product.discount,
                                discountType: product.discountType, asFixed: 1)}' : ''}',
                            style: rubikBold.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE, color: ColorResources.WEB_HEADER_COLOR),
                          ),



                          ]),
                      ),),
                  ]),
                ),
                Positioned(
                  top: 10,right: 10,
                  child: Consumer<WishListProvider>(
                    builder: (context, wishList, child) {
                      return InkWell(
                        onTap: () {
                          if(_isLoggedIn){
                            if(wishList.wishIdList.contains(product.id)) {
                              wishList.removeFromWishList(product, (message) {
                                showCustomSnackBar(message, context, isError: false);
                              });
                            }else {
                              wishList.addToWishList(product, (message) {
                                showCustomSnackBar(message, context, isError: false);
                              });
                            }
                          }else showCustomSnackBar(getTranslated('not_logged_in', context), context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorResources.getWhiteAndBlackColor(context),
                            shape: BoxShape.circle,
                              boxShadow: [BoxShadow(
                                  color: ColorResources.COLOR_BLACK.withOpacity(0.08),
                                  blurRadius: 8, spreadRadius: 0,offset: Offset(0,3)
                              )]
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            wishList.wishIdList.contains(product.id) ? Icons.favorite : Icons.favorite_border, size: 25,
                            color: wishList.wishIdList.contains(product.id) ? Theme.of(context).primaryColor : ColorResources.getGreyColor(context),
                          ),
                        ),
                      );
                    }
                ),)
              ],
            ),
          ),
        ):
    Padding(
      padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            Routes.getProductDetailsRoute(product.id),
            arguments: ProductDetailsScreen(product: product),
          );
        },
        child: Container(
          height: 220,
          width: 170,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                Provider.of<ThemeProvider>(context).darkTheme ?BoxShadow() : BoxShadow(
                  color:  Colors.grey[300] ,
                  blurRadius: 15, spreadRadius: 1,
                ) ]
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder(context),
                image:  '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${product.image[0]}',
                height: 110, width: double.infinity, fit: BoxFit.cover,
                imageErrorBuilder: (c,o,t)=> Image.asset(Images.placeholder(context),height: 110, width: 170, fit: BoxFit.cover),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '${product.name}',
                    style: rubikMedium.copyWith(fontSize: 14,fontWeight: FontWeight.w600,color: ColorResources.COLOR_GREY_BUNKER,),
                    maxLines: 2, overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 6,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${PriceConverter.convertPrice(context, _startingPrice, discount: product.discount, discountType: product.discountType, asFixed: 1)}'
                            '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, discount: product.discount,
                            discountType: product.discountType, asFixed: 1)}' : ''}',
                        style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL,color:Theme.of(context).primaryColor),
                        maxLines: 2, overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 10),

                      product.price > _discountedPrice ? Text('${PriceConverter.convertPrice(context, _startingPrice, asFixed: 1)}'
                          '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, asFixed: 1)}' : ''}', style: rubikMedium.copyWith(
                        color: ColorResources.COLOR_GREY,
                        decoration: TextDecoration.lineThrough,
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                      )) : SizedBox(),

                    ],
                  ),


               //   RatingBar(rating: product.rating.length > 0 ? double.parse(product.rating[0].average) : 0.0, size: 10),
                  SizedBox(height: 15),



                  Container(
                    //decoration: BoxDecoration(color: ColorResources.getBackgroundColor(context), borderRadius: BorderRadius.circular(5)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      InkWell(
                        onTap: () {
                          if(isExistInCart) {
                            if(_cartProvider.cartList[_cartProvider.getCartProductIndex(_cartModel, false, null)].quantity > 1) {
                              _cartProvider.setQuantity(false, _cartModel, _cartModel.maxQty, context,true, _cartProvider.getCartProductIndex(_cartModel, false, null));
                            }

                          }else {
                            /*if(quantity > 1) {
                              productProvider.setQuantity(false, _stock, context);
                            }*/
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                              color: Theme.of(context).primaryColor
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.remove, size: 25,color: Colors.white,),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(isExistInCart ? "${_cartProvider.cartList[_cartProvider.getCartProductIndex(_cartModel, false, null)].quantity}"
                          : "0", style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT,color: Theme.of(context).primaryColor)),

                      SizedBox(
                        width: 10,
                      ),

                      InkWell(
                        onTap: () {
                          if(!isExistInCart) {
                            Provider.of<CartProvider>(context, listen: false).addToCart(_cartModel, null);
                            showCustomSnackBar(getTranslated('added_to_cart', context), context, isError: false);
                          }

                          _cartProvider.setQuantity(true, _cartModel, 50, context, true, _cartProvider.getCartProductIndex(_cartModel, false, null) );

                        } ,child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.rectangle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.add, size: 25,color: Colors.white,),
                          ),
                        ),
                      ),
                    ]),
                  ),
/*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${PriceConverter.convertPrice(context, _startingPrice, discount: offerProduct.offerProductList[index].discount,
                              discountType: offerProduct.offerProductList[index].discountType, asFixed: 1)}''${_endingPrice!= null
                              ? ' - ${PriceConverter.convertPrice(context, _endingPrice, discount: offerProduct.offerProductList[index].discount,
                              discountType: offerProduct.offerProductList[index].discountType, asFixed: 1)}' : ''}',
                          style: rubikBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                        ),
                      ),
                      _discount > 0 ? SizedBox() : Icon(Icons.add, color: Theme.of(context).textTheme.bodyText1.color),
                    ],
                  ),
                  _discount > 0 ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Flexible(
                      child: Text(
                        '${PriceConverter.convertPrice(context, _startingPrice, asFixed: 1)}'
                            '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, asFixed: 1)}' : ''}',
                        style: rubikBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                          color: ColorResources.COLOR_GREY,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                    Icon(Icons.add, color: Theme.of(context).textTheme.bodyText1.color),
                  ]) : SizedBox(),*/
                ]),
              ),
            ),

          ]),
        ),
      ),
    );
       /* : Padding(
        padding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              Routes.getProductDetailsRoute(product.id),
              arguments: ProductDetailsScreen(product: product),
            );
          },
          child: Container(
            height: 85,
            padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [Provider.of<ThemeProvider>(context).darkTheme ? BoxShadow() :BoxShadow(
                color: Colors.grey[300],
                blurRadius: 5, spreadRadius: 1,
              )],
            ),
            child: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder(context),
                  image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${product.image[0]}',
                  height: 70, width: 85, fit: BoxFit.cover,
                  imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder(context), height: 70, width: 85,  fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(product.name, style: rubikMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 10),
                  Text(
                    '${PriceConverter.convertPrice(context, _startingPrice, discount: product.discount, discountType: product.discountType, asFixed: 1)}'
                        '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, discount: product.discount,
                        discountType: product.discountType, asFixed: 1)}' : ''}',
                    style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
                  ),
                  product.price > _discountedPrice ? Text('${PriceConverter.convertPrice(context, _startingPrice, asFixed: 1)}'
                      '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, asFixed: 1)}' : ''}', style: rubikMedium.copyWith(
                    color: ColorResources.COLOR_GREY,
                    decoration: TextDecoration.lineThrough,
                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                  )) : SizedBox(),
                ]),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Icon(Icons.add),
                Expanded(child: SizedBox()),
                RatingBar(rating: product.rating.length > 0 ? double.parse(product.rating[0].average) : 0.0, size: 10),
              ]),
            ]),
        ),
      ),
    );*/
  }
}
