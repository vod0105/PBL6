import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class ClipPathCustomer extends CustomClipper<Path>{
  final String svgPath;

  ClipPathCustomer({required this.svgPath});

  @override
  Path getClip(Size size) {
    return parseSvgPathData(svgPath);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}
