import 'package:android_project/page/search_page/search_body.dart';
import 'package:android_project/page/search_page/search_footer.dart';
import 'package:android_project/page/search_page/search_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SearchHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [SearchBody()],
            ),
          )),
          SearchFooter(),
        ],
      ),
    );
  }
}
