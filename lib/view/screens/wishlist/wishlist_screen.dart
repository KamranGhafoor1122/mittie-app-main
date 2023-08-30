import 'package:emarket_user/data/model/response/cart_model.dart';
import 'package:emarket_user/data/model/response/product_model.dart';
import 'package:emarket_user/helper/price_converter.dart';
import 'package:emarket_user/provider/cart_provider.dart';
import 'package:emarket_user/provider/localization_provider.dart';
import 'package:emarket_user/provider/product_provider.dart';
import 'package:emarket_user/provider/splash_provider.dart';
import 'package:emarket_user/provider/theme_provider.dart';
import 'package:emarket_user/utill/color_resources.dart';
import 'package:emarket_user/utill/images.dart';
import 'package:emarket_user/utill/styles.dart';
import 'package:emarket_user/view/base/custom_snackbar.dart';
import 'package:emarket_user/view/base/footer_web_view.dart';
import 'package:emarket_user/view/base/product_shimmer.dart';
import 'package:emarket_user/view/base/rating_bar.dart';
import 'package:emarket_user/view/base/web_header/web_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:emarket_user/helper/responsive_helper.dart';
import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/provider/auth_provider.dart';
import 'package:emarket_user/provider/wishlist_provider.dart';
import 'package:emarket_user/utill/dimensions.dart';
import 'package:emarket_user/view/base/custom_app_bar.dart';
import 'package:emarket_user/view/base/no_data_screen.dart';
import 'package:emarket_user/view/base/not_logged_in_screen.dart';
import 'package:emarket_user/view/base/product_widget.dart';
import 'package:provider/provider.dart';

import '../../../utill/routes.dart';
import '../product/product_details_screen.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {



  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final bool _isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    return Consumer<WishListProvider>(
      builder:(ctx,wishListProvider,child)=> Scaffold(
        appBar:ResponsiveHelper.isDesktop(context)? PreferredSize(child: WebAppBar(), preferredSize: Size.fromHeight(120)) : CustomAppBar(title: "${getTranslated('my_favourite', context)} ${wishListProvider.wishList != null ? "(${wishListProvider.wishList.length})":""}", isBackButtonExist: true,onBackPressed: (){
          Navigator.of(context).pushReplacementNamed(
            Routes.getDashboardRoute("home"),
          );

        },),
        body: _isLoggedIn ? SingleChildScrollView(
          child: Column(
            children: [
              Consumer<WishListProvider>(
                builder: (context, wishlistProvider, child) {
                  return wishlistProvider.isLoading  ?
                  Center(
                    child: SizedBox(
                      width: Dimensions.WEB_SCREEN_WIDTH,
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: ResponsiveHelper.isDesktop(context) ? 13 : 5,
                          mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? 13 : 5,
                          childAspectRatio: ResponsiveHelper.isDesktop(context) ? (1/1.4) : 4,
                          crossAxisCount: ResponsiveHelper.isDesktop(context) ? 5 : ResponsiveHelper.isTab(context) ? 2 : 1,
                        ),
                        itemBuilder: (context, index) {
                          return ProductShimmer(isEnabled: wishlistProvider.wishIdList == null,isWeb:  ResponsiveHelper.isDesktop(context) ? true : false);
                        },
                      ),
                    ),
                  ) : wishlistProvider.wishIdList.length > 0 ?
                  RefreshIndicator(
                    onRefresh: () async {
                      await Provider.of<WishListProvider>(context, listen: false).initWishList(
                        context, Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,
                      );
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Center(
                          child: Container(
                            constraints: BoxConstraints(minHeight: !ResponsiveHelper.isDesktop(context) && _height < 600 ? _height : _height - 400),
                            width: Dimensions.WEB_SCREEN_WIDTH,
                            child:
                            ListView.builder(
                           /*   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: ResponsiveHelper.isDesktop(context) ? 13 : 5,
                                  mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? 13 : 5,
                                  childAspectRatio: ResponsiveHelper.isDesktop(context) ? (1/1.4) : 0.65,
                                  crossAxisCount: ResponsiveHelper.isDesktop(context) ? 5 : ResponsiveHelper.isTab(context) ? 2 : 1),*/
                              itemCount: wishlistProvider.wishList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                              itemBuilder: (context, index) {
                                return favouriteWidget(wishlistProvider.wishList[index]);
                              },
                            ),
                        ),
                      ),
                    ),
                   )
                  )
                   : NoDataScreen();
                },
              ),
              if(ResponsiveHelper.isDesktop(context)) FooterView(),
            ],
          ),
        ) : NotLoggedInScreen(),
      ),
    );
  }


  Widget favouriteWidget(Product product){

    int _stock = 0;
    List _tabChildren;
    double priceWithQuantity;
    bool isExistInCart = false;
    CartModel _cartModel;
    List _variationList;
    Variation _variation = Variation();
    final productProvider = Provider.of<ProductProvider>(context,listen: false);
    final _cartProvider = Provider.of<CartProvider>(context,listen: false);


    _variationList = [];
   /* for(int index=0; index < product.choiceOptions.length; index++) {
      _variationList.add(product.choiceOptions[index].options[productProvider.variationIndex[index]].replaceAll(' ', ''));
    }*/
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
       1, price - PriceConverter.convertWithDiscount(context, price, product.tax, product.taxType),
      _stock, product,
    );
    isExistInCart = Provider.of<CartProvider>(context).isExistInCart(_cartModel, false, null);
    if(isExistInCart) {
      priceWithQuantity = priceWithDiscount * _cartProvider.cartList[_cartProvider.getCartProductIndex(_cartModel, false, null)].quantity;
    }else {
      priceWithQuantity = priceWithDiscount * 1;
    }



    double _startingPrice;
    double _endingPrice;
    if(product.variations.length != 0) {
      List<double> _priceList = [];
      product.variations.forEach((variation) => _priceList.add(variation.price));
      _priceList.sort((a, b) => a.compareTo(b));
      _startingPrice = _priceList[0];
      if(_priceList[0] < _priceList[_priceList.length-1]) {
        _endingPrice = _priceList[_priceList.length-1];
      }
    }else {
      _startingPrice = product.price;

    }


    isExistInCart = Provider.of<CartProvider>(context).existInCart(product);

    double _discountedPrice = PriceConverter.convertWithDiscount(context, product.price, product.discount, product.discountType);

    return Container(
      margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_DEFAULT),
      child:  GestureDetector(
        onTap: (){
          Navigator.of(context).pushNamed(
            Routes.getProductDetailsRoute(product.id),
            arguments: ProductDetailsScreen(product: product),
          );
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL, horizontal: Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(
                  color: Colors.grey[Provider.of<ThemeProvider>(context).darkTheme ? 700 : 300],
                  blurRadius: 5, spreadRadius: 1,
                )],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 10,),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage.assetNetwork(
                            placeholder: Images.placeholder(context),
                            image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productImageUrl}/${product.image[0]}',
                            height: 60, width: 60, fit: BoxFit.cover,
                            imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder(context),  fit: BoxFit.cover, height: 70, width: 85),
                          ),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_SMALL),

                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                            Row(
                              children: [
                                Expanded(child: Text(product.name, style: rubikMedium, maxLines: 2, overflow: TextOverflow.ellipsis)),

                                InkWell(
                                  onTap: (){
                                    //Provider.of<CartProvider>(context, listen: false).removeFromCart(cart);

                                    Provider.of<WishListProvider>(context,listen: false).removeFromWishList(product, (message) {
                                      showCustomSnackBar(message, context, isError: true);
                                    });
                                  },
                                  child: Image.asset("assets/image/delete.png",height: 25,width: 25,),
                                )
                              ],
                            ),

                            /* SizedBox(height: 2),
                          RatingBar(rating: cart.product.rating.length > 0 ? double.parse(cart.product.rating[0].average) : 0.0, size: 12),
                         */


                            // RatingBar(rating: offerProduct.offerProductList[_currentIndex].rating.length > 0 ? double.parse(offerProduct.offerProductList[_currentIndex].rating[0].average) : 0.0, size: Dimensions.PADDING_SIZE_DEFAULT),
                            RatingBar(rating: product.rating.length > 0 ? double.parse(product.rating[0].average) : 0.0, size: 10),

                            SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),


                            product.price > _discountedPrice ? Text(
                                '${PriceConverter.convertPrice(context, _startingPrice, asFixed: 1)}'
                                    '${_endingPrice!= null ? ' - ${PriceConverter.convertPrice(context, _endingPrice, asFixed: 1)}' : ''}',
                                style: TextStyle(decoration: TextDecoration.lineThrough,fontWeight: FontWeight.w500,
                                color: Colors.black,fontSize: 14
                                )
                            ): SizedBox(),



                            Row(
                              children: [
                                Expanded(
                                  child:  Text(
                                    '${PriceConverter.convertPrice(context, _startingPrice, discount: product.discount,
                                        discountType: product.discountType, asFixed: 1)}''${_endingPrice!= null
                                        ? ' - ${PriceConverter.convertPrice(context, _endingPrice, discount: product.discount,
                                        discountType: product.discountType, asFixed: 1)}' : ''}',
                                    style: rubikBold.copyWith(fontSize: 14, color: Colors.black,fontWeight: FontWeight.w500),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    if(!isExistInCart){
                                      Provider.of<CartProvider>(context, listen: false).addToCart(_cartModel, null);
                                      showCustomSnackBar(getTranslated('added_to_cart', context), context, isError: false);
                                       setState(() {
                                       });
                                      }
                                    },
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffc8edd9),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 7),
                                    child: Row(
                                      children: [
                                        Icon(Icons.shopping_cart,color: Theme.of(context).primaryColor,),
                                        SizedBox(width: 7,),
                                        Text(isExistInCart? "Added in cart":"Add to cart",style: TextStyle(
                                          color: Color(0xff26742b),
                                          fontSize: 14
                                        ),)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ) ,




                            SizedBox(
                              height: 15,
                            ),


                          ]),
                        ),





                      ]),

                ],
              ),
            ),
      ),
    );
  }
}
