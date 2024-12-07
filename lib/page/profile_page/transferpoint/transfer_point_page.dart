import 'dart:math';

import 'package:android_project/page/profile_page/profile_footer.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransferPointPage extends StatefulWidget {
  const TransferPointPage({
    super.key,
  });
  @override
  TransferPointPageState createState() => TransferPointPageState();
}

class TransferPointPageState extends State<TransferPointPage> {
  final Random _random = Random();

  void _showDialogAnnounce(int idVoucher) {
    int index = _random.nextInt(1);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            child: Container(
          width: AppDimention.screenWidth,
          height: AppDimention.size100 * 2.25,
          padding: EdgeInsets.all(AppDimention.size10),
          child: Column(
            children: [
              Container(
                width: AppDimention.size100 * 3.1,
                height: AppDimention.size100,
                margin: EdgeInsets.only(
                  top:AppDimention.size10,
                    left: AppDimention.size10,
                    right: AppDimention.size10,
                    bottom: AppDimention.size10),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/image/Voucher$index.png",
                        )),
                    borderRadius: BorderRadius.circular(AppDimention.size10)),
                child: Row(
                  children: [
                    Container(
                      width: AppDimention.size60,
                      height: AppDimention.size100,
                      decoration: const BoxDecoration(
                          border: Border(
                              right:
                                  BorderSide(width: 5, color: Colors.black12))),
                      child: const Center(
                        child: Text(
                          "đ20.000",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: AppDimention.size100 * 2.1,
                      height: AppDimention.size120,
                      padding: EdgeInsets.all(AppDimention.size10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: AppDimention.size100 * 2.3,
                              height: AppDimention.size100 * 0.6,
                              child: const Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Mã : 38A49MD08",
                                        style: TextStyle(color: Colors.white,fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("BLACK FRIDAY",
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.white))
                                    ],
                                  )
                                ],
                              )),
                          SizedBox(
                              width: AppDimention.size100 * 2.4,
                              height: AppDimention.size100 * 0.2,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "200 điểm",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: AppDimention.screenWidth,
                height: AppDimention.size50,
                decoration: BoxDecoration(color: const Color.fromARGB(255, 2, 141, 255),
                borderRadius: BorderRadius.circular(AppDimention.size10)),
                
                 margin: EdgeInsets.only(
                  top:AppDimention.size10,
                    left: AppDimention.size10,
                    right: AppDimention.size10,
                    bottom: AppDimention.size10),
                child: const Center(
                  child: Text("Đổi",style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      body: Column(
        children: [
          SizedBox(
            width: AppDimention.screenWidth,
            height: AppDimention.size70,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SizedBox(
                    width: AppDimention.size70,
                    height: AppDimention.size70,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: AppDimention.size25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: AppDimention.screenWidth,
                  margin: EdgeInsets.only(left: AppDimention.size10),
                 child: const Row(
                  children: [
                    Text("Hiện có :"),
                    Text(" 200 điểm"),
                  ],
                 ),
                ),
                
                SizedBox(
                    width: AppDimention.screenWidth,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          int index = _random.nextInt(1);
                          return GestureDetector(
                            onTap: () {
                              _showDialogAnnounce(index);
                            },
                            child: Container(
                              width: AppDimention.screenWidth,
                              height: AppDimention.size130,
                              margin: EdgeInsets.only(
                                  left: AppDimention.size10,
                                  right: AppDimention.size10,
                                  bottom: AppDimention.size10),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        "assets/image/Voucher$index.png",
                                      )),
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size10)),
                              child: Row(
                                children: [
                                  Container(
                                    width: AppDimention.size120,
                                    height: AppDimention.size130,
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 5,
                                                color: Colors.black12))),
                                    child: const Center(
                                      child: Text(
                                        "đ20.000",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: AppDimention.size100 * 2.5,
                                    height: AppDimention.size130,
                                    padding:
                                        EdgeInsets.all(AppDimention.size10),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                            width: AppDimention.size100 * 2.5,
                                            height: AppDimention.size130 * 0.6,
                                            child: Column(
                                              children: [
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Mã : 38A49MD08",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          AppDimention.size100,
                                                      child: const Text(
                                                          "BLACK FRIDAY",
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 18,
                                                              color: Colors
                                                                  .white)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )),
                                        SizedBox(
                                            width: AppDimention.size100 * 2.5,
                                            height: AppDimention.size130 * 0.2,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "200 điểm",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }))
              ],
            ),
          )),
          const ProfileFooter(),
        ],
      ),
    );
  }
}
