import 'package:android_project/page/cart_page/cart_footer.dart';
import 'package:android_project/page/cart_page/cart_header.dart';
import 'package:android_project/page/cart_page/cart_list.dart';
import 'package:android_project/page/order_page/order_footer.dart';
import 'package:android_project/page/order_page/order_header.dart';
import 'package:android_project/page/order_page/order_list.dart';
import 'package:flutter/material.dart';
class OrderPage extends StatefulWidget{
   const OrderPage({
       Key? key,
   }): super(key:key);
   @override
   _OrderPageState createState() => _OrderPageState();
}
class _OrderPageState extends State<OrderPage>{
   @override
   Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: [
            OrderHeader(),
            Expanded(
              child: SingleChildScrollView(
              child: Column(
                children: [
                    OrderList(),
                   
                ],
              ),
              
            )
            ),
            OrderFooter()
            
          ],
        ),
      );
   }
}