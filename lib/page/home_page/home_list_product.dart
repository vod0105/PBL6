import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomeListProduct extends StatefulWidget{
   const HomeListProduct({
       Key? key,
   }): super(key:key);
   @override
   _HomeListProductState createState() => _HomeListProductState();
}
class _HomeListProductState extends State<HomeListProduct>{
   @override
   Widget build(BuildContext context) {
   // TODO: implement build
       return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context , index){
                return GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.PRODUCT_DETAIL);
                    },
                    child: Container(
                            margin: EdgeInsets.only(left: AppDimention.size20, right:  AppDimention.size20,bottom: AppDimention.size20),
                            child: Row(
                              children: [
                                Container(
                                    width: AppDimention.listViewImageSize,
                                    height: AppDimention.listViewImageSize,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppDimention.size20),
                                      color: Colors.white,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "https://wallpaperaccess.com/full/6790132.png"
                                        )
                                      ),
                                    ),
                                  ),
                                Expanded(
                                  child: Container(
                                      height: AppDimention.listViewTextContSize,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(AppDimention.size20),
                                          bottomRight: Radius.circular(AppDimention.size20),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: AppDimention.size10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            
                                            
                                          ],
                                        ),
                                      ),
                                    ),
                                ),
                              ],
                            ),
                        ),
                );
              },
          );
   }
}