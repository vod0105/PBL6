import 'package:app_shipper/pages/home_page/home_footer.dart';
import 'package:app_shipper/pages/home_page/home_header.dart';
import 'package:app_shipper/pages/home_page/home_list.dart';
import 'package:app_shipper/themes/AppColor.dart';
import 'package:app_shipper/themes/AppDimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetail extends StatefulWidget {
  final int orderCode;
  const OrderDetail({Key? key, required this.orderCode}) : super(key: key);
  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
 
  void _receiveOrder(){
    Get.snackbar("Thông báo", "Nhận đơn hàng thành công");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.all(AppDimention.size20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: (){
                            Get.back();
                        },
                        child: Icon(Icons.arrow_circle_left_outlined,size: AppDimention.size40,color: Appcolor.mainColor,),
                      ),
                      Text(
                        "Mã đơn hàng : 3AMDH8",
                        style: TextStyle(
                            color: Appcolor.mainColor,
                            fontSize: AppDimention.size20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ),
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.only(left: AppDimention.size20),
                  child: Text("Thông tin khách hàng",
                      style: TextStyle(
                        fontSize: AppDimention.size20,
                      )),
                ),
                SizedBox(
                  height: AppDimention.size10,
                ),
                Container(
                  width: AppDimention.screenWidth,
                  margin: EdgeInsets.only(
                      left: AppDimention.size10, right: AppDimention.size10),
                  padding: EdgeInsets.all(AppDimention.size20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black26),
                      borderRadius: BorderRadius.circular(AppDimention.size10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Họ tên : Nguyễn Văn Nhật"),
                      SizedBox(
                        height: AppDimention.size10,
                      ),
                      Text(
                        "Địa chỉ : 54 Nguyễn Lương Bằng , Hòa Khánh Bắc , Liên Chiểu , Đà Nẵng",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: AppDimention.size10,
                      ),
                      Text("Số điện thoại : 0799163083"),
                      SizedBox(
                        height: AppDimention.size10,
                      ),
                      Text("Email : nhat@gmail.com"),
                      SizedBox(
                        height: AppDimention.size20,
                      ),
                      
                    ],
                  ),
                ),
                SizedBox(
                  height: AppDimention.size30,
                ),
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.only(left: AppDimention.size20),
                  child: Text("Thông tin đơn hàng",
                      style: TextStyle(
                        fontSize: AppDimention.size20,
                      )),
                ),
                SizedBox(
                  height: AppDimention.size10,
                ),
                Container(
                    width: AppDimention.screenWidth,
                    margin: EdgeInsets.only(
                        left: AppDimention.size10, right: AppDimention.size10),
                    padding: EdgeInsets.only(
                        left: AppDimention.size20,
                        right: AppDimention.size20,
                        bottom: AppDimention.size20),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black26),
                        borderRadius:
                            BorderRadius.circular(AppDimention.size10)),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: AppDimention.screenWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Gà rán xào sả ớt",
                                    style: TextStyle(
                                        fontSize: AppDimention.size20,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: AppDimention.size5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Size : M"),
                                    Text("SL : 5"),
                                    Text("Giá : 20.000 vnđ"),
                                  ],
                                ),
                                SizedBox(
                                  height: AppDimention.size10,
                                )
                              ],
                            ),
                          );
                        })),
                SizedBox(
                  height: AppDimention.size20,
                ),
                
                SizedBox(
                  height: AppDimention.size20,
                ),
                SizedBox(
                  height: AppDimention.size30,
                  width: AppDimention.screenWidth,
                  child: Container(
                    width: AppDimention.screenWidth,
                    decoration: BoxDecoration(
                        border: Border(top: BorderSide(width: 1))),
                  ),
                ),
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.only(left: AppDimention.size20),
                  child: Text("Thông tin chi tiết",
                      style: TextStyle(
                        fontSize: AppDimention.size20,
                      )),
                ),
                SizedBox(
                  height: AppDimention.size10,
                ),
                Container(
                  width: AppDimention.screenWidth,
                  margin: EdgeInsets.only(
                      left: AppDimention.size10, right: AppDimention.size10),
                  padding: EdgeInsets.all(AppDimention.size20),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black26),
                      borderRadius: BorderRadius.circular(AppDimention.size10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Địa chỉ giao hàng : 54 Nguyễn Lương Bằng , Hòa Khánh Bắc , Liên Chiểu , Đà Nẵng",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: AppDimention.size20,
                      ),
                      Text("Phương thức thanh toán : CASH"),
                       SizedBox(
                        height: AppDimention.size20,
                      ),
                      Text("Ghi chú :Chỉ với vài thao tác đơn giản, mọi thứ sẽ được giao đến đúng nơi mong muốn một cách nhanh chóng và tiện lợi. Không còn cần phải mang đơn hàng đến tận kho hay bưu điện để gửi đi. "),
                      SizedBox(
                        height: AppDimention.size20,
                      ),
                      Text("Tổng đơn hàng : 500.000 vnđ"),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppDimention.size20,
                )
              ],
            ),
          )),
          Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size70,
            decoration: BoxDecoration(
              color: Appcolor.mainColor
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: AppDimention.size150 ,
                  height: AppDimention.size50,
                  decoration: BoxDecoration(
                   
                    borderRadius: BorderRadius.circular(AppDimention.size10)
                  ),
                  child: Center(
                    child: Text("500.000 vnđ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    _receiveOrder();
                  },
                  child: Container(
                    width: AppDimention.size150 + AppDimention.size50,
                    height: AppDimention.size50,
                    margin: EdgeInsets.only(right: AppDimention.size10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppDimention.size10)
                    ),
                    child: Center(
                      child: Text("Nhận đơn hàng",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
