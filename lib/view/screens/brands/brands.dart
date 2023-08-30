import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/provider/brands_provider.dart';
import 'package:emarket_user/provider/field_officers_provider.dart';
import 'package:emarket_user/utill/dimensions.dart';
import 'package:emarket_user/view/common_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Brands extends StatefulWidget {
  const Brands({Key key}) : super(key: key);

  @override
  State<Brands> createState() => _BrandsState();
}

class _BrandsState extends State<Brands> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(text: getTranslated('brands', context) ,icon: InkWell(
        onTap: (){
      Navigator.pop(context);
    },
    child: Icon(
    Icons.arrow_back_outlined,
    color: Colors.black,
    ),
    ),
        ),
       body: Consumer<BrandsProvider>(
         builder:(ctx,brandsProvider,child) =>
             SafeArea(
           child: Padding(
             padding: EdgeInsets.symmetric(
               horizontal: 10,
               vertical: 15
             ),
             child: brandsProvider.brandsList == null ? CircularProgressIndicator():
             brandsProvider.brandsList.isEmpty ? Container() :
             ListView.separated(
                 separatorBuilder: (ctx,index)=>SizedBox(height: 15,),
                 itemCount: brandsProvider.brandsList.length,
                 itemBuilder:
                     (ctx,index)=>Container(

                   decoration: BoxDecoration(
                     shape: BoxShape.rectangle,
                     color: Colors.black12,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: Container(
                     child: Row(
                       children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  bottomLeft: Radius.circular(13),
                                ),
                                image: DecorationImage(
                                  image: AssetImage("assets/image/brand.jpg"),
                                  fit: BoxFit.cover
                                ),
                              ),
                            ),
                         SizedBox(
                           width: 10,
                         ),

                         Expanded(child: Padding(
                           padding: const EdgeInsets.all(12.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                                Text("${brandsProvider.brandsList[index].name}",style: TextStyle(
                                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                                  fontWeight: FontWeight.w600
                                ),),

                               Text("${brandsProvider.brandsList[index].slug}",style: TextStyle(
                                   fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                   color: Colors.grey,
                                   fontWeight: FontWeight.w600
                               ),),

                               Text("${brandsProvider.brandsList[index].status}",style: TextStyle(
                                   fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                   color: Colors.grey,
                                   fontWeight: FontWeight.w600
                               ),),
                             ],
                           ),
                         ))
                       ],
                     )
                   ),
                 )),
           ),
         ),
       ),
    );
  }
}
