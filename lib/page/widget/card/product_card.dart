import 'package:android_project/data/api/AppConstant.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productPrice;
  final double avgRate;
  final double stockQuantity;
  final bool isFreeFee;
  final String image;
  final VoidCallback onTap;
  const ProductCard(
      {super.key,
      required this.productName,
      required this.productPrice,
      required this.avgRate,
      required this.stockQuantity,
      this.isFreeFee = false,
      required this.image,
      required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                  color: Colors.black.withOpacity(0.1))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[100],
                    image: DecorationImage(
                      image: image != "null"
                          ? Image.network(
                              "${Appconstant.BASE_URL}/api/v1/public/uploads/images/$image",
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset("assets/image/default.png",
                                    fit: BoxFit.cover);
                              },
                            ).image
                          : const AssetImage('assets/image/default.png')
                              as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: -20,
                        left: 30,
                        right: 30,
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColor.mainColor.withOpacity(0.8)),
                          child: Center(
                            child: Text(
                              productPrice,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.add_business,
                          size: 12,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${stockQuantity.toInt()}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.star,
                            color: AppColor.mainColor,
                            size: AppDimention.size15),
                        Text(avgRate.toString())
                      ],
                    )
                  ],
                ),
                if (isFreeFee)
                  Row(
                    children: [
                      const Icon(Icons.delivery_dining_sharp),
                      Text(
                        "Miễn phí vận chuyển",
                        style: TextStyle(
                            fontSize: 10, color: Colors.black.withOpacity(0.7)),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      const Icon(Icons.delivery_dining_sharp),
                      Text(
                        "Giao hàng nhanh",
                        style: TextStyle(
                            fontSize: 10, color: Colors.black.withOpacity(0.7)),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
