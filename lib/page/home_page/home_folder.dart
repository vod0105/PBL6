import 'package:android_project/custom/container_folder_custom.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:flutter/material.dart';
class HomeFolder extends StatefulWidget{
   const HomeFolder({
       Key? key,
   }): super(key:key);
   @override
   _HomeFolderState createState() => _HomeFolderState();
}
class _HomeFolderState extends State<HomeFolder>{
   @override
   Widget build(BuildContext context) {
   // TODO: implement build
       return Container(
        height: 280,
          decoration: BoxDecoration(
            color: AppColor.mainColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ContainerFolderCustom(),
                  ContainerFolderCustom(),
                ],
              ),
              Row(
                children: [
                  ContainerFolderCustom(),
                  ContainerFolderCustom(),
                ],
              )
            ],
          ),
       );
   }
}