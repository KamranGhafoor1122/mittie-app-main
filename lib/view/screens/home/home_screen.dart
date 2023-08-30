
import 'package:emarket_user/helper/product_type.dart';
import 'package:emarket_user/helper/responsive_helper.dart';
import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/provider/auth_provider.dart';
import 'package:emarket_user/provider/banner_provider.dart';
import 'package:emarket_user/provider/brands_provider.dart';
import 'package:emarket_user/provider/cart_provider.dart';
import 'package:emarket_user/provider/category_provider.dart';
import 'package:emarket_user/provider/localization_provider.dart';
import 'package:emarket_user/provider/product_provider.dart';
import 'package:emarket_user/provider/profile_provider.dart';
import 'package:emarket_user/provider/splash_provider.dart';
import 'package:emarket_user/utill/app_constants.dart';
import 'package:emarket_user/utill/color_resources.dart';
import 'package:emarket_user/utill/dimensions.dart';
import 'package:emarket_user/utill/images.dart';
import 'package:emarket_user/utill/routes.dart';
import 'package:emarket_user/utill/styles.dart';
import 'package:emarket_user/view/base/title_widget.dart';
import 'package:emarket_user/view/screens/brands/brands.dart';
import 'package:emarket_user/view/screens/drawer/drawer_widget.dart';
import 'package:emarket_user/view/screens/home/widget/banner_view.dart';
import 'package:emarket_user/view/screens/home/widget/category_view.dart';
import 'package:emarket_user/view/screens/home/widget/main_slider.dart';
import 'package:emarket_user/view/screens/home/widget/offer_product_view.dart';
import 'package:emarket_user/view/screens/home/widget/product_view.dart';
import 'package:emarket_user/view/screens/menu/widget/options_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base/footer_web_view.dart';
import '../../base/web_header/web_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> drawerGlobalKey = GlobalKey();


  Future<void> _loadData(BuildContext context, bool reload) async {
    Provider.of<BrandsProvider>(context,listen: false).getBrands();
    Provider.of<SplashProvider>(context, listen: false).getPolicyPage(context);
    if(Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      await Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
    }
     Provider.of<CategoryProvider>(context, listen: false).getCategoryList(
      context, true, Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,
    );
     Provider.of<BannerProvider>(context, listen: false).getBannerList(context, reload);
     Provider.of<ProductProvider>(context, listen: false).getOfferProductList(
      context, true, Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,
    );
    Provider.of<ProductProvider>(context, listen: false).getPopularProductList(
      context, '1', true, Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,
    );
  }




  @override
  void initState() {
    _loadData(context, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return SafeArea(
      child: Scaffold(
        key: drawerGlobalKey,
        endDrawerEnableOpenDragGesture: false,
        backgroundColor: ResponsiveHelper.isDesktop(context)? ColorResources.getWhiteAndBlackColor(context) : ColorResources.getBackgroundColor(context),
        drawer: ResponsiveHelper.isTab(context) ? Drawer(child: OptionsView(onTap: null)) : DrawerWidget(
          onTap: (){},
        ),
        appBar: ResponsiveHelper.isDesktop(context)? PreferredSize(child: WebAppBar(), preferredSize: Size.fromHeight(120))  : null,
        body: RefreshIndicator(
          onRefresh: () async {
            Provider.of<ProductProvider>(context, listen: false).offset = 1;
            await _loadData(context, true);
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Scrollbar(
            controller: _scrollController,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // App Bar
                ResponsiveHelper.isDesktop(context) ? SliverToBoxAdapter(child: SizedBox()) : SliverAppBar(
                  floating: true,
                  elevation: 0,
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).cardColor,
                  pinned: ResponsiveHelper.isTab(context) ? true : false,
                  leading: ResponsiveHelper.isTab(context) ? IconButton(
                    onPressed: () => drawerGlobalKey.currentState.openDrawer(),
                    icon: Icon(Icons.menu,color: Colors.black),
                  ): IconButton(
                    onPressed: () => drawerGlobalKey.currentState.openDrawer(),
                    icon: Icon(Icons.menu,color: Colors.black),
                  ),
                  title: Consumer<SplashProvider>(builder:(context, splash, child) => SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        Center(
                          child:  Image.asset(Images.logo, width: 55, height: 55),
                        ),

                      ],
                    ),
                  )),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: InkWell(
                          onTap: ()=> Navigator.pushNamed(context, Routes.getSearchRoute()),
                          child: Image.asset("assets/image/search.png",height: 25,width: 25,)),
                    ),
                    /*IconButton(
                      onPressed: () => Navigator.pushNamed(context, Routes.getNotificationRoute()),
                      icon: Icon(Icons.notifications, color: Theme.of(context).textTheme.bodyText1.color),
                    ),*/
                    ResponsiveHelper.isTab(context) ? IconButton(
                      onPressed: () => Navigator.pushNamed(context, Routes.getDashboardRoute('cart')),
                      icon: Stack(


                        clipBehavior: Clip.none,
                        children: [
                          Icon(Icons.shopping_cart, color: Theme.of(context).textTheme.bodyText1.color),
                          Positioned(
                            top: -7, right: -7,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                              child: Center(
                                child: Text(
                                  Provider.of<CartProvider>(context).cartList.length.toString(),
                                  style: rubikMedium.copyWith(color: Colors.white, fontSize: 8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) : SizedBox(),
                  ],
                ),

                // Search Button
              /*  ResponsiveHelper.isDesktop(context) ? SliverToBoxAdapter(child: SizedBox()) : SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(child: Center(
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, Routes.getSearchRoute()),
                      child: Container(
                        height: 60, width: 1170,
                        color: Theme.of(context).cardColor,
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(color: ColorResources.getSearchBg(context), borderRadius: BorderRadius.circular(10)),
                          child: Row(children: [
                            Padding(padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL), child: Icon(Icons.search, size: 25)),
                            Expanded(child: Text(getTranslated('search_items_here', context), style: rubikRegular.copyWith(fontSize: 12))),
                          ]),
                        ),
                      ),
                    ),
                  )),
                ),*/

                SliverToBoxAdapter(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: ResponsiveHelper.isDesktop(context) ? MediaQuery.of(context).size.height -560 : MediaQuery.of(context).size.height),
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            width: Dimensions.WEB_SCREEN_WIDTH,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                              ResponsiveHelper.isDesktop(context) ? Padding(
                                padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                                child: MainSlider(),
                              ):  SizedBox(),

                              Consumer<CategoryProvider>(
                                builder: (context, category, child) {
                                  return category.categoryList == null ? CategoryView() : category.categoryList.length == 0 ? SizedBox() : CategoryView();
                                },
                              ),

                              ResponsiveHelper.isDesktop(context) ? SizedBox() : Consumer<BannerProvider>(
                                builder: (context, banner, child) {
                                  return banner.bannerList == null ? BannerView() : banner.bannerList.length == 0 ? SizedBox() : BannerView();
                                },
                              ) ,




                              SizedBox(
                                height: 20,
                              ),

                             /* InkWell(
                                onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (ctx)=>FieldOfficers()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(getTranslated('field_officer', context),style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getBlackAndWhiteColor(context))),
                                     // Text(getTranslated('view_all', context),style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getBlackAndWhiteColor(context))),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 7,
                              ),

                              Consumer<FieldOfficersProvider>(
                                builder:(ctx,fieldOfficerProvider,child) => Container(
                                  height: 150,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child:
                                  fieldOfficerProvider.fieldOfficersList == null ? Center(
                                    child: CircularProgressIndicator(),
                                  ):
                                      fieldOfficerProvider.fieldOfficersList.isEmpty ? Center(
                                        child: Text(getTranslated("no_data_found", context),style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black
                                        ),),
                                      ):
                                  ListView.separated(
                                      separatorBuilder: (ctx,index)=>SizedBox(width: 10,),
                                      itemCount: fieldOfficerProvider.fieldOfficersList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                      (ctx,index)=>Container(

                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                                        child: Column(
                                          children: [
                                            fieldOfficerProvider.fieldOfficersList[index].image !=null ? Image.asset("assets/image/person.png",height: 100,width: 100,fit: BoxFit.cover,):
                                            Image.network("${AppConstants.IMAGE_URL}/fieldOfficer/${fieldOfficerProvider.fieldOfficersList[index].image}"),
                                               SizedBox(height: 5,),
                                               Text("${fieldOfficerProvider.fieldOfficersList[index].name}",style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getBlackAndWhiteColor(context))),
                                          ],
                                        ),
                                    ),
                                  )),
                                ),
                              ),



                              SizedBox(
                                height: 20,
                              ),*/

                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Brands()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(getTranslated('brands', context),style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getBlackAndWhiteColor(context))),
                                     // Text(getTranslated('view_all', context),style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getBlackAndWhiteColor(context))),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 7,
                              ),

                              Consumer<BrandsProvider>(
                                builder:(ctx,brandsProvider,child) =>
                                    Container(
                                  height: 155,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child:
                                  brandsProvider.brandsList == null ? Center(
                                    child: CircularProgressIndicator(),
                                  ):
                                  brandsProvider.brandsList.isEmpty ? Container():
                                  ListView.separated(
                                      separatorBuilder: (ctx,index)=>SizedBox(width: 10,),
                                      itemCount: brandsProvider.brandsList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (ctx,index)=>Container(

                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 110,
                                                      width: 110,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.rectangle,
                                                        borderRadius: BorderRadius.circular(17),
                                                        border: Border.all(color: Colors.grey.withOpacity(0.5),width: 2)
                                                      ),
                                                      padding: EdgeInsets.all(10),
                                                      child:
                                                      brandsProvider.brandsList[index].image == null ?
                                                      Image.asset("assets/image/brand.jpg",height: 60,width: 60,fit: BoxFit.cover,):
                                                    Image.network("${AppConstants.IMAGE_URL}/brand/${brandsProvider.brandsList[index].image}",height: 60,width: 60,fit: BoxFit.cover,)),
                                                  SizedBox(height: 10,),
                                                  Text("${brandsProvider.brandsList[index].name}",style: rubikMedium.copyWith(fontSize: 14,fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor)),
                                                ],
                                              ),
                                            ),
                                          )),
                                ),
                              ),
                              Consumer<ProductProvider>(
                                builder: (context, offerProduct, child) {
                                  return offerProduct.offerProductList == null ? OfferProductView() : offerProduct.offerProductList.length == 0
                                      ? SizedBox() : OfferProductView();
                                },
                              ),



                              ResponsiveHelper.isDesktop(context) ?
                              Padding(
                                padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_EXTRA_LARGE,bottom: Dimensions.PADDING_SIZE_LARGE),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(getTranslated('popular_item', context),style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_THIRTY, color: ColorResources.getBlackAndWhiteColor(context))),
                                ),
                              )
                                  : Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                                child: TitleWidget(title: getTranslated('popular_item', context)),
                              ),
                              ProductView(productType: ProductType.POPULAR_PRODUCT, scrollController: _scrollController),
                            ]),
                          ),
                        ),
                        ResponsiveHelper.isDesktop(context) ? FooterView() : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 || oldDelegate.minExtent != 50 || child != oldDelegate.child;
  }
}
