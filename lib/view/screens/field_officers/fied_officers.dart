import 'package:emarket_user/helper/location_helper.dart';
import 'package:emarket_user/localization/language_constrants.dart';
import 'package:emarket_user/provider/field_officers_provider.dart';
import 'package:emarket_user/utill/dimensions.dart';
import 'package:emarket_user/view/common_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
class FieldOfficers extends StatefulWidget {
  const FieldOfficers({Key key}) : super(key: key);

  @override
  State<FieldOfficers> createState() => _FieldOfficersState();
}

class _FieldOfficersState extends State<FieldOfficers> {



  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(text: getTranslated('field_officer', context) ,icon: InkWell(
        onTap: (){
      Navigator.pop(context);
    },
    child: Icon(
    Icons.arrow_back_outlined,
    color: Colors.white,
    ),
    ),
          bgColor: Theme.of(context).primaryColor,
          textColor: Colors.white,

        ),
       backgroundColor: Theme.of(context).primaryColor,
       body: Consumer<FieldOfficersProvider>(
         builder:(ctx,fieldOfficersProvider,child) =>
             SafeArea(
           child: Padding(
             padding: EdgeInsets.symmetric(
               horizontal: 10,
               vertical: 15
             ),
             child: fieldOfficersProvider.fieldOfficersList == null ? Center(child: CircularProgressIndicator()):
             fieldOfficersProvider.fieldOfficersList.isEmpty ? Center(
               child: Text(getTranslated("no_data_found", context),
               style: TextStyle(
                 fontWeight: FontWeight.w700,
                 fontSize: 22,
                 color: Colors.white
               ),),
             ) :
             ListView.separated(
                 separatorBuilder: (ctx,index)=>SizedBox(height: 15,),
                 itemCount: fieldOfficersProvider.fieldOfficersList.length,
                 itemBuilder:
                     (ctx,index)=>Container(
                   decoration: BoxDecoration(
                     shape: BoxShape.rectangle,
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: Container(
                     padding: EdgeInsets.symmetric(vertical: 7,horizontal: 5),
                     child: Row(
                       children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage("assets/image/person.png"),
                                  fit: BoxFit.cover
                                ),
                              ),
                            ),
                         SizedBox(
                           width: 10,
                         ),

                         Expanded(child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                              Text("${fieldOfficersProvider.fieldOfficersList[index].name}",style: TextStyle(
                                fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                                fontWeight: FontWeight.w600
                              ),),


                             Padding(
                               padding: const EdgeInsets.symmetric(vertical: 7),
                               child: InkWell(
                                 onTap:()=>_launchCaller(fieldOfficersProvider.fieldOfficersList[index].contactDetails),
                                 child: Text("${fieldOfficersProvider.fieldOfficersList[index].contactDetails}",style: TextStyle(
                                     fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                     fontWeight: FontWeight.w600
                                 ),),
                               ),
                             ),

                             // Text("${fieldOfficersProvider.fieldOfficersList[index].location}",style: TextStyle(
                             //     fontSize: Dimensions.FONT_SIZE_DEFAULT,
                             //     color: Colors.grey,
                             //     fontWeight: FontWeight.w600
                             // ),),

                             Text("${fieldOfficersProvider.fieldOfficersList[index].address}",style: TextStyle(
                                 fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                 color: Colors.grey,
                                 fontWeight: FontWeight.w600
                             ),),
                           ],
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


  _launchCaller(String phone) async {
    String url = "tel:$phone";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

   getData() async{
    String address = await getLocation();
    Provider.of<FieldOfficersProvider>(context,listen: false).getFieldOfficersByLocation(address);
  }
}
