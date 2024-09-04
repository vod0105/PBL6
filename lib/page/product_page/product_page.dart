import 'dart:convert';

import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:android_project/models/Model/StoreModel.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  final int productId;

  ProductPage({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductController productController;
  int quantity = 0;
  int productid = 0;
  int idstore = 0;

  @override
  void initState() {
    super.initState();
    productController = Get.find();
    productid = widget.productId;
    productController.getProductById(widget.productId);
  }

  void _showDropdown(List<String> items, Function(String) onItemSelected) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () {
                  onItemSelected(items[index]);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
  void addtocart(){
      Get.find<ProductController>().addtocart( productid,quantity, idstore);
    }
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      if (productController.productListDetail.isEmpty) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: CircularProgressIndicator()),
        );
      }
      var product = productController.productListDetail[0];
      return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Icon(Icons.arrow_back_ios_new, size: 15),
                      ),
                    ),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Icon(Icons.shopping_cart_outlined, size: 15),
                    ),
                  ),
                ],
              ),
              pinned: true,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(
                      child: Text(
                    product.productName!,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppDimention.size20),
                      topRight: Radius.circular(AppDimention.size20),
                    ),
                  ),
                ),
              ),
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.memory(
                  base64Decode(product.image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: AppDimention.size20, right: AppDimention.size20),
                    child: Text("12312312381236128376127"),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: AppDimention.size20 * 2.5,
                  right: AppDimention.size20 * 2.5,
                  top: AppDimention.size10,
                  bottom: AppDimention.size10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (quantity > 0) quantity--;
                      });
                    },
                    child: Icon(Icons.remove),
                  ),
                  Text(quantity.toString()),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if(quantity <20) quantity++;
                      });
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: AppDimention.size20,
                  bottom: AppDimention.size20,
                  left: AppDimention.size20,
                  right: AppDimention.size20),
              decoration: BoxDecoration(
                color: AppColor.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimention.size20 * 2),
                  topRight: Radius.circular(AppDimention.size20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: AppDimention.size20,
                        bottom: AppDimention.size20,
                        left: AppDimention.size20,
                        right: AppDimention.size20),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppDimention.size20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite_border_rounded,
                          color: AppColor.mainColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: AppDimention.size20,
                        bottom: AppDimention.size20,
                        left: AppDimention.size50,
                        right: AppDimention.size50),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(AppDimention.size20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [Text("Mua ngay")],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showDropdown(
                      (product.stores as List<StoreModel>).map<String>((store) => store.storeName ?? '').toList(),
                      (selectedStoreName) {
                        setState(() {
                          idstore = (product.stores as List<StoreModel>).firstWhere((store) => store.storeName == selectedStoreName).storeId!;
                          addtocart();
                        });
                      },
                      
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                          top: AppDimention.size20,
                          bottom: AppDimention.size20,
                          left: AppDimention.size20,
                          right: AppDimention.size20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppDimention.size20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColor.mainColor,
                          ),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
