import 'package:emarket_user/provider/category_provider.dart';
import 'package:emarket_user/provider/localization_provider.dart';
import 'package:emarket_user/provider/splash_provider.dart';
import 'package:emarket_user/utill/app_constants.dart';
import 'package:emarket_user/view/screens/auth/pages/login_page.dart';
import 'package:emarket_user/view/screens/category/category_screen.dart';
import 'package:emarket_user/view/screens/field_officers/fied_officers.dart';
import 'package:flutter/material.dart';
import 'package:emarket_user/helper/responsive_helper.dart';
import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/provider/auth_provider.dart';
import 'package:emarket_user/utill/dimensions.dart';
import 'package:emarket_user/utill/images.dart';
import 'package:emarket_user/utill/routes.dart';
import 'package:emarket_user/utill/styles.dart';
import 'package:emarket_user/view/screens/menu/widget/sign_out_confirmation_dialog.dart';
import 'package:provider/provider.dart';

import '../../../base/custom_dialog.dart';
import 'acount_delete_dialog.dart';

class OptionsView extends StatelessWidget {
  final Function onTap;
  OptionsView({@required this.onTap});

  @override
  Widget build(BuildContext context) {

    final _authProvider = Provider.of<AuthProvider>(context, listen: false);
    final _policyModel = Provider.of<SplashProvider>(context, listen: false).policyModel;

    return Scrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        child: Center(
          child: SizedBox(
            width: ResponsiveHelper.isTab(context) ? null : 1170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ResponsiveHelper.isTab(context) ? 50 : 0),

               /* SwitchListTile(
                  value: Provider.of<ThemeProvider>(context).darkTheme,
                  onChanged: (bool isActive) =>Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                  title: Text(getTranslated('dark_theme', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                  activeColor: Theme.of(context).primaryColor,
                ),*/

                ResponsiveHelper.isTab(context) ? ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getDashboardRoute('home')),
                  leading: Image.asset(Images.home, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('home', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ) : SizedBox(),

                /*ListTile(
                  onTap: () => ResponsiveHelper.isMobilePhone() ? onTap(2) : Navigator.pushNamed(context, Routes.getDashboardRoute('order')),
                  leading: Image.asset(Images.order, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('my_order', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),*/


                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Container(
                       decoration: BoxDecoration(
                         color: Theme.of(context).primaryColor,
                       ),
                       padding: EdgeInsets.symmetric(
                         horizontal: 17,
                         vertical: 5
                       ),
                       child: InkWell(
                         onTap: (){
                           Provider.of<SplashProvider>(context, listen: false).disableLang();
                           Provider.of<LocalizationProvider>(context, listen: false).setLanguage(Locale(
                             AppConstants.languages[0].languageCode,
                             AppConstants.languages[0].countryCode,
                           ));
                         },
                         child: Text(
                           "English",
                           style: TextStyle(
                             color: Colors.white
                           ),
                         ),
                       ),
                     ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 5
                      ),
                      child: InkWell(
                        onTap: () {
                          Provider.of<SplashProvider>(context, listen: false).disableLang();
                            Provider.of<LocalizationProvider>(context, listen: false).setLanguage(Locale(
                              AppConstants.languages[1].languageCode,
                              AppConstants.languages[1].countryCode,
                            ));

                        },
                        child: Text("اردو",
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 15,),


                ListTile(
                  onTap: () =>  Navigator.pushNamed(context, Routes.getProfileRoute()),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                  leading: Image.asset(Images.profile, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('profile', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),
                Divider(
                  thickness: 0.4,
                  color: Colors.grey,
                ),

                ListTile(
                  onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>FieldOfficers())),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                  leading: Image.asset(Images.profile, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('field_officer', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),
                Divider(
                  thickness: 0.4,
                  color: Colors.grey,
                ),

                Consumer<CategoryProvider>(
                  builder: (ctx,categoryProvider,child){
                    return categoryProvider.categoryList == null ? Container():Column(
                      children: categoryProvider.categoryList.map((e) => Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(
                                context, Routes.getCategoryRoute(e.id),
                                arguments: CategoryScreen(categoryModel: e),
                              );
                            },
                            trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.grey,),
                            leading: FadeInImage.assetNetwork(
                              placeholder: Images.placeholder(context),
                              image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryImageUrl}/${e.image}',
                              width: 20, height: 20, fit: BoxFit.cover,
                              imageErrorBuilder: (c,o,t)=> Image.asset(Images.placeholder(context),width: 65, height: 65, fit: BoxFit.cover,),
                            ),

                            title: Text(e.name, style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                          ),
                          Divider(
                            thickness: 0.4,
                            color: Colors.grey,
                          )
                        ],
                      )
                      ).toList(),
                    );
                  },
                ),


                /*ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getAddressRoute()),
                  leading: Image.asset(Images.address, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('address', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),//////
                ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getChatRoute()),
                  leading: Image.asset(Images.message, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('message', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getCouponRoute()),
                  leading: Image.asset(Images.coupon, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('coupon', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getLanguageRoute('menu')),
                  leading: Image.asset(Images.language, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('language', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getSupportRoute()),
                  leading: Image.asset(Images.help_support, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('help_and_support', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getPolicyRoute()),
                  leading: Image.asset(Images.privacy_policy, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('privacy_policy', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),
               ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getTermsRoute()),
                  leading: Image.asset(Images.terms_and_condition, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('terms_and_condition', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),
               if(_policyModel != null && _policyModel.returnPage != null && _policyModel.returnPage.status) ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getReturnPolicyRoute()),
                  leading: Image.asset(Images.returnPolicy, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('return_policy', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),

                if(_policyModel != null && _policyModel.refundPage != null  && _policyModel.refundPage.status) ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getRefundPolicyRoute()),
                  leading: Image.asset(Images.refundPolicy, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('refund_policy', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),
                if(_policyModel != null && _policyModel.cancellationPage != null  && _policyModel.cancellationPage.status) ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getCancellationPolicyRoute()),
                  leading: Image.asset(Images.cancellationPolicy, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('cancellation_policy', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, Routes.getAboutUsRoute()),
                  leading: Image.asset(Images.about_us, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated('about_us', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),*/
                /*ListTile(
                  leading: Image.asset(Images.version, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text('${getTranslated('version', context)}', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                  trailing: Text('${Provider.of<SplashProvider>(context, listen: false).configModel.softwareVersion ?? ''}', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                    //
                ),*/
                _authProvider.isLoggedIn() ? ListTile(
                  onTap: () {
                    showAnimatedDialog(context,
                        AccountDeleteDialog(
                          icon: Icons.question_mark_sharp,
                          title: getTranslated('are_you_sure_to_delete_account', context),
                          description: getTranslated('it_will_remove_your_all_information', context),
                          onTapFalseText:getTranslated('no', context),
                          onTapTrueText: getTranslated('yes', context),
                          isFailed: true,
                          onTapFalse: () => Navigator.of(context).pop(),
                          onTapTrue: () => _authProvider.deleteUser(context),
                        ),
                        dismissible: false,
                        isFlip: true);
                  },
                  leading: Icon(Icons.delete, size: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                  title: Text(getTranslated('delete_account', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ) : SizedBox(),


                _authProvider.isLoggedIn() ?
                Divider(
                  thickness: 0.4,
                  color: Colors.grey,
                ):SizedBox(),


                ListTile(
                  onTap: () {
                    if(_authProvider.isLoggedIn()) {
                      showDialog(context: context, barrierDismissible: false, builder: (context) => SignOutConfirmationDialog());
                    }else {
                     // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>LoginScreen()));
                      Navigator.pushNamed(context, Routes.getLoginRoute());
                    }
                  },
                  trailing: Icon(Icons.arrow_forward_ios,color: Colors.grey,),
                  leading: Image.asset(Images.login, width: 20, height: 20, color: Theme.of(context).textTheme.bodyText1.color),
                  title: Text(getTranslated(_authProvider.isLoggedIn() ? 'logout' : 'login', context), style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                ),
                Divider(
                  thickness: 0.4,
                  color: Colors.grey,
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
