import 'package:app_shipper/pages/home_page/home_footer.dart';
import 'package:app_shipper/pages/home_page/home_header.dart';
import 'package:app_shipper/pages/home_page/home_list.dart';
import 'package:app_shipper/themes/AppColor.dart';
import 'package:app_shipper/themes/AppDimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailReceive extends StatefulWidget {
  final int orderCode;
  const OrderDetailReceive({Key? key, required this.orderCode}) : super(key: key);
  @override
  _OrderDetailReceiveState createState() => _OrderDetailReceiveState();
}

class _OrderDetailReceiveState extends State<OrderDetailReceive> {
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void _sendSMS(String phoneNumber) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not send SMS to $phoneNumber';
    }
  }

  void _sendEmail(String email, String subject, String body) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not send email to $email';
    }
  }
  void _changeStatus() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bạn muốn chuyển trạng thái đơn hàng?',style: TextStyle(fontSize: 15),),
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
                        Get.close(1);
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
                          Get.snackbar("Thông báo", "Chuyển trạng thái thành công");
                          Get.close(1);
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

  void _ShowSendMessage(String email, String ordercode) {
    TextEditingController messageController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                  width: AppDimention.size100 * 3,
                  height: AppDimention.size100 * 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                          width: AppDimention.size100 * 3,
                          height: AppDimention.size100 * 2.3,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black26),
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size5)),
                          child: TextField(
                            controller: messageController,
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.all(AppDimention.size10),
                            ),
                          )),
                      SizedBox(
                        height: AppDimention.size20,
                      ),
                      Center(
                          child: GestureDetector(
                        onTap: () {
                          _sendEmail(
                              email,
                              "Thông báo đơn hàng số ${ordercode}",
                              messageController.text);
                        },
                        child: Container(
                          width: AppDimention.size150,
                          height: AppDimention.size50,
                          decoration: BoxDecoration(
                              color: Appcolor.mainColor,
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size10)),
                          child: Center(
                            child: Text(
                              "Gửi ngay",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ))
                    ],
                  ));
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
                  height: AppDimention.size100 * 3,
                  decoration: BoxDecoration(
                    color: Colors.amber
                  ),
                ),
                SizedBox(height: AppDimention.size20,),
                Container(
                  width: AppDimention.screenWidth,
                  child: Row(
                    children: [
                      SizedBox(width: AppDimention.size10),
                      Icon(Icons.feed,size:AppDimention.size30,color: Colors.red,),
                      SizedBox(width: AppDimention.size10,),
                      Text("Doanh thu của bạn : 10.000 vnđ",style: TextStyle(color: Colors.red),)
                    ],
                  ),
                ),
                SizedBox(height: AppDimention.size20,),
                Container(
                  width: AppDimention.screenWidth,  
                  height: AppDimention.size120,     
                  child: Stack(
                    children: [
                      Positioned(
                        top: 30,
                        left: 0,
                        child: Container(
                          width: AppDimention.screenWidth, 
                          height: AppDimention.size10, 
                         
                          decoration: BoxDecoration(
                             color: Appcolor.mainColor, 
                            borderRadius: BorderRadius.circular(AppDimention.size10)
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child:Container(
                          width: AppDimention.screenWidth,
                          child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(AppDimention.size30)
                                  ),
                                  child: Center(
                                    child: Icon(Icons.receipt_long_rounded,color: Colors.white,),
                                  )
                                ),
                               Container(
                                width: AppDimention.size60,
                                child: Center(
                                  child:  Text("Đã xác nhận",maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                ),
                               )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    // color: Colors.yellow,
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(AppDimention.size30)
                                  ),
                                  child: Center(
                                    child: Icon(Icons.outbox_rounded,color: Colors.white,),
                                  )
                                ),
                                 Container(
                                  width: AppDimention.size60,
                                  child: Center(
                                    child:  Text("Đang lấy hàng",maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                  ),
                                )
                              ],
                            ),
                           Column(
                            children: [
                               Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    // color: Colors.blue,
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(AppDimention.size30)
                                  ),
                                  child: Center(
                                    child: Icon(Icons.delivery_dining,color: Colors.white,),
                                  )
                                ),
                               Container(
                                  width: AppDimention.size60,
                                  child: Center(
                                    child:  Text("Đang giao",maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                  ),
                                )
                            ],
                           ),
                             Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    // color: Colors.red,
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(AppDimention.size30)
                                  ),
                                  child: Center(
                                    child: Icon(Icons.check_box,color: Colors.white,),
                                  )
                                ),
                                Container(
                                  width: AppDimention.size60,
                                  child: Center(
                                    child:  Text("Hoàn thành",maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                  ),
                                )
                              ],
                             )
                 
                          ],
                        ),
                        )
                      )
                    ],
                  ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _ShowSendMessage(
                                  "nhataaghjkl@gmail.com", "3AMDHD8");
                            },
                            child: Container(
                              width: AppDimention.size100,
                              height: AppDimention.size50,
                              decoration: BoxDecoration(
                                  color: Appcolor.mainColor,
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size10)),
                              child: Center(
                                child: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                  size: AppDimention.size30,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _sendSMS("0799163083");
                            },
                            child: Container(
                              width: AppDimention.size100,
                              height: AppDimention.size50,
                              decoration: BoxDecoration(
                                  color: Appcolor.mainColor,
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size10)),
                              child: Center(
                                child: Icon(
                                  Icons.pending,
                                  color: Colors.white,
                                  size: AppDimention.size30,
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                _makePhoneCall("0799163083");
                              },
                              child: Container(
                                width: AppDimention.size100,
                                height: AppDimention.size50,
                                decoration: BoxDecoration(
                                    color: Appcolor.mainColor,
                                    borderRadius: BorderRadius.circular(
                                        AppDimention.size10)),
                                child: Center(
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: AppDimention.size30,
                                  ),
                                ),
                              ))
                        ],
                      )
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
                    _changeStatus();
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
                      child: Text("Chuyển trạng thái",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
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
