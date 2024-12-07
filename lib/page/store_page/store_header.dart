
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';

class StoreHeader extends StatefulWidget {
  const StoreHeader({super.key});

  @override
  StoreHeaderState createState() => StoreHeaderState();
}

class StoreHeaderState extends State<StoreHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        
      width: AppDimention.screenWidth,
      margin: EdgeInsets.only(top: AppDimention.size20),
      height: AppDimention.size60,
        child: const Center(
          child: Text(
            "Cửa hàng",
            style: TextStyle(color: AppColor.mainColor, fontSize: 20),
          ),
        ));
  }
}
