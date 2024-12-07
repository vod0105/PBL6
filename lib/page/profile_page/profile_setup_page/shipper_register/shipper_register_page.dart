import 'package:android_project/page/profile_page/profile_setup_page/shipper_register/shipper_register_body.dart';
import 'package:android_project/page/profile_page/profile_setup_page/shipper_register/shipper_register_header.dart';
import 'package:flutter/material.dart';
class ShipperRegisterPage extends StatefulWidget{
   const ShipperRegisterPage({
       super.key,
   });
   @override
   ShipperRegisterPageState createState() => ShipperRegisterPageState();
}
class ShipperRegisterPageState extends State<ShipperRegisterPage>{
   @override
   Widget build(BuildContext context) {
      return const Scaffold(
      body: Column(
        children: [
          ShipperRegisterHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
               ShipperRegisterBody(),
              ],
            ),
          )),
        ],
      ),
    );
   }
}