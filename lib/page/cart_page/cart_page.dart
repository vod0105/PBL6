import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/page/cart_page/cart_footer.dart';
import 'package:android_project/page/cart_page/cart_header.dart';
import 'package:android_project/page/cart_page/cart_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CartPage extends StatefulWidget{
   const CartPage({
       Key? key,
   }): super(key:key);
   @override
   _CartPageState createState() => _CartPageState();
}
class _CartPageState extends State<CartPage>{
   @override
   Widget build(BuildContext context) {
    Get.find<CartController>().getall();
      return Scaffold(
        body: Column(
          children: [
            CartHeader(),
            Expanded(
              child: SingleChildScrollView(
              child: Column(
                children: [
                    CartList(),
                   
                ],
              ),
              
            )
            ),
            CartFooter()
            
          ],
        ),
      );
   }
}