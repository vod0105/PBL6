import 'dart:convert';

import 'package:android_project/data/controller/Combo_controller.dart';
import 'package:android_project/data/controller/Size_controller.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ComboDetail extends StatefulWidget {
  final int comboId;
  const ComboDetail({Key? key, required this.comboId}) : super(key: key);
  @override
  _ComboDetailState createState() => _ComboDetailState();
}

class _ComboDetailState extends State<ComboDetail> {
  int selectSize = 1;
  @override
  void initState() {
    super.initState();
    Get.find<ComboController>().getbyid(widget.comboId);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComboController>(builder: (comboControler) {
      while (comboControler.comboDetail.length < 1) {
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        );
      }
      ;
      print(comboControler.comboDetail.length);
      var product = comboControler.comboDetail[0];

      return Scaffold(
          body: Stack(
        children: [
          // Image container
          Positioned(
            top: 0,
            left: 0,
            height: AppDimention.size100 * 3 - AppDimention.size20,
            width: AppDimention.screenWidth,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.mainColor,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(
                    base64Decode(product.image!),
                  ),
                ),
              ),
            ),
          ),

          // Infomation Container
          Positioned(
            top: 250,
            width: AppDimention.screenWidth,
            height: AppDimention.screenHeight - AppDimention.size120 * 2,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimention.size40),
                      topRight: Radius.circular(AppDimention.size40))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppDimention.size15,
                  ),
                  Container(
                    width: AppDimention.screenWidth,
                    height: AppDimention.size60,
                    child: Center(
                      child: Text(product.comboName,
                          style: TextStyle(
                              fontSize: AppDimention.size30,
                              color: Colors.black)),
                    ),
                  ),
                  Container(
                    width: AppDimention.screenWidth,
                    margin: EdgeInsets.only(left: AppDimention.size20),
                    child: Text("Giá : ${product.price} vnđ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        )),
                  ),
                  GetBuilder<SizeController>(builder: (sizecontroller) {
                    return Row(
                      children: sizecontroller.sizelist.map((item) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectSize = item.id!;
                            });
                          },
                          child: Container(
                            width: AppDimention.size30,
                            height: AppDimention.size30,
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: item.id == selectSize
                                  ? const Color.fromARGB(255, 114, 255, 118)
                                  : Colors.grey[200],
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size30),
                            ),
                            child: Center(
                              child: Text(item.name!),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ],
              ),
            ),
          ),
          // Footer Container
          Positioned(
            bottom: 0,
            width: AppDimention.screenWidth,
            height: AppDimention.size60,
            child: Container(
              decoration: BoxDecoration(color: AppColor.yellowColor),
            ),
          ),
          Positioned(
              top: 0,
              width: AppDimention.screenWidth,
              height: AppDimention.size120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: AppDimention.size120,
                    height: AppDimention.size120,
                    child: Center(
                        child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: AppDimention.size40,
                        height: AppDimention.size40,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(AppDimention.size40)),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: AppDimention.size20,
                        ),
                      ),
                    )),
                  ),
                  Container(
                    width: AppDimention.size120,
                    height: AppDimention.size120,
                    child: Center(
                        child: Container(
                      width: AppDimention.size40,
                      height: AppDimention.size40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(AppDimention.size40)),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: AppDimention.size20,
                      ),
                    )),
                  ),
                ],
              )),
        ],
      ));
    });
  }
}
