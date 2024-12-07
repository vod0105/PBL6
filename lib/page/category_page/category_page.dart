import 'package:android_project/page/category_page/category_header.dart';
import 'package:android_project/page/category_page/category_list.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({
    super.key,
  });
  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CategoryHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [CategoryList()],
            ),
          )),
        ],
      ),
    );
  }
}
