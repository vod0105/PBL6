import 'package:android_project/page/store_page/store_footer.dart';
import 'package:android_project/page/store_page/store_header.dart';
import 'package:android_project/page/store_page/store_list.dart';
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({
    super.key,
  });
  @override
  StorePageState createState() => StorePageState();
}

class StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
