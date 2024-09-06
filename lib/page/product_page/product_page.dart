import 'dart:convert';

import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/models/Dto/CartDto.dart';
import 'package:android_project/models/Model/StoreModel.dart';
import 'package:android_project/route/app_route.dart';
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
  int quantity = 1;
  int productid = 0;
  int idstore = 0;
  bool showDescription = true;

  @override
  void initState() {
    super.initState();
    productController = Get.find();
    productid = widget.productId;
    productController.getProductById(widget.productId);
  }

  void _toggleContent(bool isDescription) {
    setState(() {
      showDescription = isDescription;
    });
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

  void addtocart() {
    Get.find<ProductController>().addtocart(productid, quantity, idstore);
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
      if (productController.productListBycategory.isEmpty) {
        productController.getProductByCategoryId(product.category.categoryId);
      }
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
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(AppRoute.CART_PAGE);
                    },
                    child: Container(
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
                  )
                ],
              ),
              pinned: true,
              backgroundColor: const Color.fromARGB(255, 243, 134, 134),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimention.size20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: AppDimention.size20, right: AppDimention.size20),
                        child: Text(
                          product.price.toString() +" vnđ ",
                          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: AppDimention.size20, right: AppDimention.size20),
                        child: Row(
                          children: [
                            Wrap(children: List.generate(5, (index) => Icon(Icons.star,color: AppColor.mainColor,size: AppDimention.size15)),),
                            Text("( 5 )",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: AppColor.mainColor),),
            
                          ],
                        )
                        
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimention.size10,),
                 
                  Container(
                    margin: EdgeInsets.only(
                        left: AppDimention.size20, right: AppDimention.size20),
                    child: Text(
                      "Giá khuyến mãi : " + product.discountedPrice.toString() + " vnđ",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: AppDimention.size20, right: AppDimention.size20),
                    child: Text(
                      "Số lượng còn lại : " + product.stockQuantity.toString(),
                    ),
                  ),
                 
                ],
              ),
            ),
       
            SliverToBoxAdapter(
              child: Container(
                width: AppDimention.screenWidth,
                height: 300,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: Colors.black26),
                    bottom: BorderSide(width: 1, color: Colors.black26),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 300,
                      child: Center(
                        child: Icon(
                          Icons.location_on,
                          size: 60,
                          color: AppColor.mainColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 30),
                        height: 300,
                        child: SingleChildScrollView(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: product.stores.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                padding: EdgeInsets.all(10),
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(width: 1, color: Colors.black26),
                                    left: BorderSide(width: 1, color: Colors.black26),
                                  ),
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Cửa hàng số " +
                                          product.stores[index].storeId.toString() +
                                          " : " +
                                          product.stores[index].storeName,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Địa chỉ : " + product.stores[index].location,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => _toggleContent(true),
                        child: Container(
                        
                          child: Container(
                            width:AppDimention.screenWidth/2,
                            height: 50,
                            decoration: BoxDecoration(
                              color:  showDescription ? AppColor.mainColor : Colors.white
                            ),
                            child: Center(
                              child: Text(
                                "Mô tả",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: showDescription ? Colors.white : Colors.black,
                                ),
                              ),
                            )
                          )
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _toggleContent(false),
                        child: Container(
                          width: AppDimention.screenWidth/2,
                            height: 50,
                            decoration: BoxDecoration(
                              color:  !showDescription ? AppColor.mainColor : Colors.white
                            ),
                          child: Center(
                              child: Text(
                                "Đánh giá",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: !showDescription ? Colors.white : Colors.black,
                                ),
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                  Container(
                      width: AppDimention.screenWidth,
                      child: showDescription
                          ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height:10),
                                    Text("Mô tả : " +product.description),
                                    SizedBox(height:10),
                                    Text("Danh mục  : " +product.category.categoryName),
                                    SizedBox(height: 50,),
                                    Container(
                                      margin: EdgeInsets.only(right: 8),
                                      width: AppDimention.screenWidth,
                                      height: 60,
                                       decoration: BoxDecoration(
                                      
                                        color: Colors.grey[200]
                                      ),
                                      child: Center(
                                        child: Text("Có thể bạn sẽ thích",style: TextStyle(fontSize: 20,color: Colors.blue),),
                                      ),
                                    ),
                                     GridView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true, 
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,  
                                          crossAxisSpacing: 10.0,  
                                          mainAxisSpacing: 10.0, 
                                          childAspectRatio: 1.0,  
                                        ),
                                        itemCount: productController.productListBycategory.length > 10 ? 10 : productController.productListBycategory.length ,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: (){
                                                    Get.toNamed(AppRoute.get_product_detail(productController.productListBycategory[index].productId));
                                            },
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  child: Container(
                                                    width: 180,
                                                    height: 180,
                                                    decoration: BoxDecoration(
                                                      
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: MemoryImage(base64Decode(productController.productListBycategory[index].image!)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  child: Container(
                                                    width: 180,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        border: Border(bottom: BorderSide(width: 1,color: Colors.black38))
                                                    ),
                                                    child: Center(
                                                      child: Text(productController.productListBycategory[index].productName,style: TextStyle(color: AppColor.mainColor,fontSize: 20,),),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                     )
                                  ],
                                )
                           
                          : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context , index){
                                    return Container(
                                      width: AppDimention.screenWidth,
                                      height: 150,
                                      margin: EdgeInsets.only(top: 15),
                                     
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 150,
                                            padding: EdgeInsets.only(left: 10),
                                      
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      width: 50,
                                                      height: 50,
                                                      margin: EdgeInsets.only(top:10),
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              "https://wallpaperaccess.com/full/6790132.png"
                                                            )
                                                        ),
                                                        borderRadius: BorderRadius.circular(50)
                                                      ),
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Text("Nguyễn Văn Nhật")
                                                ],
                                              )
                                      
                                          ),
                                          Container(
                                              width: AppDimention.screenWidth - 100,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  border: Border(left: BorderSide(width: 1,color: Colors.black26))
                                              ),
                                              padding: EdgeInsets.only(left: 10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Bánh sandwich loại lớn lớn",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                                  Text("Tổng giá : \$100"),
                                                  Row(
                                                    children: [
                                                      Wrap(children: List.generate(5, (index) => Icon(Icons.star,color: AppColor.mainColor,size: AppDimention.size15)),),
                                                      Text("( 5 )",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: AppColor.mainColor),),
                                      
                                                    ],
                                                  ),
                                                  Text("Bình luận : ",style: TextStyle(fontWeight: FontWeight.bold),),
                                                  Container(
                                                    width:AppDimention.screenWidth-160 ,
                                                    height: 62,
                                                    child: Text("Bánh này dở nha mn , giá thì đắt lòi mà nhân thì không có cái vẹo gì , lần sau đách mua nữa ",overflow: TextOverflow.ellipsis,maxLines: 3,),
                                                  )
                                                ],
                                              ),

                                          )
                                        ],
                                      ),
                                    );
                                }
                          ),
                    )

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
                        if (quantity > 1) quantity--;
                      });
                    },
                    child: Icon(Icons.remove),
                  ),
                  Text(quantity.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (quantity < 20) quantity++;
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
                      borderRadius: BorderRadius.circular(AppDimention.size20),
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
                      borderRadius: BorderRadius.circular(AppDimention.size20),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [Text("Mua ngay")],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showDropdown(
                      (product.stores as List<StoreModel>)
                          .map<String>((store) => store.storeName ?? '')
                          .toList(),
                      (selectedStoreName) {
                        setState(() {
                          idstore = (product.stores as List<StoreModel>)
                              .firstWhere((store) => store.storeName == selectedStoreName)
                              .storeId!;
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
