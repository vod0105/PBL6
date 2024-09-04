import 'package:android_project/custom/icon_text_custom.dart';


import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';

class ProfileControll extends StatefulWidget {
  const ProfileControll({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileControllState createState() => _ProfileControllState();
}

class _ProfileControllState extends State<ProfileControll> {
  PageController pageController = PageController(viewportFraction: 0.96);
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
      width: AppDimention.screenWidth,
      height: 800,
      padding: EdgeInsets.all(AppDimention.size10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size40+AppDimention.size30,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Color.fromRGBO(0, 0, 0, 0.1), 
                ),
                
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: AppDimention.size40,
                  height: AppDimention.size40,
                  decoration: BoxDecoration(
                    color: AppColor.yellowColor,
                    borderRadius: BorderRadius.circular(AppDimention.size40)
                  ),
                  child: Icon(Icons.create,color: Colors.white,),
                ),
                SizedBox(width: AppDimention.size10,),
                Text("9.9 Ngày siêu mua sắm",style: TextStyle(fontSize: 16),),
                SizedBox(width: AppDimention.size5,),
                Icon(Icons.new_releases_outlined,color: Colors.red[300],)
              ],
            ),
          ),
          Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size30*4.5,
            padding: EdgeInsets.only(top: AppDimention.size20 + AppDimention.size15),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Color.fromRGBO(0, 0, 0, 0.1), 
                ),
               
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconTextCustom(iconData: Icons.abc, text: "Trang chính",color: AppColor.mainColor,colorIcon: Colors.white,width: AppDimention.size50,height: AppDimention.size50),
                IconTextCustom(iconData: Icons.abc, text: "Trang chính",color: AppColor.mainColor,colorIcon: Colors.white,width: AppDimention.size50,height: AppDimention.size50),
                IconTextCustom(iconData: Icons.abc, text: "Trang chính",color: AppColor.mainColor,colorIcon: Colors.white,width: AppDimention.size50,height: AppDimention.size50),
                IconTextCustom(iconData: Icons.abc, text: "Trang chính",color: AppColor.mainColor,colorIcon: Colors.white,width: AppDimention.size50,height: AppDimention.size50),
              ],
            ),
           ),
          Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size40+AppDimention.size30,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Color.fromRGBO(0, 0, 0, 0.1), 
                ),
                
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [ 
                    Icon(Icons.list_alt_rounded,size: AppDimention.size30,color: Colors.blue[400],),
                    SizedBox(width: AppDimention.size10,),
                    Text("Đơn mua"),],
                ),
                Row(
                  children: [
                    Text("Xem lịch sử mua hàng"),
                    Icon(Icons.arrow_forward_ios_outlined,size: 15,)
                  ],
                )
                
              ],
            ),
          ),
          Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size60+AppDimention.size60,
            padding: EdgeInsets.only(top:AppDimention.size30),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Color.fromRGBO(0, 0, 0, 0.1), 
                ),
                
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.card_travel_outlined,size: 40,),
                      Text("Chờ xác nhận",style: TextStyle(fontSize: 12),)
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.present_to_all,size: 40,),
                      Text("Chờ lấy hàng",style: TextStyle(fontSize: 12),)
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.delivery_dining_outlined,size: 40,),
                      Text("Chờ giao hàng",style: TextStyle(fontSize: 12),)
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.star_border_purple500_sharp,size: 40,),
                      Text("Đánh giá",style: TextStyle(fontSize: 12),)
                    ],
                  ),
                  
                ],
            ),
          ),
          Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size110*3,
            padding: EdgeInsets.only(top: AppDimention.size20),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Color.fromRGBO(0, 0, 0, 0.1), 
                ),
              ),
            ),
            child: Column(
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [ 
                          Icon(Icons.list_alt_rounded,size: AppDimention.size30,color: Colors.green[400],),
                          SizedBox(width: AppDimention.size10,),
                          Text("Mua lại"),],
                      ),
                      Row(
                        children: [
                          Text("Xem thêm sản phẩm"),
                          Icon(Icons.arrow_forward_ios_outlined,size: 15,)
                        ],
                      )
                      
                    ],
                  ),
                  SizedBox(height: AppDimention.size20,),
                  Container(
                    height: 130,
                    
                    child: Row(
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
                        Container(
                          width: 40,
                          height: 130,
                          
                          child: Icon(Icons.arrow_circle_right_outlined,size: AppDimention.size40,color: AppColor.yellowColor,),
                        )
                      ],
                    ),
                  )
              ],
            )
          ),
        ],
      ),
    );
  }

  Widget _buildView(int index){
    return Container(
      margin: EdgeInsets.only(right: AppDimention.size10),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
      ),
      child:Container(
        child: Row(
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
    
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "https://wallpaperaccess.com/full/6790132.png"
                  )
                )
              ),
            ),
            SizedBox(width: AppDimention.size15,),
            Container(
              width: 160,
              height: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppDimention.size10,),
                  Text("Trà sữa trân châu",overflow: TextOverflow.ellipsis,maxLines: 1, ),
                  Text("54, Nguyễn Lương Bằng , Liên Chiểu , Đà Nẵng",overflow: TextOverflow.ellipsis,maxLines: 1, ),
                  Text("Đã mua 1 lần ", ),
                  SizedBox(height: AppDimention.size20,),
                  Text("Giá : 20.000 VNĐ ", ),
                ],
              ),
            )
          ],
        ),
      )
    );
   }
}
