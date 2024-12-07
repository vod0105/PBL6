import 'package:android_project/page/profile_page/profile_setup_page/manifest_social/dataManifest.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManifestSocial extends StatefulWidget {
  const ManifestSocial({
    super.key,
  });
  @override
  ManifestSocialState createState() => ManifestSocialState();
}

class ManifestSocialState extends State<ManifestSocial> {
  DataManifest dataManifest = DataManifest();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF4F4F4),
      body: Column(
        children: [
          Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size60,
            padding: EdgeInsets.all(AppDimention.size10),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black26))),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
                SizedBox(
                  width: AppDimention.size20,
                ),
                const Text(
                  "Tiêu chuẩn cộng đồng",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppDimention.screenWidth,
                  height: AppDimention.size100 * 1.5,
                  child: const Center(
                    child: Text(
                      "TIÊU CHUẨN CỘNG ĐỒNG",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.all(AppDimention.size10),
                  child: Text(
                    dataManifest.first,
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  width: AppDimention.screenWidth,
                  height: AppDimention.size80,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black54))),
                  child: const Center(
                    child: Text(
                      "Những việc nên làm",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 24, 230, 168),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  children: dataManifest.second
                      .map((item) => Container(
                            width: AppDimention.screenWidth,
                            padding: EdgeInsets.all(AppDimention.size10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.keys.join(', '),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: AppDimention.size10,
                                ),
                                Text(
                                  item.values.join(', '),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                Container(
                  width: AppDimention.screenWidth,
                  height: AppDimention.size80,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1, color: Colors.black54))),
                  child: const Center(
                    child: Text(
                      "Những việc không nên làm",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color.fromARGB(255, 24, 230, 168),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Column(
                  children: dataManifest.third
                      .map((item) => Container(
                            width: AppDimention.screenWidth,
                            padding: EdgeInsets.all(AppDimention.size10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.keys.join(', '),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                SizedBox(
                                  height: AppDimention.size10,
                                ),
                                Text(
                                  item.values.join(', '),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
                Container(
                  width: AppDimention.screenWidth,
                  height: AppDimention.size80,
                  margin: EdgeInsets.all(AppDimention.size10),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(width: 1,color: Colors.black54))
                  ),
                ),
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.all(AppDimention.size10),
                  margin: EdgeInsets.only(bottom:  AppDimention.size10),
                  child: Text(dataManifest.fourth,textAlign: TextAlign.justify,),
                ),
                 Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.all(AppDimention.size10),
                  margin: EdgeInsets.only(bottom:  AppDimention.size10),
                  child: Text(dataManifest.fifth,textAlign: TextAlign.justify,),
                ),
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.all(AppDimention.size10),
                  margin: EdgeInsets.only(bottom:  AppDimention.size10),
                  child: const Text("Được xây dựng bởi đội ngũ thân thiện của",textAlign: TextAlign.justify,),
                ),
                Center(
                  child: Container(
                    width: AppDimention.size100,
                    height: AppDimention.size100,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/image/logo.png"),fit: BoxFit.cover)
                    ),
                  ),
                )


              ],
            ),
          )),
        ],
      ),
    );
  }
}
