import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
class ContainerFolderCustom extends StatelessWidget{
  final String text;
  final IconData iconData;
  final Color iconcolor;
  const ContainerFolderCustom({
    required this.iconData,
    required this.text,
    required this.iconcolor,
       super.key,
   });
   @override
   Widget build(BuildContext context) {
       return Container(
              margin: EdgeInsets.only(left: AppDimention.size5+1,right: AppDimention.size5,top: AppDimention.size10),
              height: AppDimention.size100,
              width: AppDimention.screenWidth / 2.129,
              decoration: BoxDecoration(
                color: AppColor.mainColor,
                borderRadius: BorderRadius.circular(AppDimention.size10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: AppDimention.size10,
                    spreadRadius: 7,
                    offset: const Offset(1, 10),
                    color: Colors.grey.withOpacity(0.2)
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: AppDimention.size10,),
                  Icon(iconData,size: AppDimention.size40,color:iconcolor),
                  Text(text,style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize:18
                  ),)
                ],

              )
            );
   }
}