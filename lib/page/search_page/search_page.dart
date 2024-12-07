import 'package:android_project/page/search_page/search_body.dart';
import 'package:android_project/page/search_page/search_footer.dart';
import 'package:android_project/page/search_page/search_header.dart';
import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
  });
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
