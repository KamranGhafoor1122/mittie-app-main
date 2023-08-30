
import 'package:emarket_user/data/model/response/userinfo_model.dart';
import 'package:emarket_user/helper/responsive_helper.dart';
import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/provider/auth_provider.dart';
import 'package:emarket_user/provider/profile_provider.dart';
import 'package:emarket_user/provider/splash_provider.dart';
import 'package:emarket_user/utill/dimensions.dart';
import 'package:emarket_user/utill/images.dart';
import 'package:emarket_user/utill/routes.dart';
import 'package:emarket_user/utill/styles.dart';
import 'package:emarket_user/view/base/not_logged_in_screen.dart';
import 'package:emarket_user/view/screens/drawer/drawer_widget.dart';
import 'package:emarket_user/view/screens/menu/widget/options_view.dart';
import 'package:emarket_user/view/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:emarket_user/view/screens/order/order_screen.dart';
import 'package:emarket_user/view/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoggedIn;
  UserInfoModel _userInfoModel;



  @override
  void initState() {
    // TODO: implement initState
    _isLoggedIn = Provider.of<AuthProvider>(context, listen: false).isLoggedIn();
    if(_isLoggedIn ) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context).then((value) {
         _userInfoModel = Provider.of<ProfileProvider>(context, listen: false).userInfoModel;
         setState(() {
         });
      });
    }
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ResponsiveHelper.isTab(context) ? Drawer(child: OptionsView(onTap: null)) : DrawerWidget(
        onTap: (){},
      ),
      key: _scaffoldKey,
      body: _isLoggedIn ? _userInfoModel == null ? Center(child: CircularProgressIndicator(),):SingleChildScrollView(
         child: Stack(
           children: [
             Align(
             alignment: Alignment.topCenter,
               child: Container(
                 width: double.infinity,
                 height: MediaQuery.of(context).size.height*0.30,
                 color: Theme.of(context).primaryColor,
               ),
             ),

             Padding(
               padding: const EdgeInsets.all(15.0),
               child: Positioned.fill(child: Column(
                 children: [
                     SizedBox(height: 20,),
                     Row(
                       children: [

                         IconButton(onPressed: (){
                           _scaffoldKey.currentState.openDrawer();
                         }, icon: Icon(Icons.dehaze_rounded,color: Colors.white,)),

                          SizedBox(width: 10,),
                          Text(getTranslated("account", context),style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                          ),)
                       ],
                     ),

                   SizedBox(
                     height: 30,
                   ),
                   Card(
                     elevation: 10,
                     shadowColor: Colors.white,
                     color: Colors.white,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10)
                     ),
                     child: Container(
                       width: double.infinity,
                       padding: EdgeInsets.symmetric(vertical: 20),
                       child: _userInfoModel != null ?
                         Center(
                           child: Column(
                             children: [
                                 Container(
                                   height: 150,
                                   width: 150,
                                   decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     border: Border.all(
                                       color: Colors.grey,
                                       width: 2
                                     )
                                   ),
                                   child:
                                   _userInfoModel.image != null && _userInfoModel.image.isNotEmpty?
                                    CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage("${Provider.of<SplashProvider>(context, listen: false).baseUrls.customerImageUrl}/"
                                          "${_userInfoModel != null ? _userInfoModel.image : ''}"),
                                    )
                                   :Center(
                                      child: Icon(Icons.image,color: Colors.grey,size: 95,),
                                   ),
                                 ),

                               SizedBox(
                                 height: 15,
                               ),
                               Text("${_userInfoModel.fName} ${_userInfoModel.lName}",style: TextStyle(
                                 fontWeight: FontWeight.w700,
                                 color: Colors.black,
                                 fontSize: 18
                               ),),

                               SizedBox(
                                 height: 5,
                               ),
                               Text("${_userInfoModel.phone}",style: TextStyle(
                                   fontWeight: FontWeight.w700,
                                   color: Colors.black,
                                   fontSize: 18
                               ),),
                             ],
                           ),
                         ):Container(),
                     ),
                   ),


                   ListTile(
                     onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>OrderScreen()));
                     },
                     //trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                     trailing: Image.asset(Images.order, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                     title: Text(getTranslated('my_order', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                   ),
                   Divider(
                     thickness: 0.4,
                     color: Colors.grey,
                   ),

                   ListTile(
                     onTap: (){
                       //Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Shpi()));
                     },
                    // trailing: Icon(Icons.favorite,color: Colors.grey,),
                     trailing: Image.asset(Images.fav, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                     title: Text(getTranslated('shipping_address', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                   ),



                   Divider(
                     thickness: 0.4,
                     color: Colors.grey,
                   ),

                   ListTile(
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ProfileScreen()));
                     },
                     // trailing: Icon(Icons.favorite,color: Colors.grey,),
                     trailing: Icon(Icons.person,color: Colors.black,size: 30,),
                     title: Text(getTranslated('account_info', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                   ),


                   Divider(
                     thickness: 0.4,
                     color: Colors.grey,
                   ),


                   ListTile(
                     onTap: () {
                       if(_isLoggedIn) {
                         showDialog(context: context, barrierDismissible: false, builder: (context) => SignOutConfirmationDialog());
                       }else {
                         // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>LoginScreen()));
                         Navigator.pushNamed(context, Routes.getLoginRoute());
                       }
                     },
                    // trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                     trailing: Image.asset(Images.login, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                     title: Text(getTranslated(_isLoggedIn ? 'logout' : 'login', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                   ),

                 ],
               )),
             ),




           ],
         ),
       ):NotLoggedInScreen(),
    );
  }
}
