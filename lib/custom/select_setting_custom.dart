import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
class SelectSettingCustom extends StatelessWidget{
  final IconData icon;
  final String title;
   SelectSettingCustom({
       Key? key,
       required this.icon,
       required this.title,
   }): super(key:key);
   @override
   Widget build(BuildContext context) {
       return Container(
        margin: EdgeInsets.only(top:AppDimention.size10),
          child: Row(
            children: [
              SizedBox(width: AppDimention.size10,),
              Icon(icon,size: 40,color: AppColor.mainColor,),
              SizedBox(width: AppDimention.size20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppDimention.size20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 
                ],
              ),

            ],
          ),
       );
   }
}