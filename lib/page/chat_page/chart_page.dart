import 'package:android_project/data/controller/Chart_controller.dart';
import 'package:android_project/page/chat_page/chart_header.dart';
import 'package:android_project/page/profile_page/profile_footer.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  TextEditingController sendController = TextEditingController();
   File? _image; 
   bool trans = false;
   FocusNode focusNode = FocusNode();

  
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); 
      });
    }
  }
    @override
  void initState() {
    super.initState();
    
    focusNode.addListener(() {
      setState(() {
        trans = !focusNode.hasFocus;
      });
    });
  }
  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartController>(builder: (chartController) {
      bool status = chartController.isShow;
      return Scaffold(
        resizeToAvoidBottomInset: trans,
        body: Column(
          children: [
            ChartHeader(),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    width: AppDimention.screenWidth,
                    height: AppDimention.screenHeight - 130,
                    child:GestureDetector(
                      onTap: (){
                          if(status){
                            chartController.ChangeShow();
                          }
                      },
                      child:  Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: AppDimention.size10),
                                  Align(
                                    alignment: Alignment.centerLeft, 
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      margin: EdgeInsets.only(left: AppDimention.size10), 
                                      decoration: BoxDecoration(
                                        color: Colors.blue[400],
                                        borderRadius: BorderRadius.circular(AppDimention.size10),
                                      ),
                                      child: Text("Chào bạn "),
                                    ),
                                  ),
                                  SizedBox(height: AppDimention.size20),
                                  Align(
                                    alignment: Alignment.centerRight, 
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      margin: EdgeInsets.only(right: AppDimention.size10), 
                                      decoration: BoxDecoration(
                                        color: Colors.blue[400],
                                        borderRadius: BorderRadius.circular(AppDimention.size10),
                                      ),
                                      child: Text("Chào bạn "),
                                    ),
                                  ),
                                  SizedBox(height: AppDimention.size10),
                                ],
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    )
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    top: 0,
                    left: status ? 0 : -MediaQuery.of(context).size.width,
                    child: Container(
                      width: AppDimention.size100 * 3,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: AppColor.mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: AppDimention.size100 * 3,
                              height: AppDimention.size60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(right: BorderSide(width: 1, color: Colors.black26),bottom: BorderSide(width: 1, color: Colors.black26)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                    GestureDetector(
                                      onTap: (){
                                        Get.toNamed(AppRoute.HOME_PAGE);
                                      },
                                      child: Icon(Icons.home,size: AppDimention.size30,color: Colors.black45,),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Get.toNamed(AppRoute.SEARCH_PAGE);
                                      },
                                      child: Icon(Icons.search,size: AppDimention.size30,color: Colors.black45,),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Get.toNamed(AppRoute.ORDER_PAGE);
                                      },
                                      child: Icon(Icons.delivery_dining,size: AppDimention.size30,color: Colors.black45,),
                                    ),
                                    GestureDetector(
                                      onTap: (){

                                      },
                                      child: Icon(Icons.favorite,size: AppDimention.size30,color: Colors.black45,),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Get.toNamed(AppRoute.PROFILE_PAGE);
                                      },
                                      child: Icon(Icons.person,size: AppDimention.size30,color: Colors.black45,),
                                    ),
                                ],
                              )
                            ),
                            Container(
                              width: AppDimention.size100 * 3,
                              height: AppDimention.size60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(right: BorderSide(width: 1, color: Colors.black26)),
                              ),
                              child: TextField(
                                controller: searchController,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  hintText: "Search ...",
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: AppColor.yellowColor,
                                  ),
                                  
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.0, color: Colors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.0, color: Colors.transparent),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            Container(
                              width: AppDimention.size100 * 2.9,
                              height: AppDimention.size60,
                              margin: EdgeInsets.only(top: AppDimention.size10),
                              padding: EdgeInsets.only(left: AppDimention.size10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(AppDimention.size100),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: AppDimention.size40,
                                    height: AppDimention.size40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(AppDimention.size100),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("https://wallpaperaccess.com/full/6790132.png"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: AppDimention.size10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: AppDimention.size5),
                                      Text("Nguyễn Văn Nhật", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                      Container(
                                        width: AppDimention.size100 * 1.8,
                                        child: Text(
                                          "Cảm ơn shop nhiều hi hi hiahsdlkash",
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
             _image != null
              ? Container(
                  width: 300,
                  height: 200,
                  padding: EdgeInsets.only(left: AppDimention.size20,right: AppDimention.size20,top: AppDimention.size10),
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(AppDimention.size40),topRight: Radius.circular(AppDimention.size40))
                  ),
                  child: Column(
                   
                    children: [
                      GestureDetector(
                        onTap: (){
                            setState(() {
                              _image = null;
                            });
                        },
                        child: Icon(
                          Icons.remove_circle,
                          color: Colors.white,
                          size: AppDimention.size40,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12), 
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover, 
                          width: 300,
                          height: 150,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),

            Container(
                width: AppDimention.screenWidth,
                height: AppDimention.size70,
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _pickImage(); 
                      },
                      child: Container(
                        width: AppDimention.size70,
                        height: AppDimention.size70,
                        child: Center(
                          child: Icon(
                            Icons.pix_rounded,
                            color: Colors.white,
                            size: AppDimention.size40,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: AppDimention.size50,
                        margin: EdgeInsets.symmetric(horizontal: AppDimention.size10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppDimention.size10),
                        ),
                        child: TextField(
                          controller: sendController,
                          decoration: InputDecoration(
                            hintText: "Chart ...",
                            hintStyle: TextStyle(color: Colors.black12),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0, color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0, color: Colors.transparent),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: Container(
                        width: AppDimention.size70,
                        height: AppDimention.size70,
                        child: Center(
                          child: Transform.rotate(
                            angle: 0 * 3.1415927 / 180,
                            child: Icon(
                              IconData(0xe571, fontFamily: 'MaterialIcons', matchTextDirection: true),
                              color: Colors.white,
                              size: AppDimention.size40,
                            ),
                          ),
                        ),
                      ),
                    ),
                 
                  ],
                ),
              )
  
    
          ],
        ),
      );
    });
  }
}
