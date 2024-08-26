import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = AppDimention.pageView;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        if (pageController.page != null) {
          currentPageValue = pageController.page!;
        }
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: double.maxFinite,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: 5,
              itemBuilder: (context, position) {
                return _buildView(position);
              },
            ),
          ),
          DotsIndicator(
              dotsCount: 5,
              position: currentPageValue,
              decorator: DotsDecorator(
              activeColor: AppColor.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildView(int index) {
    Matrix4 matrix = Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currentScale = 1 - (currentPageValue - index) * (1 - _scaleFactor);
      var currentTransform = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransform, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currentScale = _scaleFactor + (currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTransform = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransform, 0);
    } else if (index == currentPageValue.floor() - 1) {
      var currentScale = 1 - (currentPageValue - index) * (1 - _scaleFactor);
      var currentTransform = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)
        ..setTranslationRaw(0, currentTransform, 0);
    } else {
      matrix = Matrix4.diagonal3Values(1, _scaleFactor, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              // Handle tap event
            },
            child: Container(
              height: AppDimention.pageViewContainer,
              margin: EdgeInsets.symmetric(horizontal: AppDimention.size5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimention.size30),
                color: const Color(0xFF69c5df),
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://wallpaperaccess.com/full/6790132.png"),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: AppDimention.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: AppDimention.size20,
                  right: AppDimention.size20,
                  bottom: AppDimention.size40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimention.size20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: const Offset(0, 5)),
                  const BoxShadow(
                    color: Colors.white,
                    blurRadius: 5.0,
                    offset: Offset(-5, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(AppDimention.size15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Gà xào sả ớt"),
                    SizedBox(height: AppDimention.size10),
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(
                              5,
                              (index) => Icon(
                                    Icons.star,
                                    color: AppColor.mainColor,
                                    size: AppDimention.size15,
                                  )),
                        ),
                        SizedBox(width: AppDimention.size10),
                        const Text("4.5"),
                        SizedBox(width: AppDimention.size25),
                        const Text("200 reviews"),
                      ],
                    ),
          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Chuyên mục"),
                        Text("Chi tiết"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
