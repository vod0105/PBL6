import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartFooter extends StatefulWidget {
  const CartFooter({
    super.key,
  });
  @override
  CartFooterState createState() => CartFooterState();
}

class CartFooterState extends State<CartFooter> {
  TextEditingController addressController = TextEditingController();
  String? selectedPaymentMethod;
  CartController cartController = Get.find<CartController>();
  void checkItem() {
    if (cartController.idSelectedItem.isEmpty &&
        cartController.idSelectedStore.isEmpty &&
        cartController.idSelectedCombo.isEmpty ) {
      Get.snackbar(
        "Thông báo",
        "Vui lòng chọn sản phẩm",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        icon: const Icon(Icons.warning, color: Colors.red),
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 1),
        isDismissible: true,
        
      );
    } else {
      Get.toNamed(AppRoute.ORDER_CART_PAGE);
    }
  }

   String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      return Container(
        width: AppDimention.screenWidth,
        height: AppDimention.size60,
        decoration: const BoxDecoration(color: AppColor.yellowColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: AppDimention.size30,
                height: AppDimention.size30,
                decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(AppDimention.size30)),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ),
            Row(
              children: [
                
                Text(
                  "đ${_formatNumber( cartController.totalPrice.toInt() )}",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                checkItem();
              },
              child: Container(
                width: AppDimention.size120,
                height: AppDimention.size50,
                decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(5)),
                child: const Center(
                  child: Text(
                    "Mua ngay",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
