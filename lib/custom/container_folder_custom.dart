import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
class ContainerFolderCustom extends StatelessWidget{
  ContainerFolderCustom({
       Key? key,
   }): super(key:key);
   @override
   Widget build(BuildContext context) {
       return Container(
              margin: EdgeInsets.only(left: AppDimention.size5+1,right: AppDimention.size5,top: AppDimention.size10),
              height: 125,
              width: 185,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimention.size10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 7,
                    offset: Offset(1, 10),
                    color: Colors.grey.withOpacity(0.2)
                  )
                ]
              ),
              child: Column()
            );
   }
}