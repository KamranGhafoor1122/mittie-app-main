
import 'package:country_code_picker/country_code.dart';
import 'package:emarket_user/helper/responsive_helper.dart';
import 'package:emarket_user/provider/localization_provider.dart';
import 'package:emarket_user/provider/splash_provider.dart';
import 'package:emarket_user/theme/app_colors.dart';
import 'package:emarket_user/utill/routes.dart';
import 'package:emarket_user/utill/styles.dart';
import 'package:emarket_user/view/base/footer_web_view.dart';
import 'package:emarket_user/view/base/web_header/web_app_bar.dart';
import 'package:emarket_user/view/screens/auth/widget/code_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/provider/auth_provider.dart';
import 'package:emarket_user/provider/wishlist_provider.dart';
import 'package:emarket_user/utill/color_resources.dart';
import 'package:emarket_user/utill/dimensions.dart';
import 'package:emarket_user/utill/images.dart';
import 'package:emarket_user/view/base/custom_button.dart';
import 'package:emarket_user/view/base/custom_snackbar.dart';
import 'package:emarket_user/view/base/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FocusNode _emailNumberFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  GlobalKey<FormState> _formKeyLogin;
  String _countryDialCode;


  @override
  void initState() {
    super.initState();
    _formKeyLogin = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.text = Provider.of<AuthProvider>(context, listen: false).getUserNumber() ?? '';
    _passwordController.text = Provider.of<AuthProvider>(context, listen: false).getUserPassword() ?? '';
    _countryDialCode = "+92";
        //CountryCode.fromCountryCode(Provider.of<SplashProvider>(context, listen: false).configModel.countryCode).dialCode;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? PreferredSize(child: WebAppBar(), preferredSize: Size.fromHeight(120)) : null,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [


            Center(child: Image.asset("assets/image/pageBackground.png", fit: BoxFit.fill,height: double.infinity,width: double.infinity,)),

            Positioned(
                top: size.height*0.02,
                child: Image.asset("assets/image/mittie_white.png", width: 170,)),


            Positioned.fill(
              top: size.height*0.25,
              left: 0,
              right: 0,
              child:  Container(
                width: size.width > 700 ? 700 : size.width,
                height: size.height*0.8,
                margin: EdgeInsets.symmetric(vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.FONT_SIZE_THIRTY : 0),
                // padding: size.width > 700 ? EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE) : null,
               decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context) ? 0 : Dimensions.PADDING_SIZE_LARGE),
                  //physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Center(
                          child: Consumer<AuthProvider>(
                            builder: (context, authProvider, child) => Form(
                              key: _formKeyLogin,
                              child: Container(
                                padding: size.width > 700 ? EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE,vertical: Dimensions.PADDING_SIZE_LARGE) : null,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: 30),
                                    /*Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child:
                                        Image.asset(
                                          Images.logo,
                                          height: ResponsiveHelper.isDesktop(context) ? 100.0 : MediaQuery.of(context).size.height / 4.5,
                                          fit: BoxFit.scaleDown,
                                          matchTextDirection: true,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),*/
                                    Center(
                                        child: Text(
                                          getTranslated("welcome_back", context),
                                          style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 24, color: ColorResources.getGreyBunkerColor(context)),
                                        )),
                                    SizedBox(height: 35),
                                    Provider.of<SplashProvider>(context, listen: false).configModel.emailVerification?
                                    Text(
                                      getTranslated('email', context),
                                      style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
                                    ):Text(
                                      getTranslated('mobile_number', context),
                                      style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
                                    ),
                                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                    Provider.of<SplashProvider>(context, listen: false).configModel.emailVerification?
                                    CustomTextField(
                                      hintText: getTranslated('demo_gmail', context),
                                      isShowBorder: true,
                                      focusNode: _emailNumberFocus,
                                      nextFocus: _passwordFocus,
                                      controller: _emailController,
                                      inputType: TextInputType.emailAddress,
                                    ):
                                    Row(children: [
                                      CodePickerWidget(
                                        onChanged: (CountryCode countryCode) {
                                          _countryDialCode = countryCode.dialCode;
                                        },
                                        initialSelection: _countryDialCode,
                                        favorite: [_countryDialCode],
                                        showDropDownButton: true,
                                        padding: EdgeInsets.zero,
                                        showFlagMain: true,
                                        textStyle: TextStyle(color: Theme.of(context).textTheme.headline1.color),

                                      ),
                                      Expanded(child: CustomTextField(
                                        hintText: getTranslated('number_hint', context),
                                        isShowBorder: true,
                                        focusNode: _emailNumberFocus,
                                        nextFocus: _passwordFocus,
                                        controller: _emailController,
                                        fillColor: textfieldBg,
                                        inputType: TextInputType.phone,
                                      )),
                                    ]),
                                    SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                                    Text(
                                      getTranslated('password', context),
                                      style: Theme.of(context).textTheme.headline2.copyWith(color: ColorResources.getHintColor(context)),
                                    ),
                                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                                    CustomTextField(
                                      hintText: getTranslated('password_hint', context),
                                      isShowBorder: true,
                                      isPassword: true,
                                      isShowSuffixIcon: true,
                                      fillColor: textfieldBg,

                                      focusNode: _passwordFocus,
                                      controller: _passwordController,
                                      inputAction: TextInputAction.done,
                                    ),
                                    SizedBox(height: 22),

                                    // for remember me section
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Consumer<AuthProvider>(
                                            builder: (context, authProvider, child) => InkWell(
                                              onTap: () {
                                                authProvider.toggleRememberMe();
                                              },
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 18,
                                                    height: 18,
                                                    decoration: BoxDecoration(
                                                        color: authProvider.isActiveRememberMe ? Theme.of(context).primaryColor : ColorResources.COLOR_WHITE,
                                                        border:
                                                        Border.all(color: authProvider.isActiveRememberMe ? Colors.transparent : Theme.of(context).primaryColor),
                                                        borderRadius: BorderRadius.circular(3)),
                                                    child: authProvider.isActiveRememberMe
                                                        ? Icon(Icons.done, color: ColorResources.COLOR_WHITE, size: 17)
                                                        : SizedBox.shrink(),
                                                  ),
                                                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                                                  Text(
                                                    getTranslated('remember_me', context),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline2
                                                        .copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL, color: ColorResources.getHintColor(context)),
                                                  )
                                                ],
                                              ),
                                            )),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context, Routes.getForgetPassRoute());
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              getTranslated('forgot_password', context),
                                              style:
                                              Theme.of(context).textTheme.headline2.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getHintColor(context)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                                    SizedBox(height: 22),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        authProvider.loginErrorMessage.length > 0
                                            ? CircleAvatar(backgroundColor: Colors.red, radius: 5)
                                            : SizedBox.shrink(),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            authProvider.loginErrorMessage ?? "",
                                            style: Theme.of(context).textTheme.headline2.copyWith(
                                              fontSize: Dimensions.FONT_SIZE_SMALL,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),

                                    // for login button
                                    SizedBox(height: 10),
                                    !authProvider.isLoading
                                        ? CustomButton(
                                      btnTxt: getTranslated('login', context),
                                      onTap: () async {
                                        String _email = _emailController.text.trim();
                                        if(!Provider.of<SplashProvider>(context, listen: false).configModel.emailVerification){
                                          _email = _countryDialCode +_emailController.text.trim();
                                        }

                                        String _password = _passwordController.text.trim();
                                        if (_email.isEmpty) {
                                          if(Provider.of<SplashProvider>(context, listen: false).configModel.emailVerification){
                                            showCustomSnackBar(getTranslated('enter_email_address', context), context);
                                          }else {
                                            showCustomSnackBar(getTranslated('enter_phone_number', context), context);
                                          }
                                        }else if (_password.isEmpty) {
                                          showCustomSnackBar(getTranslated('enter_password', context), context);
                                        }else if (_password.length < 6) {
                                          showCustomSnackBar(getTranslated('password_should_be', context), context);
                                        }else {
                                          authProvider.login(_email, _password).then((status) async {
                                            if (status.isSuccess) {

                                              if (authProvider.isActiveRememberMe) {
                                                authProvider.saveUserNumberAndPassword(_emailController.text, _password);
                                              } else {
                                                authProvider.clearUserNumberAndPassword();
                                              }

                                              await Provider.of<WishListProvider>(context, listen: false).initWishList(
                                                context, Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode,
                                              );
                                              Navigator.pushNamedAndRemoveUntil(context, Routes.getMainRoute(), (route) => false);
                                            }
                                          });
                                        }
                                      },
                                    )
                                        : Center(
                                        child: CircularProgressIndicator(
                                          valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                        )),

                                    // for create an account


                                    SizedBox(height: 35,),

                                    Center(
                                      child: Text(getTranslated("or_sign_in_with", context),
                                        style: rubikRegular.copyWith(
                                            color: Colors.grey
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 30,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        InkWell(
                                            onTap: () async {
                                             await authProvider.googleLogin();
                                             Navigator.pushNamedAndRemoveUntil(context, Routes.getMainRoute(), (route) => false);
                                            },
                                            child: Image.asset("assets/image/google.png",height: 50,width: 50,)),
                                      /*  SizedBox(width: 25,),

                                        Image.asset("assets/image/fb.png",height: 50,width: 50,),
                                        SizedBox(width: 25,),

                                        Image.asset("assets/image/phone.png",height: 50,width: 50,),*/
                                      ],
                                    ),

                                    SizedBox(height: 20),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, Routes.getSignUpRoute());
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              getTranslated("dont_have_an_account?",context),
                                              style:
                                              Theme.of(context).textTheme.headline2.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getGreyColor(context)),
                                            ),
                                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                                            Text(
                                              getTranslated('signup', context),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3
                                                  .copyWith(fontSize: Dimensions.FONT_SIZE_SMALL, color: ColorResources.getGreyBunkerColor(context)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ResponsiveHelper.isDesktop(context) ? FooterView() : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

