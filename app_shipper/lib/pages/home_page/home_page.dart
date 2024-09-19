import 'package:app_shipper/pages/home_page/home_footer.dart';
import 'package:app_shipper/pages/home_page/home_header.dart';
import 'package:app_shipper/pages/home_page/home_list.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget{
   const HomePage({
       Key? key,
   }): super(key:key);
   @override
   _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage>{
   @override
   Widget build(BuildContext context) {
      return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          HomeHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                  HomeList()
              ],
            ),
          )),
          HomeFooter()
        ],
      ),
    );
   }
}