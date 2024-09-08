import 'dart:convert';

import 'package:android_project/data/controller/Combo_controller.dart';
import 'package:android_project/models/Model/ComboModel.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
class HomeCombo extends StatefulWidget{
   const HomeCombo({
       Key? key,
   }): super(key:key);
   @override
   _HomeComboState createState() => _HomeComboState();
}
class _HomeComboState extends State<HomeCombo>{
  PageController pageController = PageController(viewportFraction: 0.95);
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
        return comboController.isLoading ? Container(
          height: AppDimention.size130,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  itemCount: comboController.comboList.length,
                  itemBuilder: (context, position) {
                    return _buildView(position,comboController.comboList[position]);
                  },
                ),
              ),
            ],
          ),
        ): CircularProgressIndicator();
    });
   }
   Widget _buildView(int index,ComboModel combomodel){
    return Container(
      margin: EdgeInsets.only(left: AppDimention.size5,right: AppDimention.size5),
      child:Stack(
            children: [
              Positioned(
                top:0,
                right: 0,
                child:  Container(
                  padding: EdgeInsets.only(left: AppDimention.size10),
                  height: AppDimention.size130,
                  width: AppDimention.size130+ AppDimention.size100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(AppDimention.size10),bottomRight:Radius.circular(AppDimention.size10) ),
                    color: Colors.white,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(combomodel.comboName.toString(),style: TextStyle(fontSize: AppDimention.size20,fontWeight: FontWeight.bold),maxLines: 2,),
                              Text("Giá :" + combomodel.comboPrice.toString() +"vnđ",style: TextStyle(fontSize: 16,color: AppColor.mainColor))
                            ],
                        ),
                      ),
                     Positioned(
                        bottom: 0,
                        child: Container(
                          width: AppDimention.size170 - AppDimention.size50,
                          height: AppDimention.size50,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(AppDimention.size10),
                          ),
                          child: Center(
                            child: Text(
                              "Mua ngay",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppDimention.size20,
                              ),
                            ),
                          ),
                        ),
                      )

                    ],
                  )
                )
              ),
              Positioned(
                top:0,
                left: 0,
                child: Container(
                  height: AppDimention.size120,
                  width: AppDimention.size120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(AppDimention.size10),bottomLeft:Radius.circular(AppDimention.size10) ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: MemoryImage(base64Decode(combomodel.image!)),
                    ),
                  ),
                ),
              ),
            
           
            ],
          )
    );
   }
}