import 'package:app_shipper/themes/AppColor.dart';
import 'package:app_shipper/themes/AppDimention.dart';
import 'package:flutter/material.dart';
class HomeHeader extends StatefulWidget{
   const HomeHeader({
       Key? key,
   }): super(key:key);
   @override
   _HomeHeaderState createState() => _HomeHeaderState();
}
class _HomeHeaderState extends State<HomeHeader>{
  TextEditingController searchController = TextEditingController();
   @override
   Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: AppDimention.size40,),
      padding: EdgeInsets.only(
          left: AppDimention.size20, right: AppDimention.size20),
     
      child: Row(
        children: [
          Container(
            width: AppDimention.size40,
            child: Center(
              child: Icon(Icons.map_outlined,color: Appcolor.mainColor,size: AppDimention.size40,),
            ),
          ),
          SizedBox(width: AppDimention.size10),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search ...",
                prefixIcon: Icon(
                  Icons.search,
                  color: Appcolor.mainColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimention.size30),
                  borderSide: BorderSide(width: 1.0, color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimention.size30),
                  borderSide: BorderSide(width: 1.0, color: Colors.black12),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimention.size30),
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
   }
}