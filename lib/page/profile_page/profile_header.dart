import 'package:android_project/custom/big_text.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      return Container(
          width: AppDimention.screenWidth,
          height: 180,
          decoration: BoxDecoration(
            color: AppColor.mainColor
          ),
          child: Column(
            children: [
              Row(
               
                children: [
                  Container(width: AppDimention.screenWidth / 1.9,),
                  Container(
                    width: AppDimention.screenWidth / 2.2,
                    height: 60,
                    child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.settings,color: Colors.white,size: AppDimention.size40,),
                        Container(
                          width: 40,
                          height: 40,
                          child:Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: (){
                                    Get.toNamed(AppRoute.CART_PAGE);
                                  },
                                  child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: AppDimention.size40,),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                width: 20,
                                height: 20,
                                child: Container(
                                  
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20),),
                                    border: Border.all(color: Colors.white,width: 2),
                                    color: AppColor.mainColor,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text("1",style: TextStyle(color: Colors.white,fontSize: 12),),
                                  ),
                                ),
                              )
                            ],
                          ) ,
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          child:Stack(
                            children: [
                              Positioned(
                                bottom: 0,
                                child: Icon(Icons.message_outlined,color: Colors.white,size: AppDimention.size40,),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                width: 20,
                                height: 20,
                                child: Container(
                                  
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20),),
                                    border: Border.all(color: Colors.white,width: 2),
                                    color: AppColor.mainColor,
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text("1",style: TextStyle(color: Colors.white,fontSize: 12),),
                                  ),
                                ),
                              )
                            ],
                          ) ,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                    Container(
                      width: 80,
                      height: 80,
                      margin: EdgeInsets.only(left: AppDimention.size30,top: AppDimention.size30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://wallpaperaccess.com/full/6790132.png"),
                        ),
                      ),
                    ),
                    SizedBox(width: AppDimention.size20,),
                    Column(
                      
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          SizedBox(height: AppDimention.size30,),
                          BigText(text: "Nguyễn Văn Nhật",color:Colors.white,),
                          Text("ID:38A04990",style: TextStyle(color:Colors.white,),),
                          Text("Rank:kim cương",style: TextStyle(color:Colors.white,)),
                      ],
                    )
                ],
              )
            ],
          ),
      );
   }
}