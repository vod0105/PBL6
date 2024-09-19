import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreHeader extends StatefulWidget {
  const StoreHeader({Key? key}) : super(key: key);

  @override
  _StoreHeaderState createState() => _StoreHeaderState();
}

class _StoreHeaderState extends State<StoreHeader> {
  void _showDropdown2(List<String> items, Function(String) onItemSelected) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () {
                  onItemSelected(items[index]);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: AppDimention.screenWidth,
          height: 100,
          decoration: BoxDecoration(color: AppColor.mainColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.highlight_remove_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              Container(
                width: 200,
                child: Center(
                  child: Text(
                    "CỬA HÀNG",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoute.CART_PAGE);
                },
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
