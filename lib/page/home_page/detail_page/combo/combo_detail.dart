import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/data/controller/Combo_controller.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/models/Model/Item/ProductItem.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';
import 'package:android_project/models/Dto/AddComboToCartDto.dart';
import 'package:android_project/models/Model/Item/ComboItem.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:android_project/blocs/QuantityBlocs.dart';
import 'package:android_project/caCuLaTor/function.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

class ComboDetail extends StatefulWidget {
  final int comboId;
  const ComboDetail({super.key, required this.comboId});
  @override
  ComboDetailState createState() => ComboDetailState();
}

class ComboDetailState extends State<ComboDetail> {
  ProductController productController = Get.find<ProductController>();
  Storecontroller storecontroller = Get.find<Storecontroller>();
  ComboController comboController = Get.find<ComboController>();
  QuantityBloc quantityBloc = QuantityBloc();
  FunctionMap functionMap = FunctionMap();
  List<int> listDrinkSelected = [];
  List<StoresItem>? commonStores;
  List<Productitem>? listDrink;
  bool? isLoadedData = false;
  List<int>? groupValue = [];
  bool? isLoadPoint = false;
  ComboItem? comboItem;
  int? drinkPrice = 0;
  Point? currentPoint;
  int selectSize = 1;
  int quantity = 1;
  int? comboPrice;
  @override
  void initState() {
    super.initState();
    loadData();
    getCurrentPosition();
  }

  void loadData() async {
    comboItem = comboController.getComboById(widget.comboId);
    commonStores = storecontroller.getCommonStores(comboItem!.products!);
    while (storecontroller.loadingCommonStore) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    loadDrink();
    while (productController.loadDrinkInCombo) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    setState(() {
      isLoadedData = true;
    });
  }

  void loadDrink() async {
    List<int> listStore = [];
    for (StoresItem item in commonStores!) {
      listStore.add(item.storeId!);
    }
    listDrink = await productController.getListDrinkInCombo(listStore);
  }

  void onChanged(bool value, int price, int productId) {
    setState(() {
      if (value) {
        drinkPrice = drinkPrice! + price;
        groupValue!.add(productId);
      } else {
        drinkPrice = drinkPrice! - price;
        groupValue!.remove(productId);
      }
    });
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }

  // Get current position of user
  Future<void> getCurrentPosition() async {
    currentPoint = await functionMap.getCurrentLocation();
    setState(() {
      isLoadPoint = true;
    });
  }

  // Add combo to cart
  void addToCart(int storeId) {
    int comboId = widget.comboId;
    int quantityCombo = quantityBloc.getQuantity();
    int storeIdSelected = storeId;
    List<int> drinkId = listDrinkSelected;

    ComboToCartDto comboToCartDto = ComboToCartDto(
        comboId: comboId,
        quantity: quantityCombo,
        storeId: storeIdSelected,
        drinkId: drinkId);
    comboController.addComboToCart(comboToCartDto);
  }

  void _showDropdown() {
    List<StoresItem> items =
        storecontroller.getCommonStores(comboItem!.products!);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.grey.withOpacity(0.2),
          height: 400,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  addToCart(items[index].storeId!);
                  Navigator.pop(context);
                },
                child: Container(
                    width: AppDimention.screenWidth,
                    padding: EdgeInsets.only(
                        left: AppDimention.size10,
                        right: AppDimention.size10,
                        top: AppDimention.size20,
                        bottom: AppDimention.size20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: AppDimention.size10),
                      width: AppDimention.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.blue),
                              Text(
                                "${(functionMap.calculateDistance(items[index].latitude!, items[index].longitude!, isLoadPoint! ? currentPoint!.latitude! : 0, isLoadPoint! ? currentPoint!.longtitude! : 0) / 1000).toInt()}km",
                                style:
                                    const TextStyle(fontSize: 14, color: Colors.blue),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.store,
                                    color: AppColor.mainColor,
                                  ),
                                  SizedBox(
                                    width: AppDimention.screenWidth * 0.7,
                                    child: Text(
                                      items[index].storeName!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: AppColor.mainColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          
                          SizedBox(
                            height: AppDimention.size5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.phone,
                                color: AppColor.mainColor,
                                size: 15,
                              ),
                              SizedBox(
                                width: AppDimention.size10,
                              ),
                              Text(
                                items[index].numberPhone!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.mainColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.timelapse_rounded,
                                color: AppColor.mainColor,
                                size: 15,
                              ),
                              SizedBox(
                                width: AppDimention.size10,
                              ),
                              Text(
                                "${"${functionMap.formatTime(items[index].openingTime!)} AM - ${functionMap.formatTime(items[index].closingTime!)}"} PM",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.mainColor),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.store,
                                color: AppColor.mainColor,
                                size: 15,
                              ),
                              SizedBox(
                                width: AppDimention.size10,
                              ),
                              SizedBox(
                                width: AppDimention.screenWidth * 0.8,
                                child: Text(
                                  items[index].location!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.mainColor),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComboController>(builder: (comboController) {
      return !isLoadedData!
          ? Container(
              width: AppDimention.screenWidth,
              height: AppDimention.screenHeight,
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  height: AppDimention.size100 * 2.7,
                  width: AppDimention.screenWidth,
                  child: Container(
                    width: AppDimention.screenWidth,
                    height: AppDimention.screenHeight,
                    padding: EdgeInsets.all(AppDimention.size20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                          base64Decode(comboItem!.image!),
                        ),
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
                          BlendMode.dstATop,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoute.CART_PAGE);
                              },
                              child: const Icon(Icons.shopping_cart_outlined,
                                  color: Colors.white, size: 30),
                            )
                          ],
                        ),
                        SizedBox(
                          height: AppDimention.size10,
                        ),
                        Text(
                          comboItem!.comboName!,
                          style: TextStyle(
                            fontSize: AppDimention.size40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                  blurRadius: AppDimention.size10,
                                  offset: const Offset(2.0, 2.0),
                                  color: Colors.amber)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: AppDimention.size100 * 2.7,
                  left: 0,
                  child: Container(
                    width: AppDimention.screenWidth,
                    height: AppDimention.screenHeight * 0.6,
                    color: const Color.fromARGB(106, 255, 255, 255),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: AppDimention.screenWidth,
                        child: Column(
                          children: [
                            SizedBox(
                              width: AppDimention.screenWidth,
                              height: AppDimention.size150,
                              child: Stack(
                                children: [
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: AppDimention.size10,
                                          ),
                                          const Text("Danh sách nước uống thêm",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontStyle: FontStyle.italic,
                                              )),
                                          SizedBox(
                                            width: AppDimention.size10,
                                          ),
                                          Container(
                                            width: AppDimention.screenWidth,
                                            height: AppDimention.size5,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppDimention.size10)),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            if(listDrink!.isNotEmpty)
                            Column(
                              children: listDrink!.map((item) {
                                // Check if the current item is selected
                                bool isSelected =
                                    listDrinkSelected.contains(item.productId!);

                                return Container(
                                  padding: EdgeInsets.only(
                                      left: AppDimention.size10,
                                      right: AppDimention.size10,
                                      top: AppDimention.size10),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: isSelected,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            if (newValue == true) {
                                              if (listDrinkSelected.length ==
                                                  2) {
                                                listDrinkSelected.removeAt(0);
                                              }
                                              listDrinkSelected
                                                  .add(item.productId!);
                                            } else {
                                              listDrinkSelected
                                                  .remove(item.productId!);
                                            }
                                            onChanged(
                                                newValue!,
                                                item.price!.toInt(),
                                                item.productId!);
                                          });
                                        },
                                      ),
                                      Container(
                                        width: AppDimention.screenWidth * 0.8,
                                        padding:
                                            EdgeInsets.all(AppDimention.size10),
                                        decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.greenAccent
                                                : Colors.white,
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.black26),
                                            borderRadius: BorderRadius.circular(
                                                AppDimention.size5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(item.productName!),
                                            Text(
                                                "đ${_formatNumber(item.price!.toInt())}"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            SizedBox(
                              height: AppDimention.size100,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: AppDimention.size100 * 1.8,
                  right: AppDimention.size20,
                  child: Container(
                    width: AppDimention.screenWidth * 0.65,
                    padding: EdgeInsets.all(AppDimention.size20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppDimention.size10),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: AppDimention.size10,
                            spreadRadius: 3,
                            offset: const Offset(1, 2),
                            color: Colors.amber)
                      ],
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "Sản phẩm",
                              style: TextStyle(
                                  fontSize: AppDimention.size25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: AppDimention.size10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: comboItem!.products!.map<Widget>((item) {
                              return Row(children: [
                                Icon(
                                  Icons.circle,
                                  size: AppDimention.size10,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  item.productName!,
                                  style: const TextStyle(
                                    height: 2,
                                  ),
                                )
                              ]);
                            }).toList(),
                          ),
                          StreamBuilder(
                              stream: quantityBloc.quantityStream,
                              builder: (context, snapshot) {
                                int quantity = 1;
                                if (snapshot.hasData) {
                                  quantity = snapshot.data!;
                                }
                                return Center(
                                  child: Text(
                                    "đ${_formatNumber(comboItem!.price!.toInt() * quantity + drinkPrice!)}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black38,
                                      shadows: [
                                        Shadow(
                                            blurRadius: AppDimention.size10,
                                            offset: const Offset(2.0, 2.0),
                                            color: Colors.amber)
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(
                            width: AppDimention.screenWidth * 0.55,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    quantityBloc.decrement();
                                  },
                                  child:
                                      const Icon(Icons.remove_circle_outline_sharp),
                                ),
                                StreamBuilder(
                                    stream: quantityBloc.quantityStream,
                                    builder: (context, snapshot) {
                                      int quantity = 1;
                                      if (snapshot.hasData) {
                                        quantity = snapshot.data!;
                                      }
                                      return Text("$quantity");
                                    }),
                                GestureDetector(
                                  onTap: () {
                                    quantityBloc.increment();
                                  },
                                  child: const Icon(Icons.add_circle_outline_sharp),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                ),
                Positioned(
                    top: AppDimention.size150,
                    left: 0,
                    height: AppDimention.size100 * 2.7,
                    child: Center(
                      child: Container(
                        height: AppDimention.size100 * 2,
                        width: AppDimention.screenWidth * 0.25,
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.only(
                                bottomRight:
                                    Radius.circular(AppDimention.size100),
                                topRight:
                                    Radius.circular(AppDimention.size100)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(
                                base64Decode(comboItem!.image!),
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: AppDimention.size10,
                                  spreadRadius: 3,
                                  offset: const Offset(1, 2),
                                  color: Colors.amber)
                            ]),
                      ),
                    )),
                // Bottom of combo page
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    width: AppDimention.screenWidth,
                    height: AppDimention.size80,
                    decoration: const BoxDecoration(color: AppColor.mainColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showDropdown();
                          },
                          child: Container(
                            width: AppDimention.screenWidth * 0.2,
                            height: AppDimention.size50,
                            margin: EdgeInsets.only(left: AppDimention.size10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size5)),
                            child: const Center(
                              child: Icon(Icons.shopping_cart_outlined),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              drinkPrice = 0;
                              groupValue!.clear();
                              listDrinkSelected.clear();
                            });
                          },
                          child: SizedBox(
                            width: AppDimention.screenWidth * 0.2,
                            height: AppDimention.size50,
                            child: const Column(
                              children: [
                                Icon(
                                  Icons.emoji_food_beverage,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Bỏ nước",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoute.orderCombo(
                                comboItem!.comboId!,
                                groupValue!.isEmpty ? [0] : groupValue!,
                                quantityBloc.getQuantity()));
                          },
                          child: Container(
                            width: AppDimention.screenWidth * 0.5,
                            height: AppDimention.size50,
                            margin: EdgeInsets.only(right: AppDimention.size10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size5)),
                            child: const Center(
                              child: Text("Mua ngay"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
    });
  }
}
