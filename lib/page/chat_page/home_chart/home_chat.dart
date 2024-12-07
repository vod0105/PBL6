import 'package:android_project/page/chat_page/home_chart/home_chat_body.dart';
import 'package:android_project/page/chat_page/home_chart/home_chat_header.dart';
import 'package:android_project/page/profile_page/profile_footer.dart';
import 'package:flutter/material.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({
    super.key,
  });
  @override
  HomeChatState createState() => HomeChatState();
}

class HomeChatState extends State<HomeChat> {
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
            child: HomeChatBody()
          )),
        ProfileFooter()
        ],
      ),
    );
  }
}
