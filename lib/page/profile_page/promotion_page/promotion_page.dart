import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/page/home_page/home_banner.dart';
import 'package:android_project/page/home_page/home_combo.dart';
import 'package:android_project/page/home_page/home_folder.dart';
import 'package:android_project/page/home_page/home_footer.dart';
import 'package:android_project/page/home_page/home_header.dart';

import 'package:android_project/page/profile_page/promotion_page/promotion_body.dart';
import 'package:android_project/page/profile_page/promotion_page/promotion_header.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({
    Key? key,
  }) : super(key: key);
  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          PromotionHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                PromotionBody(),
              ],
            ),
          )),

        ],
      ),
    );
  }
}
