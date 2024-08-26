import 'package:android_project/custom/big_text.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
class ProfileHeader extends StatefulWidget{
   const ProfileHeader({
       Key? key,
   }): super(key:key);
   @override
   _ProfileHeaderState createState() => _ProfileHeaderState();
}
class _ProfileHeaderState extends State<ProfileHeader>{
   @override
   Widget build(BuildContext context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: AppDimention.size20,),
          BigText(text: "Profiles",size: AppDimention.size40,),
          SizedBox(height: AppDimention.size5,),
          Stack(
            children: [
              Container( 
                width: 375, 
                height: 110,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        width: 375,
                        height: 110,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          borderRadius: BorderRadius.circular(AppDimention.size10),
                        ),
                      )
                    ),
                    Positioned(
                      top:AppDimention.size5,
                      left: AppDimention.size30 + AppDimention.size5,
                      child: Container(
                        width: AppDimention.size20 * 5,
                        height: AppDimention.size20 * 5,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(63, 173, 253, 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 58,
                      top: AppDimention.size15,
                      child: Container(
                        width: AppDimention.size80,
                        height: AppDimention.size80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppDimention.size80),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                  "assets/image/logo.png"
                              ),
                            ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 158,
                      child: Container(
                        height: 110,
                        width: 220,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppDimention.size15),
                            BigText(text: "Nguyễn Văn Nhật",size: 25,),
                            SizedBox(height: AppDimention.size5,),
                            Text("ID: 38A04990"),
                            SizedBox(height: AppDimention.size5,),
                            Text("Rank: kim cương"),

                          ],
                        ),
                      )
                    )
                  ],
                ),
              ),
            ],
          )

        ],
      );
   }
}