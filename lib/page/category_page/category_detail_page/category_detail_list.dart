
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetailList extends StatefulWidget {
  final categoryid;
  const CategoryDetailList({
    Key? key,
    required this.categoryid
  }) : super(key: key);

  @override
  _CategoryDetailListState createState() => _CategoryDetailListState();
}

class _CategoryDetailListState extends State<CategoryDetailList> {
  late ProductController productController;
  @override
  void initState() {
    super.initState();
    productController = Get.find();
    productController.getProductByCategoryId(widget.categoryid);
  }


  @override
  Widget build(BuildContext context) {
        return  GetBuilder<ProductController>(builder: (productController){
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: productController.productListBycategory.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  width: 370,
                  height: 150,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: GestureDetector(
                    onTap: (){
                        Get.toNamed(AppRoute.get_product_detail(productController.productListBycategory[index].productId));
                    },
                    child: Row(
                              children: [
                                Container(
                                    width: 150  ,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      
                                      color: Colors.white,
                                      image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "https://wallpaperaccess.com/full/6790132.png"
                                        )
                                      ),
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10))
                                    ),
                                  ),
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: AppDimention.size10),
                                      height: AppDimention.listViewImageSize,
                                     
                                      child: Padding(
                                        padding: EdgeInsets.only(left: AppDimention.size10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                              Container(
                                                child: Text(productController.productListBycategory[index].productName,style: TextStyle(
                                                    fontSize: AppDimention.size15,
                                                    fontWeight: FontWeight.w500
                                                ),
                                                maxLines: 1,overflow: TextOverflow.ellipsis,),
                                              ),
                                              SizedBox(height: AppDimention.size5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text("4.5"),
                                                        Icon(Icons.star,color: Colors.yellow,),
                                                        
                                                      ],
                                                    ),
                                                    SizedBox(width: AppDimention.size30,),
                                                     Row(
                                                      children: [
                                                        Text("2.7 km"),
                                                        Icon(Icons.location_on,color: Colors.blue,),
                                                       
                                                      ],
                                                    )
                                                  ],
                                              ),
                                              SizedBox(height: AppDimention.size5,),
                                              Row(
                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                 Text(
                                                    productController.productListBycategory[index].price.toString(),
                                                    style: TextStyle(
                                                      fontSize: AppDimention.size10,
                                                      decoration: TextDecoration.lineThrough,color: Colors.red, 
                                                    ),
                                                  ),
                                                  SizedBox(width: AppDimention.size20,),
                                                  Text(productController.productListBycategory[index].discountedPrice.toString())
                                                ],
                                              ),
                                              SizedBox(height: AppDimention.size5,),
                                              Container(
                                                width: 120,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: AppColor.mainColor,
                                                  borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Center(
                                                  child: Text("Mua ngay",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                                                ),
                                              )
                                              

                                          ],
                                        ),
                                      ),
                                    ),
                                ),
                              ],
                            ),
                  )
                  
                ),
              );

            },
          );
        });
         
       
  }
}
