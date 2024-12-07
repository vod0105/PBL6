import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';

class IconTextCustom extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color color;
  final Color colorIcon;
  final double width;
  final double height;
  const IconTextCustom({
    required this.iconData,
    required this.text,
    required this.color,
    required this.colorIcon,
    required this.width,
    required this.height,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color,
              borderRadius:
                  BorderRadius.all(Radius.circular(AppDimention.size30))),
          child: Icon(
            iconData,
            color: colorIcon,
          ),
        ),
        SizedBox(
          height: AppDimention.size10,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
