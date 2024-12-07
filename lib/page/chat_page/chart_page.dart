import 'dart:convert';

import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/data/controller/Chart_controller.dart';
import 'package:android_project/models/Model/MessageModel.dart';
import 'package:android_project/page/chat_page/chart_header.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:io';


class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  ChartPageState createState() => ChartPageState();
}

class ChartPageState extends State<ChartPage>
    with SingleTickerProviderStateMixin {
  
  TextEditingController searchController = TextEditingController();
  TextEditingController sendController = TextEditingController();
  FocusNode focusNode = FocusNode();
  late IOWebSocketChannel _channel;
  List<UserMessage> listChart = [];
  bool trans = false;
  File? _image;
  String imageBase64 = "";
  int idMe = 0;
  int idYou = 0;

  ChartController chartController = Get.find<ChartController>();
  AuthController authController = Get.find<AuthController>();
  @override
  void initState() {
    super.initState();

    chartController.getAll();
    idMe = authController.idUser;
    HttpClient client = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    _channel = IOWebSocketChannel.connect(
      Uri.parse('ws://192.168.1.39:8080/ws/chat'),
      customClient: client,
    );
    startSessionSocket();

    _channel.stream.listen((message) {
      setState(() {
        var decodedMessage = jsonDecode(message);
        listChart.add(UserMessage.fromJson(decodedMessage));
      });
    });
    focusNode.addListener(() {
      setState(() {
        trans = !focusNode.hasFocus;
      });
    });
  }

  bool isPicking = false;
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
          _image = imageFile;
          imageBase64 = base64Image;
        });
      }
    } catch (e) {
      return;
    } finally {
      setState(() {
        isPicking = false;
      });
    }
  }

  void reconnect() {
    Future.delayed(const Duration(seconds: 5), () {
      HttpClient client = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      _channel = IOWebSocketChannel.connect(
        Uri.parse('ws://192.168.1.39:8080/ws/chat'),
        customClient: client,
      );
      startSessionSocket();
      _channel.stream.listen(
        (message) {
          setState(() {
            try {
              var decodedMessage = jsonDecode(message);
              setState(() {
                listChart.add(UserMessage.fromJson(decodedMessage));
              });
            } catch (e) {
              return;
            }
          });
        },
        onError: (error) {
        },
        onDone: () {
          reconnect();
        },
      );
    });
  }

  void startSessionSocket() {
    final data = {
      "type": "identify",
      "userId": idMe,
    };
    _channel.sink.add(jsonEncode(data));
  }

  void _sendMessage() {
    String message = sendController.text.trim();
    if (message.isNotEmpty) {
      final data = {
        "sender": idMe,
        "receiver": idYou,
        "message": message,
        "localTime": "",
        "image": "",
      };

      _channel.sink.add(jsonEncode(data));
      sendController.clear();
    }
    if (imageBase64.isNotEmpty) {
      chartController.senImage(idMe, idYou, imageBase64);
      updateData(idYou);
    }
  }

  Future<void> updateData(int idReceiver) async {
    listChart.clear();

    await chartController.getListMessage(idReceiver);

    while (chartController.isLoadingMessage == true) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    setState(() {
      listChart = chartController.listUserMessage;
    });
    setState(() {
      _image = null;
      imageBase64 = "";
    });
  }

  @override
  void dispose() {
    _channel.sink.close();
    focusNode.dispose();
    sendController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChartController>(builder: (chartController) {
      bool status = chartController.isShow;
      return Scaffold(
        // resizeToAvoidBottomInset: trans,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            const ChartHeader(),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      width: AppDimention.screenWidth,
                      height: AppDimention.screenHeight - 130,
                      child: GestureDetector(
                        onTap: () {
                          if (status) {
                            chartController.changeShow();
                          }
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: listChart.isEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: AppDimention.size10),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              margin: EdgeInsets.only(
                                                  left: AppDimention.size10),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[400],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimention.size10),
                                              ),
                                              child: const Text("Chào bạn "),
                                            ),
                                          ),
                                          SizedBox(height: AppDimention.size20),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              margin: EdgeInsets.only(
                                                  right: AppDimention.size10),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[400],
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimention.size10),
                                              ),
                                              child: const Text("Chào bạn "),
                                            ),
                                          ),
                                          SizedBox(height: AppDimention.size10),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: AppDimention.size10),
                                          ...listChart.map((item) {
                                            // DecorationImage? imageDecoration;
                                            // if (item.image != null) {
                                            //   imageDecoration = DecorationImage(
                                            //     fit: BoxFit.cover,
                                            //     image: MemoryImage(
                                            //         base64Decode(item.image!)),
                                            //   );
                                            // }

                                            return Align(
                                                    alignment: item.sender ==
                                                            idYou
                                                        ? Alignment.centerLeft
                                                        : Alignment.centerRight,
                                                    child: Container(
                                                      padding: const EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          bottom: 10,
                                                          top: 10),
                                                      margin: const EdgeInsets.only(
                                                          top: 10),
                                                      decoration: BoxDecoration(
                                                          color: item.sender ==
                                                                  idYou
                                                              ? const Color
                                                                  .fromARGB(66,
                                                                  48, 40, 15)
                                                              : AppColor
                                                                  .mainColor,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  AppDimention
                                                                      .size40),
                                                         ),
                                                      child: Text(
                                                        item.message.toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  );
                                                
                                          }),
                                          SizedBox(height: AppDimention.size20),
                                        ],
                                      ),
                              ),
                            )
                          ],
                        ),
                      )),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    top: 0,
                    left: status ? 0 : -MediaQuery.of(context).size.width,
                    child: Container(
                      width: AppDimention.size100 * 3,
                      height: MediaQuery.of(context).size.height,
                      decoration: const BoxDecoration(
                        color: AppColor.mainColor,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                                width: AppDimention.size100 * 3,
                                height: AppDimention.size60,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      right: BorderSide(
                                          width: 1, color: Colors.black26),
                                      bottom: BorderSide(
                                          width: 1, color: Colors.black26)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoute.HOME_PAGE);
                                      },
                                      child: Icon(
                                        Icons.home,
                                        size: AppDimention.size30,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoute.SEARCH_PAGE);
                                      },
                                      child: Icon(
                                        Icons.search,
                                        size: AppDimention.size30,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoute.ORDER_PAGE);
                                      },
                                      child: Icon(
                                        Icons.delivery_dining,
                                        size: AppDimention.size30,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.favorite,
                                        size: AppDimention.size30,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(AppRoute.PROFILE_PAGE);
                                      },
                                      child: Icon(
                                        Icons.person,
                                        size: AppDimention.size30,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                              width: AppDimention.size100 * 3,
                              height: AppDimention.size60,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    right: BorderSide(
                                        width: 1, color: Colors.black26)),
                              ),
                              child: TextField(
                                controller: searchController,
                                focusNode: focusNode,
                                decoration: const InputDecoration(
                                  hintText: "Search ...",
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: AppColor.yellowColor,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0, color: Colors.transparent),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.0, color: Colors.transparent),
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            GetBuilder<ChartController>(
                              builder: (listUserController) {
                                return Column(
                                  children:
                                      listUserController.listUser.map((item) {
                                    return GestureDetector(
                                      onTap: () async {
                                        await listUserController
                                            .getListMessage(item.id!);
                                        listChart = listUserController
                                            .listUserMessage;
                                        listUserController
                                            .updateChartName(item.fullName!);

                                        idYou = Get.find<ChartController>()
                                            .idReceiver;
                                      },
                                      child: Container(
                                        width: AppDimention.size100 * 2.9,
                                        height: AppDimention.size60,
                                        margin: EdgeInsets.only(
                                            top: AppDimention.size10),
                                        padding: EdgeInsets.only(
                                            left: AppDimention.size10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              AppDimention.size100),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: AppDimention.size40,
                                              height: AppDimention.size40,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppDimention.size100),
                                                  image: const DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: AssetImage(
                                                          "assets/image/logo.png"))),
                                            ),
                                            SizedBox(
                                                width: AppDimention.size10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                    height: AppDimention.size5),
                                                Text(
                                                  item.fullName.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: AppDimention.size100 *
                                                      1.8,
                                                  child: Text(
                                                    "${item.email}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
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
                            )
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
                    padding: EdgeInsets.only(
                        left: AppDimention.size20,
                        right: AppDimention.size20,
                        top: AppDimention.size10),
                    decoration: BoxDecoration(
                        color: AppColor.mainColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppDimention.size40),
                            topRight: Radius.circular(AppDimention.size40))),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
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
                : const SizedBox.shrink(),
            Container(
              width: AppDimention.screenWidth,
              height: AppDimention.size70,
              decoration: const BoxDecoration(
                color: AppColor.mainColor,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: SizedBox(
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
                      margin:
                          EdgeInsets.symmetric(horizontal: AppDimention.size10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppDimention.size10),
                      ),
                      child: TextField(
                        controller: sendController,
                        decoration: const InputDecoration(
                          hintText: "Chart ...",
                          hintStyle: TextStyle(color: Colors.black12),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: Colors.transparent),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: Colors.transparent),
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _sendMessage();
                    },
                    child: SizedBox(
                      width: AppDimention.size70,
                      height: AppDimention.size70,
                      child: Center(
                        child: Transform.rotate(
                            angle: 0 * 3.1415927 / 180,
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: AppDimention.size40,
                            )),
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
