import 'package:academy_course/constants/constants.dart';
import 'package:flutter/cupertino.dart';

class MediaQueryHelper{
  Size deviceDimension(BuildContext context){
    return MediaQuery.of(context).size;
  }

  double responsiveHeight(BuildContext context,double height){
    return (height/Constants.height) * deviceDimension(context).height;
  }

  double responsiveWidth(BuildContext context,double width){
    return (width/Constants.width) * deviceDimension(context).width;
  }

  double responsiveValue(BuildContext context, double value){
      return (value/Constants.height) * deviceDimension(context).height;
    }

}

MediaQueryHelper mediaQueryHelper = MediaQueryHelper();