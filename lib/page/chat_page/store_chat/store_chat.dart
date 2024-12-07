
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';
import 'package:android_project/page/chat_page/home_chart/home_chat_header.dart';
import 'package:android_project/page/chat_page/store_chat/store_chat_body.dart';
import 'package:android_project/page/profile_page/profile_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreChat extends StatefulWidget {
  const StoreChat({
    super.key,
  });
  @override
  StoreChatState createState() => StoreChatState();
}

class StoreChatState extends State<StoreChat> {

  Storecontroller storecontroller = Get.find<Storecontroller>();
  List<StoresItem> listStore  = [];

  
  @override
  void initState() {
    super.initState();
    listStore = storecontroller.storeList;
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  Color(0xFFF4F4F4),
      body: Column(
        children: [
          HomeChatHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: StoreChatBody()
          )),
        ProfileFooter()
        ],
      ),
    );
  }
}
