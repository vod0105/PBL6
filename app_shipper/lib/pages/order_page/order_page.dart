import 'package:app_shipper/pages/home_page/home_footer.dart';
import 'package:app_shipper/pages/home_page/home_header.dart';
import 'package:app_shipper/pages/home_page/home_list.dart';
import 'package:app_shipper/pages/order_page/order_footer.dart';
import 'package:app_shipper/route/app_route.dart';
import 'package:app_shipper/themes/AppColor.dart';
import 'package:app_shipper/themes/AppDimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class OrderPage extends StatefulWidget{
   const OrderPage({
       Key? key,
   }): super(key:key);
   @override
   _OrderPageState createState() => _OrderPageState();
}
class _OrderPageState extends State<OrderPage>{

  void _viewMap(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bản đồ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  width: AppDimention.size100 * 3,
                  height: AppDimention.size100 *5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  
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
                  Text("Đơn hàng của bạn",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),)
                ],
              ),
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: AppDimention.size150,
                      height: AppDimention.size40,
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(AppDimention.size40),bottomRight: Radius.circular(AppDimention.size40))
                      ),
                      child: GestureDetector(
                        onTap: (){
                            _viewMap();
                        },
                        child: Center(
                          child: Text("Xem bản đồ",style: TextStyle(color: Colors.white,fontSize: AppDimention.size15,)),
                        ),
                      )
                    ),
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          Get.toNamed(AppRoute.get_order_detail_receive(index));
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
          OrderFooter()
        ],
      ),
    );
   }
}