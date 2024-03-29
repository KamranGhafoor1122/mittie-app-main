import 'package:emarket_user/helper/responsive_helper.dart';
import 'package:emarket_user/view/screens/accounts/account_page.dart';
import 'package:flutter/material.dart';
import 'package:emarket_user/helper/network_info.dart';
import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/provider/cart_provider.dart';
import 'package:emarket_user/utill/color_resources.dart';
import 'package:emarket_user/utill/styles.dart';
import 'package:emarket_user/view/screens/cart/cart_screen.dart';
import 'package:emarket_user/view/screens/home/home_screen.dart';
import 'package:emarket_user/view/screens/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

import '../../../provider/splash_provider.dart';

class DashboardScreen extends StatefulWidget {
  final int pageIndex;
  DashboardScreen({@required this.pageIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController;
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    final _splashProvider = Provider.of<SplashProvider>(context, listen: false);
    if(_splashProvider.policyModel == null) {
      Provider.of<SplashProvider>(context, listen: false).getPolicyPage(context);
    }
    _pageIndex = widget.pageIndex;
    _pageController = PageController(initialPage: widget.pageIndex);
    _screens = [
      HomeScreen(),
      WishListScreen(),
      CartScreen(),
      AccountPage(),
    //  OrderScreen(),
      /*MenuScreen(onTap: (int pageIndex) {
        _setPage(pageIndex);
      }),*/
    ];

    if(ResponsiveHelper.isMobilePhone()) {
      NetworkInfo.checkConnectivity(_scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: ResponsiveHelper.isMobile(context) ?  BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: ColorResources.COLOR_GREY,
          showUnselectedLabels: false,
          currentIndex: _pageIndex,
          showSelectedLabels: false,

          type: BottomNavigationBarType.fixed,
          items: [
            _barItem(Icons.home, getTranslated('home', context), 0),
            _barItem(Icons.favorite, getTranslated('favourite', context), 1),
            _barItem(Icons.shopping_cart, getTranslated('cart', context), 2),
            _barItem(Icons.person, getTranslated('order', context), 3),
           // _barItem(Icons.menu, getTranslated('menu', context), 4)
          ],
          onTap: (int index) {
            _setPage(index);
          },
        ) : SizedBox(),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none, children: [
          Icon(icon, color: index == _pageIndex ? Theme.of(context).primaryColor : ColorResources.COLOR_GREY, size: 30),
          index == 2 ?
          Positioned(
            top: -7, right: -7,
            child: Container(
              padding: EdgeInsets.all(4),
              alignment: Alignment.center,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              child: Text(
                Provider.of<CartProvider>(context).cartList.length.toString(),
                style: rubikMedium.copyWith(color: ColorResources.COLOR_WHITE, fontSize: 8),
              ),
            ),
          )
              : SizedBox(),
        ],
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
