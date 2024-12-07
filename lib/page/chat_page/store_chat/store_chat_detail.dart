import 'dart:convert';

import 'package:android_project/data/controller/Chart_controller.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';
import 'package:android_project/page/chat_page/store_chat/AutoChat.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StoreChatDetail extends StatefulWidget {
  final int storeId;
  const StoreChatDetail({
    required this.storeId,
    super.key,
  });

  @override
  StoreChatDetailState createState() => StoreChatDetailState();
}

class StoreChatDetailState extends State<StoreChatDetail> {
  int indexChat = 0;
  List<List<String>> listQuestion = [];
  List<Widget> listWidgets = [];
  late Quiz quiz;
  Storecontroller storecontroller = Get.find<Storecontroller>();
  ChartController chatController = Get.find<ChartController>();
  StoresItem? storesItem;
  TextEditingController sendController = TextEditingController();
  bool loaded = false;
  FocusNode focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  List<String> listChat = [];

  @override
  void initState() {
    super.initState();
    loadQuestion();
    quiz = Quiz(storeId: widget.storeId);
    loadingData();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _scrollToBottom();
      }
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void loadingData() async {
    storecontroller.getById(widget.storeId);
    while (storecontroller.isLoadingItem) {
      await Future.delayed(const Duration(microseconds: 100));
    }
    storesItem = storecontroller.storeItem;
    setState(() {
      loaded = true;
    });
  }

  String formatTime(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return DateFormat('hh:mm').format(dateTime);
  }

  void loadQuestion() {
    listQuestion.addAll([
      [
        "Tôi muốn xem danh mục sản phẩm của cửa hàng bạn .",
        "Tôi muốn xem danh sách sản phẩm của cửa hàng .",
        "Tôi muốn xem danh sách các combo đang có .",
        // "Hãy hiển thị bản đồ đến cửa hàng của bạn .",
        // "Thời gian mà cửa hàng hoạt động trong ngày .",
        // "Xem chi tiết cửa hàng ."
      ],
    ]);
  }

  Widget newWidget(String answers) {
    for (Question item in quiz.questions) {
      if (item.selection.contains(answers)) {
        return FutureBuilder<Widget>(
          future: item.answers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return snapshot.data ?? Container();
            }
          },
        );
      }
    }
    return Container();
  }

  void storeResponse() async {
    if (sendController.text.isEmpty == false) {
      listChat.add(sendController.text);
      listChat.add((await chatController.autoResponse(
          sendController.text, widget.storeId))!);
    }
    sendController.text = "";
    _scrollToBottom();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> combinedList = [];
    for (int i = 0; i <= indexChat; i++) {
      combinedList.add(Align(
        alignment: Alignment.centerRight,
        child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
            margin: const EdgeInsets.only(top: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimention.size10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppDimention.screenWidth * 2 / 3,
                  margin: EdgeInsets.only(bottom: AppDimention.size10),
                  child: const Text(
                      "Chào bạn , chúng tôi có thể giúp gì cho bạn không ?"),
                ),
                Column(
                  children: List.generate(
                    listQuestion[0].length,
                    (j) => GestureDetector(
                      onTap: () {
                        setState(() {
                          indexChat = indexChat + 1;
                          listWidgets.add(newWidget(listQuestion[0][j]));
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(AppDimention.size10),
                        margin: EdgeInsets.only(bottom: AppDimention.size10),
                        width: AppDimention.screenWidth * 2 / 3,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 244, 250, 255),
                          borderRadius:
                              BorderRadius.circular(AppDimention.size5),
                        ),
                        child: Text(
                          listQuestion[0][j],
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ));

      if (i < listWidgets.length) {
        combinedList.add(listWidgets[i]);
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF4F4F4),
      body: Column(
        children: [
          Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size100,
            padding: EdgeInsets.only(
                left: AppDimention.size10, right: AppDimention.size10),
            decoration: const BoxDecoration(color: AppColor.mainColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                loaded
                    ? GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.user_chat_detail(
                              storesItem!.managerId!));
                        },
                        child: Container(
                          width: AppDimention.size100 * 2,
                          height: AppDimention.size60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size10)),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${storesItem!.storeName}",maxLines: 1,),
                                const Text("Liên hệ chủ cửa hàng"),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(bottom: AppDimention.size40),
                  child: Column(
                    children: [
                      loaded
                          ? Column(
                              children: [
                                Container(
                                  width: AppDimention.screenWidth,
                                  margin: EdgeInsets.only(
                                      top: AppDimention.size10,
                                      left: AppDimention.size10,
                                      right: AppDimention.size10),
                                  height: AppDimention.size100 * 2.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              AppDimention.size10),
                                          topRight: Radius.circular(
                                              AppDimention.size10)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(base64Decode(
                                              storesItem!.image!)))),
                                ),
                                Container(
                                  width: AppDimention.screenWidth,
                                  margin: EdgeInsets.only(
                                      bottom: AppDimention.size10,
                                      left: AppDimention.size10,
                                      right: AppDimention.size10),
                                  padding: EdgeInsets.all(AppDimention.size10),
                                 
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                              AppDimention.size10),
                                          bottomRight: Radius.circular(
                                              AppDimention.size10)),
                                      border: const Border(
                                          bottom: BorderSide(
                                              width: 1, color: Colors.black12),
                                          left: BorderSide(
                                              width: 1, color: Colors.black12),
                                          right: BorderSide(
                                              width: 1,
                                              color: Colors.black12))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Cửa hàng : ${storesItem!.storeName}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: AppDimention.size10,
                                      ),
                                      Text("Địa chỉ : ${storesItem!.location}"),
                                      SizedBox(
                                        height: AppDimention.size10,
                                      ),
                                      Text(
                                          "Số điện thoại : ${storesItem!.numberPhone}"),
                                      SizedBox(
                                        height: AppDimention.size10,
                                      ),
                                      Text(
                                          "Thời gian hoạt động : ${"${formatTime(storesItem!.openingTime!)} - ${formatTime(storesItem!.closingTime!)}"}"),
                                      SizedBox(
                                        height: AppDimention.size10,
                                      ),
                                      Center(
                                          child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoute.get_store_detail(
                                              storesItem!.storeId!));
                                        },
                                        child: Container(
                                          width: AppDimention.size120,
                                          height: AppDimention.size40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppDimention.size10),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColor.yellowColor)),
                                          child: const Center(
                                            child: Text(
                                              "Chi tiết",
                                              style: TextStyle(
                                                  color: AppColor.mainColor),
                                            ),
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                )
                              ],
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            ),
                      Column(children: [
                        Column(children: combinedList),
                        Column(
                          children: listChat.asMap().entries.map((entry) {
                            int index = entry.key;
                            String item = entry.value;

                            return Container(
                              width: Get.width * 0.9,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color:
                                    index % 2 == 0 ? Colors.red : Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                item,
                                style: TextStyle(
                                    color: index % 2 == 0
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            );
                          }).toList(),
                        ),
                      ]),
                    ],
                  )),
            ),
          ),
          Container(
              width: AppDimention.screenWidth,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              padding: EdgeInsets.only(
                  bottom: AppDimention.size10, top: AppDimention.size10),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: AppDimention.size10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.circular(AppDimention.size5),
                          ),
                          padding: EdgeInsets.only(
                              left: AppDimention.size10,
                              right: AppDimention.size10),
                          child: TextField(
                            controller: sendController,
                            focusNode: focusNode,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Chart ...",
                              hintStyle: const TextStyle(color: Colors.black12),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.transparent),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.0, color: Colors.transparent),
                              ),
                              border: const OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: AppDimention.size10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: AppDimention.size10,
                      ),
                      GestureDetector(
                        onTap: () {
                          storeResponse();
                        },
                        child: const Icon(Icons.send, color: Colors.amber),
                      ),
                      SizedBox(
                        width: AppDimention.size10,
                      ),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
