import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({
    Key? key,
  }) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  @override
    void initState() {
    super.initState();
    Get.find<ProductController>().search();
  }
  @override
  Widget build(BuildContext context) {
    List<String> listrecommend = ["Gà chiên tỏi", "Hambeger salad", "Trà sữa trân châu"];
    return GetBuilder<ProductController>(builder: (productController) {
        return Column(
          children: [
            Container(
              width: AppDimention.screenWidth,
              padding: EdgeInsets.only(top: AppDimention.size10,bottom: AppDimention.size10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: listrecommend.map((item) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:GestureDetector(
                      onTap: (){
                        productController.updateTextSearch(item);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item,
                            style: TextStyle(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Icon(Icons.clear,size: 13,),
                          )
                        ],
                      ),
                    )
                  );
                }).toList(),
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
                itemCount: productController.productListSearch.length,  
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                       
                    },
                    child: Container(
                      width: 150, 
                      height: 150,  
                      margin: index % 2 == 0 ? EdgeInsets.only(left: AppDimention.size10):EdgeInsets.only(right: AppDimention.size10),
                      decoration: BoxDecoration(
                        color: AppColor.mainColor,
                        border: Border.all(width: 1, color: Color.fromRGBO(0, 0, 0, 0.5)),
                        borderRadius: BorderRadius.circular(AppDimention.size10),
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://wallpaperaccess.com/full/6790132.png"
                          )
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Container(
                            width: AppDimention.size150 + AppDimention.size30,
                            height: AppDimention.size50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(AppDimention.size10),bottomRight: Radius.circular(AppDimention.size10)),
                              color: AppColor.mainColor
                            ),
                            child: Center(
                              child: Text("hola"),
                            )
                          )

                        ],
                      ),
                      
                    ),
                  );
                },
              )
          ],
        );
    });
  }
}
