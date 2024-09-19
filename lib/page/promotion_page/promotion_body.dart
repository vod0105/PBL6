import 'package:android_project/data/controller/Combo_controller.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class PromotionBody extends StatefulWidget {
  const PromotionBody({
    Key? key,
  }) : super(key: key);
  @override
  _PromotionBodyState createState() => _PromotionBodyState();
}

class _PromotionBodyState extends State<PromotionBody> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComboController>(builder: (comboController) {
      return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: comboController.comboList.length,
          itemBuilder: (context, index) {
            return Container(
              width: AppDimention.screenWidth,
              height: AppDimention.size220,
              margin: EdgeInsets.only(
                  left: AppDimention.size20,
                  right: AppDimention.size20,
                  bottom: AppDimention.size20),
              decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(AppDimention.size10)),
              child: Column(
                children: [
                  Container(
                    width: AppDimention.screenWidth - AppDimention.size40,
                    height: AppDimention.size150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppDimention.size10),
                            topRight: Radius.circular(AppDimention.size10)),
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://wallpaperaccess.com/full/6790132.png"))),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: AppDimention.size10,
                            top: AppDimention.size10),
                        width: AppDimention.screenWidth - AppDimention.size150,
                        height: AppDimention.size70,
                        child: Text(
                          "Combo hấp dẫn , khuyến mãi bất ngờ",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: AppDimention.size100,
                          height: AppDimention.size50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size10)),
                          child: Center(
                            child: Text(
                              "Mua ngay",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          });
    });
  }
}
