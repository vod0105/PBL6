import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
class SelectSettingCustom extends StatelessWidget{
  final IconData icon;
  final String title;
   const SelectSettingCustom({
       super.key,
       required this.icon,
       required this.title,
   });
   @override
   Widget build(BuildContext context) {
       return Row(
         children: [
           SizedBox(width: AppDimention.size10,),
           Icon(icon,size: 30,color: AppColor.mainColor,),
           SizedBox(width: AppDimention.size20,),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 title,
                 style: const TextStyle(
                   fontSize: 16,
                 ),
               ),
              
             ],
           ),
       
         ],
       );
   }
}