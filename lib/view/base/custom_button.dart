import 'package:flutter/material.dart';
import 'package:emarket_user/utill/color_resources.dart';
import 'package:emarket_user/utill/dimensions.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String btnTxt;
  Icon icon;
  final Color backgroundColor;
  final double radius;
  CustomButton({this.onTap, @required this.btnTxt, this.backgroundColor, this.radius = 10,this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onTap == null ? ColorResources.getGreyColor(context) : backgroundColor == null ? Theme.of(context).primaryColor : backgroundColor,
      minimumSize: Size(MediaQuery.of(context).size.width, 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return TextButton(
      onPressed: onTap,
      style: flatButtonStyle,
      child: icon==null?Text(btnTxt??"",
          style: Theme.of(context).textTheme.headline3.copyWith(color: ColorResources.COLOR_WHITE, fontSize: Dimensions.FONT_SIZE_LARGE)):
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           icon,
          SizedBox(
            width: 10,
          ),
          Text(btnTxt??"",
              style: Theme.of(context).textTheme.headline3.copyWith(color: ColorResources.COLOR_WHITE, fontSize: Dimensions.FONT_SIZE_LARGE)),
        ],
      ),
    );
  }
}
