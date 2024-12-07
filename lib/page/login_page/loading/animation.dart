import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Bar extends StatelessWidget {
  final double marginLeft;
  final double marginRight;

  const Bar({super.key,required this.marginLeft,required this.marginRight});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35.0,
      height: 15.0,
      margin: EdgeInsets.only(left: marginLeft, right: marginRight),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 255, 1.0),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              spreadRadius: 1.0,
              offset: Offset(1.0, 0.0),
            ),
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              spreadRadius: 1.5,
              offset: Offset(1.0, 0.0),
            ),
          ]),
    );
  }
}

class PivotBar extends AnimatedWidget {
  final Animation<double> controller;
  final FractionalOffset alignment;
  final List<Animation<double>> animations;
  final bool isClockwise;
  final double marginLeft;
  final double marginRight;

  const PivotBar({
    super.key,
    this.alignment = FractionalOffset.centerRight,
    required this.controller,
    required this.animations,
    required this.isClockwise,
    this.marginLeft = 15.0,
    this.marginRight = 0.0,
  }) : super(listenable: controller);

  Matrix4 clockwiseHalf(animation) =>
      Matrix4.rotationZ((animation.value * math.pi * 2.0) * .5);
  Matrix4 counterClockwiseHalf(animation) =>
      Matrix4.rotationZ(-(animation.value * math.pi * 2.0) * .5);

  @override
  Widget build(BuildContext context) {
    Matrix4 transformOne;
    Matrix4 transformTwo;
    if (isClockwise) {
      transformOne = clockwiseHalf(animations[0]);
      transformTwo = clockwiseHalf(animations[1]);
    } else {
      transformOne = counterClockwiseHalf(animations[0]);
      transformTwo = counterClockwiseHalf(animations[1]);
    }

    return Transform(
      transform: transformOne,
      alignment: alignment,
      child: Transform(
        transform: transformTwo,
        alignment: alignment,
        child: Container(
          width: AppDimention.size40,
          height: AppDimention.size15,
          margin: EdgeInsets.only(left: marginLeft,right: marginRight),
          decoration: BoxDecoration(
            boxShadow: const [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: Offset(0, 0), 
                ),
              ],
            color: Colors.amber,
            borderRadius: BorderRadius.circular(AppDimention.size10)
          ),
        ),
      ),
    );
  }
}