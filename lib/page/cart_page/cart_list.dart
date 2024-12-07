import 'dart:convert';

import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/data/controller/Product_controller.dart';

import 'package:android_project/models/Model/CartModel.dart';
import 'package:android_project/models/Model/Item/ProductItem.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  CartListState createState() => CartListState();
}

class CartListState extends State<CartList> {
  CartController cartController = Get.find<CartController>();
  ProductController productController = Get.find<ProductController>();
  List<bool> isSelected = [];
  List<List<bool>> isProductSelected = [];
  List<int> storeSelected = [];
  List<int> cartSelected = [];
  List<int> comboSelected = [];
  int? tempStoreId;

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }

  void _showDialogDelete(int cartId) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
                  width: AppDimention.screenWidth * 2 / 3,
                  height: AppDimention.size100 * 1.5,
                  decoration: const BoxDecoration(),
                  child: StatefulBuilder(builder: (context, setState) {
                    return Container(
                      padding: EdgeInsets.all(AppDimention.size20),
                      child: Column(
                        children: [
                          const Text("Bạn muốn xóa sản phẩm này ?"),
                          SizedBox(
                            height: AppDimention.size30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  width: AppDimention.size100,
                                  height: AppDimention.size40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppDimention.size5),
                                      border: Border.all(
                                          width: 1, color: Colors.redAccent)),
                                  child: const Center(
                                    child: Text("Hủy"),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cartController.deleteCart(cartId);
                                  cartController.getAll();
                                  cartController.getListCartV2();

                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: AppDimention.size100,
                                  height: AppDimention.size40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppDimention.size5),
                                      border: Border.all(
                                          width: 1, color: Colors.greenAccent)),
                                  child: const Center(
                                    child: Text("Đồng ý"),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  })));
        });
  }

  // Show dialog when update cart item
  void _showDialogUpdate(CartData cartData) {
    ProductInCart? productInCart;
    ComboInCart? comboInCart;
    int quantity;
    bool? key;
    if (cartData.type == "product") {
      productInCart = cartData.product;
      key = true;
      quantity = cartData.product!.quantity!;
    } else {
      comboInCart = cartData.combo;
      key = false;
      quantity = cartData.combo!.quantity!;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
                  width: AppDimention.screenWidth * 2 / 3,
                  height: AppDimention.size100 * 2.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimention.size10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(base64Decode(key!
                              ? productInCart!.image!
                              : comboInCart!.image!)))),
                  child: StatefulBuilder(builder: (context, setState) {
                    return Container(
                        padding: EdgeInsets.all(AppDimention.size20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppDimention.size10),
                            color: Colors.black.withOpacity(0.3)),
                        child: Column(children: [
                          Text(
                            "${key! ? productInCart!.productName! : comboInCart!.comboName}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24),
                          ),
                          SizedBox(
                            height: AppDimention.size20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (quantity > 1) {
                                      quantity = quantity - 1;
                                    }
                                  });
                                },
                                child: Container(
                                  width: AppDimention.size50,
                                  height: AppDimention.size50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.white)),
                                  child: const Center(
                                    child: Icon(Icons.remove,
                                        size: 25, color: Colors.white),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: AppDimention.size50,
                                  height: AppDimention.size50,
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: Colors.white),
                                          top: BorderSide(
                                              width: 1, color: Colors.white))),
                                  child: Center(
                                    child: Text(
                                      "$quantity",
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (quantity < 11) {
                                      quantity = quantity + 1;
                                    }
                                  });
                                },
                                child: Container(
                                  width: AppDimention.size50,
                                  height: AppDimention.size50,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.white)),
                                  child: const Center(
                                    child: Icon(Icons.add,
                                        size: 25, color: Colors.white),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: AppDimention.size20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: AppDimention.size100,
                                  height: AppDimention.size40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          AppDimention.size5)),
                                  child: Center(
                                    child: Text("Hủy",
                                        style:
                                            TextStyle(color: Colors.red[100])),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: AppDimention.size20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  cartController.updateCart(
                                      cartData.cartId!, quantity);
                                  cartController.getAll();
                                  cartController.getListCartV2();

                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: AppDimention.size100,
                                  height: AppDimention.size40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          AppDimention.size5)),
                                  child: Center(
                                    child: Text("Đồng ý",
                                        style: TextStyle(
                                            color: Colors.green[100])),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]));
                  })));
        });
  }

  // Show list water
  void _showDialogWater(List<int> listWater) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimention.size10),
              ),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: AppDimention.screenWidth,
                  height: AppDimention.size100 * 2.5,
                  padding: EdgeInsets.all(AppDimention.size10),
                  child: Column(
                    children: listWater.map((item) {
                      Productitem? productitem =
                          productController.getProductById(item);
                      return Container(
                          width: AppDimention.screenWidth,
                          height: AppDimention.size100,
                          padding: EdgeInsets.all(AppDimention.size10),
                          margin: EdgeInsets.only(bottom: AppDimention.size10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size10),
                              image: DecorationImage(
                                  image: MemoryImage(
                                      base64Decode(productitem!.image!)),
                                  fit: BoxFit.cover)),
                          child: Container(
                            width: AppDimention.screenWidth,
                            height: AppDimention.size100,
                            padding: EdgeInsets.all(AppDimention.size10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  productitem.productName!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "đ${_formatNumber(productitem.discountedPrice != null ? productitem.discountedPrice!.toInt() : productitem.price!.toInt())}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ));
                    }).toList(),
                  ),
                );
              }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      if (isSelected.length != cartController.listCart.length) {
        isSelected = List<bool>.filled(cartController.listCart.length, false);
      }
      if (isProductSelected.length != cartController.listCart.length) {
        isProductSelected = List.generate(
            cartController.listCart.length,
            (index) => List<bool>.filled(
                cartController.listCart[index].cartData!.length, false));
      }
      if (cartController.listCart.isEmpty) {
        return SizedBox(
          width: AppDimention.screenWidth,
          height: AppDimention.size170 + AppDimention.size5,
          child: const Center(
            child: Text("Bạn không có món ăn trong giỏ hàng"),
          ),
        );
      } else {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cartController.listCart.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Container(
                width: AppDimention.screenWidth,
                margin: EdgeInsets.only(
                  bottom: AppDimention.size10,
                ),
                padding: EdgeInsets.only(
                  left: AppDimention.size10,
                  right: AppDimention.size10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: AppDimention.screenWidth,
                      child: Column(
                        children: [
                          // Header of cart box
                          Container(
                            width: AppDimention.screenWidth,
                            decoration:
                                const BoxDecoration(color: AppColor.mainColor),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isSelected[index],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isSelected[index] = value!;

                                      if (value) {
                                        // Tat ca cac cua hang khac = false
                                        for (int i = 0;
                                            i < isSelected.length;
                                            i++) {
                                          if (i != index) {
                                            isSelected[i] = false;
                                          }
                                        }
                                        // Store được chọn là store hiện tại
                                        storeSelected = [
                                          cartController.listCart[index]
                                              .storeItem!.storeId!
                                        ];
                                        tempStoreId = cartController
                                            .listCart[index].storeItem!.storeId;
                                        for (int i = 0;
                                            i < isProductSelected.length;
                                            i++) {
                                          for (int j = 0;
                                              j < isProductSelected[i].length;
                                              j++) {
                                            isProductSelected[i][j] = false;
                                          }
                                        }

                                        for (int i = 0;
                                            i <
                                                cartController.listCart[index]
                                                    .cartData!.length;
                                            i++) {
                                          isProductSelected[index][i] = true;

                                          if (cartController.listCart[index]
                                                  .cartData![i].type ==
                                              "product") {
                                            ProductInCart? productInCart =
                                                cartController.listCart[index]
                                                    .cartData![i].product;
                                            if (!cartSelected.contains(
                                                productInCart!.productId!)) {
                                              cartController.updateTotal(
                                                  cartController.totalPrice,
                                                  false);
                                              cartController.updateTotal(
                                                  productInCart.unitPrice!
                                                          .toInt() *
                                                      productInCart.quantity!
                                                          .toInt(),
                                                  true);
                                              cartSelected.add(
                                                  productInCart.productId!);
                                            }
                                          } else {
                                            ComboInCart? comboInCart =
                                                cartController.listCart[index]
                                                    .cartData![i].combo;
                                            if (!comboSelected.contains(
                                                comboInCart!.comboId!)) {
                                              cartController.updateTotal(
                                                  comboInCart.unitPrice!
                                                          .toInt() *
                                                      comboInCart.quantity!
                                                          .toInt(),
                                                  true);
                                              if (comboInCart
                                                  .drinkId!.isNotEmpty) {
                                                for (int idDrink
                                                    in comboInCart.drinkId!) {
                                                  Productitem? drink =
                                                      productController
                                                          .getProductById(
                                                              idDrink);
                                                  cartController.updateTotal(
                                                      drink!.discountedPrice !=
                                                              null
                                                          ? drink
                                                              .discountedPrice!
                                                              .toInt()
                                                          : drink.price!
                                                              .toInt(),
                                                      true);
                                                }
                                              }
                                              comboSelected
                                                  .add(comboInCart.comboId!);
                                            }
                                          }
                                          cartController.idSelectedItem.clear();
                                          cartController.updateIDSelectedItem(
                                              cartController.listCart[index]
                                                  .cartData![i].cartId!,
                                              true);
                                        }
                                        cartController.idSelectedStore.clear();
                                        cartController.updateIDSelectedStore(
                                            cartController.listCart[index]
                                                .storeItem!.storeId!,
                                            true);
                                      } else {
                                        tempStoreId = null;
                                        storeSelected.remove(cartController
                                            .listCart[index]
                                            .storeItem!
                                            .storeId!);
                                        for (int i = 0;
                                            i <
                                                cartController.listCart[index]
                                                    .cartData!.length;
                                            i++) {
                                          isProductSelected[index][i] = false;

                                          if (cartController.listCart[index]
                                                  .cartData![i].type ==
                                              "product") {
                                            ProductInCart? productInCart =
                                                cartController.listCart[index]
                                                    .cartData![i].product;
                                            if (cartSelected.contains(
                                                productInCart!.productId!)) {
                                              cartController.updateTotal(
                                                  productInCart.unitPrice!
                                                          .toInt() *
                                                      productInCart.quantity!
                                                          .toInt(),
                                                  false);
                                              cartSelected.remove(
                                                  productInCart.productId!);
                                            }
                                          } else {
                                            ComboInCart? comboInCart =
                                                cartController.listCart[index]
                                                    .cartData![i].combo;
                                            if (comboSelected.contains(
                                                comboInCart!.comboId!)) {
                                              cartController.updateTotal(
                                                  comboInCart.unitPrice!
                                                          .toInt() *
                                                      comboInCart.quantity!
                                                          .toInt(),
                                                  false);
                                              if (comboInCart
                                                  .drinkId!.isNotEmpty) {
                                                for (int idDrink
                                                    in comboInCart.drinkId!) {
                                                  Productitem? drink =
                                                      productController
                                                          .getProductById(
                                                              idDrink);
                                                  cartController.updateTotal(
                                                      drink!.discountedPrice !=
                                                              null
                                                          ? drink
                                                              .discountedPrice!
                                                              .toInt()
                                                          : drink.price!
                                                              .toInt(),
                                                      false);
                                                }
                                              }
                                              comboSelected
                                                  .remove(comboInCart.comboId!);
                                            }
                                          }
                                          cartController.updateIDSelectedItem(
                                              cartController.listCart[index]
                                                  .cartData![i].cartId!,
                                              false);
                                        }
                                        cartController.updateIDSelectedStore(
                                            cartController.listCart[index]
                                                .storeItem!.storeId!,
                                            false);
                                      }
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: AppDimention.size100 * 3,
                                  child: Text(
                                    cartController
                                        .listCart[index].storeItem!.storeName!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),

                          Container(
                            width: AppDimention.screenWidth,
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            child: Column(
                              children: cartController.listCart[index].cartData!
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                int itemIndex = entry.key;
                                var item = entry.value;
                                ProductInCart? productInCart;
                                ComboInCart? comboInCart;
                                int quantity;
                                bool? key;
                                if (item.type == "product") {
                                  productInCart = item.product;
                                  key = true;
                                  quantity = item.product!.quantity!;
                                } else {
                                  comboInCart = item.combo;
                                  key = false;
                                  quantity = item.combo!.quantity!;
                                }
                                return Column(
                                  children: [
                                    Container(
                                      width: AppDimention.screenWidth,
                                      padding: EdgeInsets.only(
                                          top: AppDimention.size10,
                                          bottom: AppDimention.size10),
                                      child: Row(
                                        children: [
                                          Checkbox(
                                            value: isProductSelected[index]
                                                [itemIndex],
                                            onChanged: (bool? value) {
                                              setState(() {
                                                if (value!) {
                                                  if (key!) {
                                                    if (tempStoreId == null) {
                                                      tempStoreId =
                                                          productInCart!
                                                              .storeId!;
                                                      isProductSelected[index]
                                                          [itemIndex] = value;

                                                      cartSelected.add(
                                                          productInCart
                                                              .productId!);
                                                      cartController.updateTotal(
                                                          productInCart
                                                                  .unitPrice!
                                                                  .toInt() *
                                                              quantity,
                                                          true);
                                                      cartController
                                                          .updateIDSelectedItem(
                                                              item.cartId!,
                                                              true);
                                                    } else {
                                                      if (productInCart!
                                                              .storeId ==
                                                          tempStoreId) {
                                                        isProductSelected[index]
                                                            [itemIndex] = value;
                                                        cartSelected.add(
                                                            productInCart
                                                                .productId!);
                                                        cartController.updateTotal(
                                                            productInCart
                                                                    .unitPrice!
                                                                    .toInt() *
                                                                quantity,
                                                            true);
                                                        cartController
                                                            .updateIDSelectedItem(
                                                                item.cartId!,
                                                                true);
                                                      }
                                                    }
                                                  } else {
                                                    if (tempStoreId == null) {
                                                      tempStoreId =
                                                          comboInCart!.storeId!;
                                                      isProductSelected[index]
                                                          [itemIndex] = value;

                                                      comboSelected.add(
                                                          comboInCart.comboId!);
                                                      cartController.updateTotal(
                                                          comboInCart.unitPrice!
                                                                  .toInt() *
                                                              quantity,
                                                          true);
                                                      if (comboInCart.drinkId!
                                                          .isNotEmpty) {
                                                        for (int idDrink
                                                            in comboInCart
                                                                .drinkId!) {
                                                          Productitem? drink =
                                                              productController
                                                                  .getProductById(
                                                                      idDrink);
                                                          cartController.updateTotal(
                                                              drink!.discountedPrice !=
                                                                      null
                                                                  ? drink
                                                                      .discountedPrice!
                                                                      .toInt()
                                                                  : drink.price!
                                                                      .toInt(),
                                                              true);
                                                        }
                                                      }
                                                      cartController
                                                          .updateIDSelectedCombo(
                                                              item.cartId!,
                                                              true);
                                                    } else {
                                                      if (comboInCart!
                                                              .storeId! ==
                                                          tempStoreId) {
                                                        isProductSelected[index]
                                                            [itemIndex] = value;

                                                        comboSelected.remove(
                                                            comboInCart
                                                                .comboId!);
                                                        cartController.updateTotal(
                                                            comboInCart
                                                                    .unitPrice!
                                                                    .toInt() *
                                                                quantity,
                                                            true);
                                                        if (comboInCart.drinkId!
                                                            .isNotEmpty) {
                                                          for (int idDrink
                                                              in comboInCart
                                                                  .drinkId!) {
                                                            Productitem? drink =
                                                                productController
                                                                    .getProductById(
                                                                        idDrink);
                                                            cartController.updateTotal(
                                                                drink!.discountedPrice !=
                                                                        null
                                                                    ? drink
                                                                        .discountedPrice!
                                                                        .toInt()
                                                                    : drink
                                                                        .price!
                                                                        .toInt(),
                                                                true);
                                                          }
                                                        }
                                                        cartController
                                                            .updateIDSelectedCombo(
                                                                item.cartId!,
                                                                true);
                                                      }
                                                    }
                                                  }
                                                } else {
                                                  if (key!) {
                                                    if (cartSelected.length ==
                                                        1) {
                                                      tempStoreId = null;
                                                      storeSelected = [];
                                                    }

                                                    isProductSelected[index]
                                                        [itemIndex] = value;
                                                    cartSelected.remove(
                                                        productInCart!
                                                            .productId!);
                                                    cartController.updateTotal(
                                                        productInCart.unitPrice!
                                                                .toInt() *
                                                            quantity,
                                                        false);
                                                    cartController
                                                        .updateIDSelectedItem(
                                                            item.cartId!,
                                                            false);
                                                  } else {
                                                    if (cartSelected.length ==
                                                        1) {
                                                      tempStoreId = null;
                                                      storeSelected = [];
                                                    }
                                                    isProductSelected[index]
                                                        [itemIndex] = value;
                                                    comboSelected.remove(
                                                        comboInCart!.comboId!);
                                                    cartController.updateTotal(
                                                        comboInCart.unitPrice!
                                                                .toInt() *
                                                            quantity,
                                                        false);
                                                    if (comboInCart
                                                        .drinkId!.isNotEmpty) {
                                                      for (int idDrink
                                                          in comboInCart
                                                              .drinkId!) {
                                                        Productitem? drink =
                                                            productController
                                                                .getProductById(
                                                                    idDrink);
                                                        cartController.updateTotal(
                                                            drink!.discountedPrice !=
                                                                    null
                                                                ? drink
                                                                    .discountedPrice!
                                                                    .toInt()
                                                                : drink.price!
                                                                    .toInt(),
                                                            false);
                                                      }
                                                    }
                                                    cartController
                                                        .updateIDSelectedCombo(
                                                            item.cartId!,
                                                            false);
                                                  }
                                                }
                                              });
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(key!
                                                  ? AppRoute.get_product_detail(
                                                      productInCart!.productId!)
                                                  : AppRoute.get_combo_detail(
                                                      comboInCart!.comboId!));
                                            },
                                            child: Container(
                                              width: AppDimention.size60,
                                              height: AppDimention.size60,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: Colors.black26),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppDimention.size5),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: MemoryImage(
                                                          base64Decode(key
                                                              ? productInCart!
                                                                  .image!
                                                              : comboInCart!
                                                                  .image!)))),
                                            ),
                                          ),
                                          SizedBox(
                                            width: AppDimention.size20,
                                          ),
                                          SizedBox(
                                            width:
                                                AppDimention.screenWidth * 0.55,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(key
                                                    ? productInCart!
                                                        .productName!
                                                    : comboInCart!.comboName!),
                                                Text(
                                                    "Size : ${key ? productInCart!.size! : comboInCart!.size!}"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "đ${_formatNumber(key ? productInCart!.unitPrice!.toInt() : comboInCart!.unitPrice!.toInt())}",
                                                      style: const TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            width: AppDimention
                                                                .size20,
                                                            height: AppDimention
                                                                .size20,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .black26)),
                                                            child: const Center(
                                                              child: Icon(
                                                                  Icons.remove,
                                                                  size: 15),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            width: AppDimention
                                                                .size20,
                                                            height: AppDimention
                                                                .size20,
                                                            decoration: const BoxDecoration(
                                                                border: Border(
                                                                    bottom: BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black26),
                                                                    top: BorderSide(
                                                                        width:
                                                                            1,
                                                                        color: Colors
                                                                            .black26))),
                                                            child: Center(
                                                              child: Text(
                                                                "${key ? productInCart!.quantity : comboInCart!.quantity}",
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {},
                                                          child: Container(
                                                            width: AppDimention
                                                                .size20,
                                                            height: AppDimention
                                                                .size20,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: Colors
                                                                        .black26)),
                                                            child: const Center(
                                                              child: Icon(
                                                                  Icons.add,
                                                                  size: 13),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: AppDimention.screenWidth,
                                      height: AppDimention.size30,
                                      padding: EdgeInsets.only(
                                          left: AppDimention.size20,
                                          right: AppDimention.size20),
                                      decoration: const BoxDecoration(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (!key)
                                            GestureDetector(
                                              onTap: () {
                                                _showDialogWater(
                                                    comboInCart!.drinkId!);
                                              },
                                              child: Container(
                                                width: AppDimention.size100,
                                                height: AppDimention.size25,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppDimention.size5),
                                                ),
                                                child: const Center(
                                                  child: Text("Nước uống"),
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                            width: AppDimention.size10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _showDialogUpdate(item);
                                            },
                                            child: Container(
                                              width: AppDimention.size25,
                                              height: AppDimention.size25,
                                              decoration: BoxDecoration(
                                                color: Colors.greenAccent,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimention.size5),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons
                                                      .drive_file_rename_outline_rounded,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: AppDimention.size10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _showDialogDelete(item.cartId!);
                                            },
                                            child: Container(
                                              width: AppDimention.size25,
                                              height: AppDimention.size25,
                                              decoration: BoxDecoration(
                                                color: Colors.redAccent,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimention.size5),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }
}
