
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreList extends StatefulWidget {
  const StoreList({
    Key? key,
  }) : super(key: key);

  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  @override
  Widget build(BuildContext context) {
    // return GetBuilder<Storecontroller>(builder: (storecontroller){
        return  ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  width: 370,
                  height: 200,
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                            child: Icon(Icons.location_on,color: AppColor.mainColor,),
                          )
                        ],
                      ),
                      Container(
                        width: 324,
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10,),
                            Text("JBVN001-COOPMART, XA LỘ HÀ NỘI",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: AppColor.yellowColor,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Icon(Icons.home,size: 12,),
                                  )
                                ),
                                SizedBox(width: 5,),
                                Container(
                                  width: 295,
                                  child: Text('CoopMart Xạ Lộ Hà Nội , 191 Quang Trung, phường Hiệp Phú, Quận 9 , TPHCM'),
                                )
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: AppColor.yellowColor,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Icon(Icons.phone,size: 12,),
                                  )
                                ),
                                SizedBox(width: 5,),
                                Container(
                                  width: 295,
                                  child: Text('(028) 3730-7554 / (028) 6282-7000'),
                                )
                              ],
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: AppColor.yellowColor,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Icon(Icons.timelapse_rounded,size: 12,),
                                  )
                                ),
                                SizedBox(width: 8,),
                                Container(
                                  width: 295,
                                  child: Text('8:00 AM - 9:00 PM'),
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                           Container(
                              width: AppDimention.screenWidth,
                              child: Center(
                                child: Container(
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColor.mainColor,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Text("Xem bản đồ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                           )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );

            },
          );
  //  } 
  //  );
         
       
  }
}
