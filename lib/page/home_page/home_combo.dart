import 'dart:convert';
import 'package:android_project/data/controller/Combo_controller.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCombo extends StatefulWidget {
  const HomeCombo({super.key});

  @override
  HomeComboState createState() => HomeComboState();
}

class HomeComboState extends State<HomeCombo> {
  PageController pageController = PageController(viewportFraction: 0.9);
  double currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        if (pageController.page != null) {
          currentPageValue = pageController.page!;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComboController>(builder: (comboController) {
      return !comboController.isLoading
          ? SizedBox(
              width: AppDimention.screenWidth,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: comboController.comboList
                      .map((item) => GestureDetector(
                        onTap: (){
                          Get.toNamed(AppRoute.get_combo_detail(item.comboId!));
                        },  
                        child: 
                        Container(
                            width: AppDimention.size100 * 3,
                            padding: EdgeInsets.only(top:AppDimention.size10,bottom: AppDimention.size10),
                            margin: EdgeInsets.only(
                                left: AppDimention.size5,
                                right: AppDimention.size5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size10)),
                            child: Row(
                              children: [
                                Container(
                                  width: AppDimention.size80,
                                  height: AppDimention.size100,
                                 
                                  margin: EdgeInsets.only(
                                      left: AppDimention.size10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppDimention.size10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:item.image != null ?  MemoryImage(base64Decode(item.image!)) : const AssetImage("assets/image/LoadingBg.png"),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: AppDimention.size100 * 2,
                                  
                                  padding: EdgeInsets.only(
                                      top: AppDimention.size20,
                                      left: AppDimention.size20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.comboName ?? '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,color: Colors.black.withOpacity(0.7)),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star_purple500_sharp,
                                              size: 18,
                                              color: Colors.yellow[700]),
                                          const Text(" 4.7"),
                                          const Text(
                                            "(1450)",
                                            style: TextStyle(
                                                color: Colors.black38),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                      ))
                      .toList(),
                ),
              ))
          : const Center(child: CircularProgressIndicator());
    });
  }

}
