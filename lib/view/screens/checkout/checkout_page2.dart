
import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/theme/app_colors.dart';
import 'package:emarket_user/view/base/custom_button.dart';
import 'package:emarket_user/view/common_widgets/custom_appbar.dart';
import 'package:emarket_user/view/screens/checkout/widget/custom_check_box.dart';
import 'package:emarket_user/view/screens/checkout/widget/my_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CheckoutPage2 extends StatefulWidget {
  const CheckoutPage2({Key key}) : super(key: key);

  @override
  State<CheckoutPage2> createState() => _CheckoutPage2State();
}

class _CheckoutPage2State extends State<CheckoutPage2> {

  List<String> country = ["Pakistan"];
  String selectedCountry;
  String selectedRegion;
  String selectedCity;
  String selectedArea;
  bool saveAddress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(text: "Checkout",icon: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_outlined,
          color: Colors.black,
        ),
      ),
      trailingItems: [
        PopupMenuButton<int>(
          onSelected: (item) => handleClick(item),
          itemBuilder: (context) => [
            /*PopupMenuItem<int>(value: 0, child: Text('Logout')),
            PopupMenuItem<int>(value: 1, child: Text('Settings')),*/
          ],
        ),
      ]
      ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15
              ),
              child: Column(
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                              Container(
                                height: 30,
                                width: 30,
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                 ),
                                child: SvgPicture.asset("assets/image/tick.svg",color: Colors.white,),
                              ),
                             Expanded(child: Divider(
                               thickness: 1,
                               color: Theme.of(context).primaryColor,
                             )),
                        Container(
                          height: 30,
                          width: 30,
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset("assets/image/tick.svg",color: Colors.white,),
                        ),

                        Expanded(child: Divider(
                          thickness: 1,
                        )),

              SizedBox(
                height: 10,
              ),

              Container(
                height: 30,
                width: 30,
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey
                ),)

                        ],
                    ),
                  ),

                  Row(
                    children: [
                      Text("Delivery",style: Theme.of(context).textTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700
                      ),),

                      Spacer(),
                      Text("Address",style: Theme.of(context).textTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700
                      ),),

                      Spacer(),
                      Text("Payment",style: Theme.of(context).textTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        color: Colors.grey
                      ),),

                    ],
                  ),


                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      Image.asset("assets/image/payment method.png",height: 35,width: 30,),
                      SizedBox(
                        width: 10,
                      ),

                      Text(getTranslated("payment_method", context),style: Theme.of(context).textTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        fontSize: 18
                      ),),

                    ],
                  ),

                  SizedBox(height: 15,),

                  Row(
                    children: [

                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10
                        ),
                        child: Column(
                          children: [
                             Image.asset("assets/image/images.png",height: 40,width: 40,),
                            SizedBox(
                              height: 7,
                            ),
                            Text(getTranslated("easy_paisa", context),style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12
                            ),),
                          ],
                        ),
                      )),

                      SizedBox(width: 15,),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 2
                          ),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10
                        ),
                        child: Column(
                          children: [
                            Image.asset("assets/image/jazzcash.png",height: 40,width: 40,),
                            SizedBox(
                              height: 7,
                            ),
                            Text(getTranslated("jazz_cash", context),style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12
                            ),),
                          ],
                        ),
                      )),

                      SizedBox(width: 15,),
                      Expanded(child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.grey,
                              width: 2
                          ),
                          borderRadius: BorderRadius.circular(10),

                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 10
                        ),
                        child: Column(
                          children: [
                            Image.asset("assets/image/bank.png",height: 40,width: 40,),
                            SizedBox(
                              height: 7,
                            ),
                            Text(getTranslated("bank", context),style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12
                            ),),
                          ],
                        ),
                      )),

                    ],
                  ),




                  SizedBox(
                    height: 25,
                  ),

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
                        hintText:  getTranslated("transaction_id", context),
                        fillColor: textfieldBg),
                    cursorColor: Colors.black,
                  ),


                  SizedBox(
                    height: 15,
                  ),

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
                        hintText:  getTranslated("sent_amount_rs", context),
                        fillColor: textfieldBg),
                    cursorColor: Colors.black,
                  ),


                  SizedBox(
                    height: 15,
                  ),

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
                        hintText:  getTranslated("other_details(optional)", context),
                        fillColor: textfieldBg),
                    cursorColor: Colors.black,
                  ),




                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      Image.asset("assets/image/cash.png",height: 35,width: 30,),
                      SizedBox(
                        width: 10,
                      ),

                      Text(getTranslated("cash_on_delivery", context),style: Theme.of(context).textTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 18
                      ),),

                    ],
                  ),



                  SizedBox(
                    height: 7,
                  ),

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
                        hintText:  getTranslated("add_refferal_code(if_any)", context),
                        fillColor: textfieldBg),
                    cursorColor: Colors.black,
                  ),


                  SizedBox(
                    height: 20,
                  ),


                  Row(
                    children: [
                      Text(getTranslated("order_summary", context),style: Theme.of(context).textTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 18
                      ),),
                    ],
                  ),


                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                       Expanded(
                         flex: 2,
                         child: Container(
                           alignment: Alignment.centerLeft,
                           child: Text(getTranslated("total_bill", context),style: Theme.of(context).textTheme.bodyMedium.copyWith(
                               fontWeight: FontWeight.w800,
                               color: Theme.of(context).primaryColor,
                               fontSize: 18
                           ),),
                         ),
                       ),
                      SizedBox(width: 25,),
                      Text("Rs. 423245.00",style: Theme.of(context).textTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        color: Colors.black
                      ),),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(getTranslated("deliver_charges", context),style: Theme.of(context).textTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).primaryColor,
                              fontSize: 18
                          ),),
                        ),
                      ),
                      SizedBox(width: 25,),
                      Text("Rs. 0.0",style: Theme.of(context).textTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black
                      ),),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(getTranslated("coupon_discount", context),style: Theme.of(context).textTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).primaryColor,
                              fontSize: 18
                          ),),
                        ),
                      ),
                      SizedBox(width: 25,),
                      Text("Rs. 0",style: Theme.of(context).textTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black
                      ),),
                    ],
                  ),


                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(getTranslated("grand_total", context),style: Theme.of(context).textTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).primaryColor,
                              fontSize: 18
                          ),),
                        ),
                      ),
                      SizedBox(width: 25,),
                      Text("Rs. 24555.0",style: Theme.of(context).textTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black
                      ),),
                    ],
                  ),


                  SizedBox(
                    height: 20,
                  ),


                  CustomCheckBox(title: getTranslated("save_this_card", context), index: 1),


                  SizedBox(
                    height: 60,
                    child: CustomButton(btnTxt: getTranslated("make_payment", context),
                     onTap: (){

                     },
                    ),
                  ),



                  SizedBox(
                    height: 30,
                  ),


                ],
              ),
            ),
          ),
        ),
    );
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        break;
      case 1:
        break;
    }
  }
}
