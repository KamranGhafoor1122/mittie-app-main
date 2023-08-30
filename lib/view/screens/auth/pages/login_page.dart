/*


import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/theme/app_colors.dart';
import 'package:emarket_user/utill/styles.dart';
import 'package:emarket_user/view/base/custom_button.dart';
import 'package:emarket_user/view/screens/auth/pages/signup_page.dart';
import 'package:emarket_user/view/screens/auth/signup_screen.dart';
import 'package:emarket_user/view/screens/checkout/widget/custom_check_box.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Stack(

          children: [
            Center(child: Image.asset("assets/image/pageBackground.png", fit: BoxFit.fill,height: double.infinity,width: double.infinity,)),

            Positioned.fill(child: 
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Center(child: Image.asset("assets/image/mittie_white.png", width: 170,)),
                
                SizedBox(
                  height: 30,
                ),
                
                Expanded(child: SingleChildScrollView(child: Container(
                  height: MediaQuery.of(context).size.height*0.8,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        SizedBox(height: 15,),


                    Text(getTranslated("welcome_back", context),
                      style: rubikRegular.copyWith(
                          color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w700
                      ),),
                        SizedBox(height: 5,),

                        Text(getTranslated("lorem_ipsem", context),
                          style: rubikRegular.copyWith(
                              color: Colors.grey,
                          ),),

                        SizedBox(height: 30,),
                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              prefixIcon: Icon(Icons.person,color: Colors.grey[800]),
                              hintText:  getTranslated("enter_your_email", context),
                              fillColor: textfieldBg),
                          cursorColor: Colors.black,
                        ),

                        SizedBox(height: 15,),

                        TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              prefixIcon: Icon(Icons.lock,color: Colors.grey[800]),
                              hintText:  getTranslated("enter_your_password", context),
                              fillColor: textfieldBg),
                          cursorColor: Colors.black,
                        ),


                        SizedBox(height: 15,),

                        SizedBox(
                          height: 60,
                          child: CustomButton(btnTxt: getTranslated("sign_in", context),
                            onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SignupPage()));
                            },
                          ),
                        ),

                        SizedBox(height: 15,),

                        Row(
                          children: [

                            Expanded(child:  CustomCheckBox(title: getTranslated("keep_signed_in", context), index: 1),),
                            SizedBox(
                              width: 35,
                            ),
                            Expanded(child:  InkWell(
                              child: Text(getTranslated("forgot_password", context),
                              style: rubikBold.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17
                              ),
                              ),
                            )),



                          ],
                        ),

                        SizedBox(height: 35,),

                        Row(
                          children: [
                            Text(getTranslated("or_sign_in_with", context),
                            style: rubikRegular.copyWith(
                              color: Colors.grey
                            ),
                            ),
                          ],
                        ),

                        SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                             Image.asset("assets/image/google.png",height: 50,width: 50,),
                            SizedBox(width: 25,),

                            Image.asset("assets/image/fb.png",height: 50,width: 50,),
                            SizedBox(width: 25,),

                            Image.asset("assets/image/phone.png",height: 50,width: 50,),
                          ],
                        ),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(getTranslated("dont_have_an_account?", context),style: rubikRegular.copyWith(
                              color: Colors.grey
                            ),),
                            Text(getTranslated("sign_up", context),style: rubikRegular.copyWith(
                                color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600
                            ),),
                          ],
                        )
                        

                      ],
                    ),
                  ),
                  
                ),))
              ],
            ))
            // Text(AppConstants.APP_NAME, style: rubikBold.copyWith(fontSize: 30, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
*/
