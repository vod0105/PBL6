
import 'package:android_project/page/chat_page/search_chart/search_chat_body.dart';
import 'package:android_project/page/chat_page/search_chart/search_chat_header.dart';
import 'package:android_project/page/profile_page/profile_footer.dart';
import 'package:flutter/material.dart';

class SearchChat extends StatefulWidget {
  const SearchChat({
    super.key,
  });
  @override
  SearchChatState createState() => SearchChatState();
}

class SearchChatState extends State<SearchChat> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:  Color(0xFFF4F4F4),
      body: Column(
        children: [
          SearchChatHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: SearchChatBody()
          )),
        ProfileFooter()
        ],
      ),
    );
  }
}
