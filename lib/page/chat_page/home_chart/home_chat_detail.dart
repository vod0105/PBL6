// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/data/controller/Chart_controller.dart';
import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/models/Model/MessageModel.dart';
import 'package:android_project/models/Model/UserModel.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/io.dart';

class HomeChatDetail extends StatefulWidget {
  final int idReceiver;
  const HomeChatDetail({
    required this.idReceiver,
    super.key,
  });
  @override
  _HomeChatDetailState createState() => _HomeChatDetailState();
}

class _HomeChatDetailState extends State<HomeChatDetail> {
  List<UserMessage> listChart = [];
  late ChartController chatController = Get.find<ChartController>();
  TextEditingController sendController = TextEditingController();
  late UserController userController = Get.find<UserController>();
  ScrollController scrollController = ScrollController();
  FocusNode focusNode = FocusNode();

  User? user2;
  User? user1;
  bool loaded = false;
  File? image;
  String imageBase64 = "";

  late IOWebSocketChannel _channel;
  StreamSubscription? _subscription;

  bool isPicking = false;
  bool haveImage = false;
  @override
  void initState() {
    super.initState();
    loadData(widget.idReceiver);

    HttpClient client = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    _channel = IOWebSocketChannel.connect(
      Uri.parse('ws://${Appconstant.IP}:${Appconstant.PORT}/ws/chat'),
      customClient: client,
    );
    startSessionSocket();

    _subscription = _channel.stream.listen((message) {
      setState(() {
        var decodedMessage = jsonDecode(message);
        //if(decodedMessage["type"] =="sendMessage")
        listChart.add(UserMessage.fromJson(decodedMessage));
      });

      _scrollToBottom();
    });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _scrollToBottom();
      }
    });
  }

  void startSessionSocket() {
    final data = {
      "type": "identify",
      "userId": user1!.id,
    };
    _channel.sink.add(jsonEncode(data));
  }

  Future<void> loadData(int idReceiver) async {
    setState(() {
      loaded = false;
      listChart.clear();
    });

    user1 = userController.userProfile;
    await chatController.getListMessage(idReceiver);
    user2 = await userController.getById(idReceiver);
    while (chatController.isLoadingMessage || userController.loadReceiver!) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    setState(() {
      listChart = chatController.listUserMessage;
      loaded = true;
    });
    _scrollToBottom();
  }

  Future<void> _pickImage() async {
    if (isPicking) return;
    setState(() {
      isPicking = true;
    });
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        List<int> imageBytes = await imageFile.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        setState(() {
          image = imageFile;
          imageBase64 = base64Image;
          haveImage = true;
        });
      }
    } finally {
      setState(() {
        isPicking = false;
      });
    }
  }

  void _sendMessage() {
    String message = sendController.text.trim();
    if (imageBase64.isEmpty == false) {
      final data = {
        "sender": user1!.id,
        "receiver": user2!.id,
        "message": "",
        "localTime": "",
        "image": "",
        "type": "sendImage"
      };
      chatController.senImage(user1!.id!, user2!.id!, imageBase64);

      UserMessage userMessage = UserMessage(
          image: imageBase64,
          localTime: "",
          message: "",
          receiver: user2!.id,
          sender: user1!.id);
      listChart.add(userMessage);
      imageBase64 = "";

      _channel.sink.add(jsonEncode(data));
    } else {
      final data = {
        "sender": user1!.id,
        "receiver": user2!.id,
        "message": message,
        "localTime": "",
        "image": "",
        "type": "sendMessage"
      };
      _channel.sink.add(jsonEncode(data));
    }

    sendController.clear();
    userController.addAnnoUceV2(
        user2!.id!, "Thông báo", "Bạn vừa có tin nhắn từ ${user1!.fullName!}");

    setState(() {
      haveImage = false;
    });
    _scrollToBottom();
  }

  Future<void> updateData(int idReceiver) async {
    await loadData(idReceiver);
    setState(() {
      image = null;
      imageBase64 = "";
    });
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _subscription?.cancel(); // Hủy bỏ listener khi dispose
    _channel.sink.close();
    focusNode.dispose();
    sendController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF4F4F4),
      body: Column(
        children: [
          // header
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
                    ? Text(
                        user2!.fullName!,
                        style: TextStyle(
                            color: Colors.white, fontSize: AppDimention.size20),
                      )
                    : const CircularProgressIndicator()
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
                controller: scrollController,
                child: !loaded
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        padding: EdgeInsets.only(bottom: AppDimention.size40),
                        child: Column(
                          children: listChart
                              .map((item) => Align(
                                  alignment: item.sender == user2!.id
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: Column(
                                    children: [
                                      if (item.image != null &&
                                          item.image!.isNotEmpty)
                                        Container(
                                          width: AppDimention.size100 * 2,
                                          height: AppDimention.size100 * 2,
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              bottom: 10,
                                              top: 10),
                                          margin: const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: item.sender == user2!.id
                                                ? const Color.fromARGB(
                                                    66, 48, 40, 15)
                                                : AppColor.mainColor,
                                            borderRadius: BorderRadius.circular(
                                                AppDimention.size10),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: MemoryImage(
                                                  base64Decode(item.image!)),
                                            ),
                                          ),
                                        )
                                      else
                                        Container(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              bottom: 10,
                                              top: 10),
                                          margin: const EdgeInsets.only(top: 10),
                                          decoration: BoxDecoration(
                                            color: item.sender == user2!.id
                                                ? const Color.fromARGB(
                                                    66, 48, 40, 15)
                                                : AppColor.mainColor,
                                            borderRadius: BorderRadius.circular(
                                                AppDimention.size40),
                                          ),
                                          child: Text(
                                            item.message.toString(),
                                            style:
                                                const TextStyle(color: Colors.white),
                                          ),
                                        ),
                                    ],
                                  )))
                              .toList(),
                        ),
                      )),
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
                  if (haveImage)
                    Container(
                        width: AppDimention.screenWidth,
                        height: AppDimention.size100 * 3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(base64Decode(imageBase64)))),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  image = null;
                                  imageBase64 = "";
                                  haveImage = false;
                                });
                              },
                              child: Container(
                                width: AppDimention.size30,
                                height: AppDimention.size30,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            AppDimention.size10),
                                        bottomRight: Radius.circular(
                                            AppDimention.size10))),
                                child: const Center(
                                  child: Icon(Icons.remove_circle_outline),
                                ),
                              ),
                            )
                          ],
                        )),
                  Row(
                    children: [
                      SizedBox(
                        width: AppDimention.size10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _pickImage();
                        },
                        child: const Icon(Icons.image, color: Colors.amber),
                      ),
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
                          _sendMessage();
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
