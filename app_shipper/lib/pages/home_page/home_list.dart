import 'package:app_shipper/route/app_route.dart';
import 'package:app_shipper/themes/AppColor.dart';
import 'package:app_shipper/themes/AppDimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class HomeList extends StatefulWidget{
   const HomeList({
       Key? key,
   }): super(key:key);
   @override
   _HomeListState createState() => _HomeListState();
}
class _HomeListState extends State<HomeList>{
   @override
   Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
          return Container(
              width: AppDimention.screenWidth,
              height: AppDimention.size100 * 2,
              margin: EdgeInsets.only(left: AppDimention.size10,right:AppDimention.size10 , top: AppDimention.size20 ),
              padding: EdgeInsets.all(AppDimention.size20),
              decoration: BoxDecoration(
                color: Appcolor.mainColor,
                borderRadius: BorderRadius.circular(AppDimention.size10)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Cửa hàng số 3",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                  SizedBox(height: AppDimention.size10,),
                  Row(
                    children: [
                      Icon(Icons.location_on,color: Colors.white,),
                      SizedBox(width: AppDimention.size10,),
                      Container(
                        width: AppDimention.screenWidth - AppDimention.size100,
                        child: Text(
                          "54 , Nguyễn Lương Bằng , Hòa Khánh Bắc , Liên Chiểu , Đà Nẵng",
                          style: TextStyle(
                            color: Colors.white
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimention.size20,),
                 GestureDetector(
                  onTap: (){
                      Get.toNamed(AppRoute.get_store_detail(index));
                  },
                  child:  Center(
                        child: Container(
                          width: AppDimention.size150,
                          height: AppDimention.size50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppDimention.size10)
                          ),
                          child: Center(
                            child: Text("Xem chi tiết"),
                          ),
                        ),
                      ),
                 )
                ],
              ),
          );
      }
    
    );
    
   }
}