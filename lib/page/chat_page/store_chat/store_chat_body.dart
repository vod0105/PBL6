import 'package:android_project/data/controller/Chart_controller.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreChatBody extends StatefulWidget {
  const StoreChatBody({
    super.key,
  });
  @override
  StoreChatBodyState createState() => StoreChatBodyState();
}

class StoreChatBodyState extends State<StoreChatBody> {
  Storecontroller storecontroller = Get.find<Storecontroller>();
  List<StoresItem> listStore = [];
  bool loaded = false;
  @override
  void initState() {
    super.initState();
    loadData();
    
  }
  void loadData(){
    setState(() {
      listStore =  storecontroller.storeList;
      loaded = true;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartController>(
      builder: (listUserController) {
        return !loaded
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: listStore.map((item) {
                  return GestureDetector(
                    onTap: ()  {
                      Get.toNamed(AppRoute.store_chat_detail(item.storeId!));
                    },
                    child: Container(
                      width: AppDimention.screenWidth,
                      height: AppDimention.size80,
                      padding: EdgeInsets.only(left: AppDimention.size10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: AppDimention.size60,
                            height: AppDimention.size60,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size100),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "assets/image/LoadingBg.png"))),
                          ),
                          SizedBox(width: AppDimention.size10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.circle,color: Colors.green,size: 18,),
                                  SizedBox(width: AppDimention.size5,),
                                  SizedBox(
                                    width: AppDimention.screenWidth * 0.7,
                                    child: Text(
                                    item.storeName.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  )
                                ],
                              ),
                             
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
      },
    );
  }
}
