
import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/theme/app_colors.dart';
import 'package:emarket_user/view/base/custom_button.dart';
import 'package:emarket_user/view/common_widgets/custom_appbar.dart';
import 'package:emarket_user/view/screens/checkout/checkout_page2.dart';
import 'package:emarket_user/view/screens/checkout/widget/custom_check_box.dart';
import 'package:emarket_user/view/screens/checkout/widget/my_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

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
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 4,
                            )
                          ),
                          child: Container(
                            padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                   color: Theme.of(context).primaryColor
                              )
                          ),
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
                      color: Theme.of(context).dividerColor
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
                      Image.asset("assets/image/contact information.png",height: 35,width: 30,),
                      SizedBox(
                        width: 10,
                      ),

                      Text(getTranslated("contact_information", context),style: Theme.of(context).textTheme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        fontSize: 18
                      ),),

                    ],
                  ),




                  SizedBox(
                    height: 10,
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
                        hintText:  getTranslated("enter_your_full_name", context),
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
                        hintText:  getTranslated("enter_your_email", context),
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
                        hintText:  getTranslated("enter_your_phone_number", context),
                        fillColor: textfieldBg),
                    cursorColor: Colors.black,
                  ),




                  SizedBox(
                    height: 15,
                  ),

                  Row(
                    children: [
                      Image.asset("assets/image/shipping address.png",height: 35,width: 30,),
                      SizedBox(
                        width: 10,
                      ),

                      Text(getTranslated("contact_information", context),style: Theme.of(context).textTheme.bodyMedium.copyWith(
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
                        hintText:  getTranslated("type_your_home_address", context),
                        fillColor: textfieldBg),
                    cursorColor: Colors.black,
                  ),




                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                       Expanded(child: Container(
                         padding: EdgeInsets.symmetric(
                           horizontal: 5,
                           vertical: 10
                         ),
                         decoration: BoxDecoration(
                           shape: BoxShape.rectangle,
                           color: textfieldBg,
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: MyDropDown(
                           items: country,
                           val: selectedCountry,
                           hint: "Select Country",
                           onChanged: (String value){
                              setState(() {
                                selectedCountry = value;
                              });
                           },
                         ),
                       )),
                      SizedBox(
                        width: 10,
                      ),

                      Expanded(child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 10
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: textfieldBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MyDropDown(
                          items: [],
                          val: selectedRegion,
                          hint: "Select Region",
                          onChanged: (String value){
                            setState(() {
                              selectedRegion = value;
                            });
                          },
                        ),
                      ))
                    ],
                  ),

                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 10
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: textfieldBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MyDropDown(
                          items: [],
                          val: selectedCountry,
                          hint: "Select City",
                          onChanged: (String value){
                            setState(() {
                              selectedCity = value;
                            });
                          },
                        ),
                      )),
                      SizedBox(
                        width: 10,
                      ),

                      Expanded(child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 10
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: textfieldBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: MyDropDown(
                          items: [],
                          val: selectedArea,
                          hint: "Select Area",
                          onChanged: (String value){
                            setState(() {
                              selectedArea = value;
                            });
                          },
                        ),
                      ))
                    ],
                  ),


                  SizedBox(
                    height: 35,
                  ),


                  CustomCheckBox(title: getTranslated("save_shipping_address", context), index: 1),


                  SizedBox(
                    height: 60,
                    child: CustomButton(btnTxt: getTranslated("next", context),
                     onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (ctx)=>CheckoutPage2()));
                     },
                    ),
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
