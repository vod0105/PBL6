
import 'package:android_project/page/category_page/category_detail_page/category_detail_header.dart';
import 'package:android_project/page/category_page/category_detail_page/category_detail_list.dart';
import 'package:android_project/page/category_page/category_header.dart';
import 'package:android_project/page/category_page/category_list.dart';
import 'package:flutter/material.dart';
class CategoryDetailPage extends StatefulWidget{
  final int categoryid;
   const CategoryDetailPage({
       Key? key,
       required this.categoryid
   }): super(key:key);
   @override
   _CategoryDetailPageState createState() => _CategoryDetailPageState();
}
class _CategoryDetailPageState extends State<CategoryDetailPage>{
   @override
   Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          children: [
           CategoryDetailHeader(),
            Expanded(
              child: SingleChildScrollView(
              child: Column(
                children: [
                    CategoryDetailList()
                   
                ],
              ),
              
            )
            ),
            
            
          ],
        ),
      );
   }
}