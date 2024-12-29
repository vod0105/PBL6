import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/data/controller/Combo_controller.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeCombo extends StatefulWidget {
  const HomeCombo({super.key});

  @override
  HomeComboState createState() => HomeComboState();
}

class HomeComboState extends State<HomeCombo> {
  PageController pageController = PageController(viewportFraction: 0.9);
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

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComboController>(builder: (comboController) {
      return !comboController.isLoading
          ? SizedBox(
              width: AppDimention.screenWidth,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: comboController.comboList
                      .map((item) => GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                  AppRoute.get_combo_detail(item.comboId!));
                            },
                            child: Container(
                              width: AppDimention.size100 * 3,
                              padding: EdgeInsets.only(
                                  top: AppDimention.size10,
                                  bottom: AppDimention.size10),
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0, 2),
                                        blurRadius: 8,
                                        color: Colors.black.withOpacity(0.1))
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size10)),
                              child: Row(
                                children: [
                                  Container(
                                    width: AppDimention.size80,
                                    height: AppDimention.size100,
                                    margin: EdgeInsets.only(
                                        left: AppDimention.size10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppDimention.size10),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: item.image != null
                                            ? Image.network(
                                                "${Appconstant.BASE_URL}/api/v1/public/uploads/images/${item.image}",
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child; // Return the image when loading is done
                                                  } else {
                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  }
                                                },
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                      "assets/image/default.png",
                                                      fit: BoxFit.cover);
                                                },
                                              ).image
                                            : const AssetImage(
                                                "assets/image/LoadingBg.png"),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    padding: EdgeInsets.only(
                                        top: AppDimention.size10,
                                        left: AppDimention.size20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.comboName ?? '',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                        ),
                                        Text(
                                          "đ${_formatNumber(item.price!.toInt())}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18,
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ))
          : const Center(child: CircularProgressIndicator());
    });
  }
}
