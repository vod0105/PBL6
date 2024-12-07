import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/page/cart_page/cart_footer.dart';
import 'package:android_project/page/cart_page/cart_header.dart';
import 'package:android_project/page/cart_page/cart_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });
  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  CartController cartController =  Get.find<CartController>();
  @override
  void initState() {
    super.initState();
    cartController.getAll();
    cartController.getListCartV2();
    cartController.resetIDSelected();
    cartController.getDistinctStoreId();

    cartController.updateTotal(cartController.totalPrice, false);

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
          )),
          CartFooter()
        ],
      ),
    );
  }
}
