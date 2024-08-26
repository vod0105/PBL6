import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
class HomeCategory extends StatefulWidget{
   const HomeCategory({
       Key? key,
   }): super(key:key);
   @override
   _HomeCategoryState createState() => _HomeCategoryState();
}
class _HomeCategoryState extends State<HomeCategory>{
  PageController pageController = PageController(viewportFraction: 0.95);
  double currentPageValue = 0.0;
  
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        if (pageController.page != null) {
          currentPageValue = pageController.page!;
        }
      });
    });
  }

   @override
   Widget build(BuildContext context) {
    return Container(

      height: 130,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildView(position);
              },
            ),
          ),
        ],
      ),
    );
   }
   Widget _buildView(int index){
    return Container(
      margin: EdgeInsets.only(left: AppDimention.size5,right: AppDimention.size5),
      decoration: BoxDecoration(
        color: AppColor.mainColor,
        borderRadius: BorderRadius.all(Radius.circular(AppDimention.size10))
      ),
      child:Stack(
            children: [
              Positioned(
                top:0,
                right: 0,
                child:  Container(
                  height: 130,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Text("Mons awn")
                    ],
                  ),
                )
              ),
              Positioned(
                top:0,
                left: 0,
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(AppDimention.size10)),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://wallpaperaccess.com/full/6790132.png"),
                    ),
                  ),
                ),
              ),
            
           
            ],
          )
    );
   }
}