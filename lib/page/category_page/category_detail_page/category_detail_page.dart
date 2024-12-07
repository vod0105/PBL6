// ignore_for_file: library_private_types_in_public_api

import 'package:android_project/page/category_page/category_detail_page/category_detail_header.dart';
import 'package:android_project/page/category_page/category_detail_page/category_detail_list.dart';
import 'package:flutter/material.dart';

class CategoryDetailPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  const CategoryDetailPage({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });
  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CategoryDetailHeader(categoryname: widget.categoryName),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [CategoryDetailList(categoryId: widget.categoryId)],
            ),
          )),
        ],
      ),
    );
  }
}
