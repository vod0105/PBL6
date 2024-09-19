import 'package:app_shipper/pages/home_page/home_footer.dart';
import 'package:app_shipper/pages/home_page/home_header.dart';
import 'package:app_shipper/pages/home_page/home_list.dart';
import 'package:app_shipper/pages/profile_page/profile_footer.dart';
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
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                
              ],
            ),
          )),
          ProfileFooter()
        ],
      ),
    );
   }
}