import 'package:android_project/custom/big_text.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';

class CartList extends StatefulWidget {
  const CartList({
    Key? key,
  }) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  bool key = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: AppDimention.size20),
          Container(
            width: 375,
            height: 50,
            decoration: BoxDecoration(
                color: AppColor.mainColor,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                      setState(() {
                        key = !key;
                      });
                  },
                  child: Icon(
                    key?Icons.square:Icons.square_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 250,
                  child: BigText(
                    text: "Chi tiết",
                    color: Colors.white,
                  ),
                ),
                BigText(
                  text: "#",
                  color: Colors.white,
                )
              ],
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 375,
                  height: 150,
                  margin: EdgeInsets.only(
                      bottom: AppDimention.size10,
                      left: AppDimention.size10,
                      right: AppDimention.size10),
                 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        key?Icons.square:Icons.square_outlined,
                        size: 30,
                        color: AppColor.mainColor,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1))
                        ),
                        width: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: AppDimention.size10,
                            ),
                            BigText(text: "Cá hồi xả sả ớt , cay cay"),
                            Text("Giá : 20.000 vnđ"),
                            Text("Đánh giá  : 4.9"),
                            Text(
                              "54,Nguyễn Lương Bằng , Liên Chiểu , Đà Nẵng",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1, 
                            ),

                            SizedBox(
                              height: AppDimention.size10,
                            ),
                            Container(
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: AppColor.mainColor
                              ),
                            ),
                          ],
                        ),
                      ),
                     Column(
                      children: [
                        Container(
                          width: 40,
                          height: 75,
                          child: Icon(Icons.restore_from_trash,color: Color.fromARGB(255, 255, 130, 130),size: AppDimention.size40,),
                        ),
                        Container(
                          width: 40,
                          height: 75,
                           child: Icon(Icons.shopping_cart_checkout_outlined,color: Colors.greenAccent,size: AppDimention.size40,),
                        ),
                      ],
                     )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
