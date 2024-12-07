
import 'package:android_project/page/profile_page/promotion_page/promotion_body.dart';
import 'package:android_project/page/profile_page/promotion_page/promotion_header.dart';
import 'package:flutter/material.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({
    super.key,
  });
  @override
  PromotionPageState createState() => PromotionPageState();
}

class PromotionPageState extends State<PromotionPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
