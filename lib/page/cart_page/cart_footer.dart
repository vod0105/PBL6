import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
class CartFooter extends StatefulWidget{
   const CartFooter({
       Key? key,
   }): super(key:key);
   @override
   _CartFooterState createState() => _CartFooterState();
}
class _CartFooterState extends State<CartFooter>{
 TextEditingController addressController = TextEditingController();
String? selectedPaymentMethod;
void _order() async {
  String address = addressController.text.trim();
  String paymentMethod = selectedPaymentMethod!;

  await Get.find<CartController>().orderall(address, paymentMethod);
  var payUrl = Get.find<CartController>().qrcode.payUrl;
  final Uri _url = Uri.parse(payUrl!);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}


void _showDropdown() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Thông tin giao hàng'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: "Địa chỉ của bạn",
                    prefixIcon: Icon(Icons.location_on_outlined, color: AppColor.yellowColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.0, color: Colors.white),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                Text("Phương thức thanh toán:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ListTile(
                  title: Text("Thanh toán tiền mặt"),
                  leading: Radio<String>(
                    value: "CASH",
                    groupValue: selectedPaymentMethod,
                    onChanged: (String? value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text("Chuyển khoản ngân hàng"),
                  leading: Radio<String>(
                    value: "MOMO",
                    groupValue: selectedPaymentMethod,
                    onChanged: (String? value) {
                      setState(() {
                        selectedPaymentMethod = value;
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Đóng"),
              ),
              ElevatedButton(
                onPressed: (){
                  _order();
                  Navigator.of(context).pop();
                },
                child: Text("Đặt hàng"),
              )
            ],
          )
        ],
      );
    },
  );
}



   @override
   Widget build(BuildContext context) {
      return GetBuilder<CartController>(builder: (cartcontrolelr){
        return Container(
        width: AppDimention.screenWidth,
        height: AppDimention.size60,
        decoration: BoxDecoration(
          color: AppColor.yellowColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 15,),
              ),
            ),
            Row(
              children: [
                Text("Tổng tiền: ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Text(cartcontrolelr.totalprice.toString(),style: TextStyle(fontSize: 18),),
              ],
            ),
            GestureDetector(
              onTap: (){
                  _showDropdown();
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: Text("Mua ngay",style: TextStyle(color: Colors.white,fontSize: 16),),
                ),
              ),
            )
          ],
        ),
      );
      });

   }
}