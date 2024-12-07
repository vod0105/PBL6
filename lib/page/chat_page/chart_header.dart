import 'package:android_project/data/controller/Chart_controller.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartHeader extends StatefulWidget {
  const ChartHeader({
    super.key,
  });
  @override
  ChartHeaderState createState() => ChartHeaderState();
}

class ChartHeaderState extends State<ChartHeader> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartController>(builder: (chartController) {
      return Container(
        width: AppDimention.screenWidth,
        height: AppDimention.size70,
        padding: EdgeInsets.only(
            left: AppDimention.size10, right: AppDimention.size10),
        decoration: const BoxDecoration(color: AppColor.mainColor),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                chartController.changeShow();
              },
              child: Icon(
                Icons.view_list,
                color: Colors.white,
                size: AppDimention.size40,
              ),
            ),
            SizedBox(
              width: AppDimention.size20,
            ),
            Text(Get.find<ChartController>().chartName,
                style: TextStyle(
                    fontSize: AppDimention.size20, color: Colors.white))
          ],
        ),
      );
    });
  }
}
