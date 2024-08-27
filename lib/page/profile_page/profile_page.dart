import 'package:android_project/page/home_page/home_footer.dart';
import 'package:android_project/page/profile_page/profile_controll.dart';
import 'package:android_project/page/profile_page/profile_footer.dart';
import 'package:android_project/page/profile_page/profile_header.dart';
import 'package:android_project/page/profile_page/profile_setting.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget{
   const ProfilePage({
       Key? key,
   }): super(key:key);
   @override
   _ProfilePageState createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage>{
   @override
   Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Color.fromRGBO(243, 243, 243, 1),
        body: Column(
          children: [
            ProfileHeader(),
            SizedBox(height: AppDimention.size15,),
             Expanded(
              child: SingleChildScrollView(
              child: Column(
                children: [
                   ProfileControll(),
                   ProfileSetting(),
                   
                ],
              ),
              
            )
            ),
            
            ProfileFooter(),
            
          ],
        ),
      );
   }
}