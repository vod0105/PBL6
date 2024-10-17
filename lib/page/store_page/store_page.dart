import 'package:android_project/page/store_page/store_footer.dart';
import 'package:android_project/page/store_page/store_header.dart';
import 'package:android_project/page/store_page/store_list.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({
    Key? key,
  }) : super(key: key);
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StoreHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                StoreList(),
              ],
            ),
          )),
          StoreFooter()
        ],
      ),
    );
  }
}
