import 'package:android_project/page/cart_page/cart_header.dart';
import 'package:android_project/page/cart_page/cart_list.dart';
import 'package:flutter/material.dart';
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
            //  HomeFooter(),
            
          ],
        ),
      );
   }
}