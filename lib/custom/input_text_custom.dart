import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
class InputTextCustom extends StatelessWidget{
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  const InputTextCustom({
       super.key,
       required this.controller,
       required this.hintText,
       required this.icon,
   });
   @override
   Widget build(BuildContext context) {
       return Container(
              margin: EdgeInsets.only(left: AppDimention.size20,right: AppDimention.size20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimention.size30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: AppDimention.size10,
                    spreadRadius: 7,
                    offset: const Offset(1, 10),
                    color: Colors.grey.withOpacity(0.2)
                  )
                ]
              ),
              child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(
                              color: Colors.black26
                            ),
                    prefixIcon: Icon(icon,color: AppColor.yellowColor,),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimention.size30),
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: Colors.white
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimention.size30),
                      borderSide: const BorderSide(
                        width: 1.0,
                        color: Colors.white
                      )
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimention.size30),
                      
                    ),
                  ),
              ),
            );
   }
}