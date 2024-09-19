import 'package:app_shipper/pages/home_page/home_footer.dart';
import 'package:app_shipper/pages/home_page/home_header.dart';
import 'package:app_shipper/pages/home_page/home_list.dart';
import 'package:app_shipper/route/app_route.dart';
import 'package:app_shipper/themes/AppColor.dart';
import 'package:app_shipper/themes/AppDimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class StorePage extends StatefulWidget{
  final int storeId;
   const StorePage({
       Key? key,
       required this.storeId
   }): super(key:key);
   @override
   _StorePageState createState() => _StorePageState();
}
class _StorePageState extends State<StorePage>{
  void _receiveOrder(){
    Get.snackbar("Thông báo", "Nhận đơn hàng thành công");
    Get.close(1);
  }

  
  void _ShowAnnounce() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bạn muốn nhận đơn hàng này ?',style: TextStyle(fontSize: 15),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  width: AppDimention.size100 * 3,
                  height: AppDimention.size80 ,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child:  Container(
                        width: AppDimention.size120,
                        height: AppDimention.size50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Appcolor.mainColor),
                          borderRadius: BorderRadius.circular(AppDimention.size5)
                        ),
                        child: Center(
                          child: Text("Hủy"),
                        ),
                      ),
                     ),
                      GestureDetector(
                      onTap: (){
                        _receiveOrder();
                      },
                      child:  Container(
                        width: AppDimention.size120,
                        height: AppDimention.size50,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Appcolor.mainColor),
                          borderRadius: BorderRadius.circular(AppDimention.size5)
                        ),
                        child: Center(
                          child: Text("Đồng ý"),
                        ),
                      ),
                     ),
                    ],
                  )
              );
            },
          ),
        );
      },
    );
  }
   @override
   Widget build(BuildContext context) {
      return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
              width: AppDimention.screenWidth,
              height: AppDimention.size80,
              decoration: BoxDecoration(
                color: Appcolor.mainColor
              ),
              child: Row(
                children: [
                  SizedBox(width: AppDimention.size20,),
                  GestureDetector(
                    onTap: () {
                        Get.back();
                    },
                    child: Icon(Icons.arrow_circle_left_outlined,size: AppDimention.size40,color: Colors.white,),
                  ),
                  SizedBox(width: AppDimention.size60,),
                  Text("Cửa hàng số 3",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),)
                ],
              ),
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                      ListView.builder(
                         physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                            return Container(
                              width: AppDimention.screenWidth,
                         
                              padding: EdgeInsets.all(AppDimention.size20),
                              margin: EdgeInsets.only(bottom: AppDimention.size10,left:AppDimention.size10, right: AppDimention.size10,),
                              decoration: BoxDecoration(
                                color: Appcolor.mainColor,
                                borderRadius: BorderRadius.circular(AppDimention.size10)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: AppDimention.screenWidth - AppDimention.size70,
                                    height: AppDimention.size70,
                                    padding: EdgeInsets.all(AppDimention.size10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(AppDimention.size5)
                                    ),
                                    child: Text("Địa chỉ : 54 Nguyễn Lương Bằng , Hòa Khánh Bắc , Liên Chiểu , Đà Nẵng ",style: TextStyle(fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  ),
                                  ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                        return Container(
                                          width: AppDimention.screenWidth,
                                          margin: EdgeInsets.only(top: AppDimention.size10),
                                          child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                              Container(
                                                width: AppDimention.size100,
                                                child: Text("Gà rán xào tỏi",style: TextStyle(color: Colors.white),overflow: TextOverflow.ellipsis,),
                                              ),
                                              Text("SL : 3",style: TextStyle(color: Colors.white),)
                                          ],
                                        ),
                                        );
                                    }
                                  ),
                                  SizedBox(height: AppDimention.size10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: AppDimention.size150,
                                        height:  AppDimention.size50,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(AppDimention.size5)
                                        ),
                                        child: Center(
                                          child: Text("480.000 vnđ"),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: (){
                                          Get.toNamed(AppRoute.get_order_detail(index));
                                        },
                                        child:  Container(
                                          width: AppDimention.size50,
                                          height:  AppDimention.size50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(AppDimention.size5)
                                          ),
                                          child: Center(
                                            child: Icon(Icons.edit_square,color: Appcolor.mainColor,)
                                          ),
                                        ),
                                      ),
                                       GestureDetector(
                                        onTap: (){
                                          _ShowAnnounce();
                                        },
                                        child: Container(
                                          width: AppDimention.size50,
                                          height:  AppDimention.size50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(AppDimention.size5)
                                          ),
                                          child: Center(
                                            child: Icon(Icons.delivery_dining,color: Appcolor.mainColor,)
                                          ),
                                        ),
                                       )
                                    ],
                                  )
                                ],
                              ),
                            );
                        }
                      )
                  ],
                ),
          )),
          HomeFooter()
        ],
      ),
    );
   }
}