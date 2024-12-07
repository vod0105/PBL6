import 'dart:convert';
import 'package:android_project/caCuLaTor/function.dart';
import 'package:android_project/data/controller/Cart_controller.dart';
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/data/controller/Promotion_controller.dart';
import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/models/Model/CartModel.dart';
import 'package:android_project/models/Model/Item/ProductItem.dart';
import 'package:android_project/models/Model/MomoModel.dart';
import 'package:android_project/models/Model/PromotionModel.dart';
import 'package:android_project/models/Model/UserModel.dart';
import 'package:android_project/models/Model/ZaloModels.dart';
import 'package:android_project/page/cart_page/cart_order/cart_order_header.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class CartOrder extends StatefulWidget {
  const CartOrder({super.key});

  @override
  CartOrderState createState() => CartOrderState();
}

class CartOrderState extends State<CartOrder> {
  TextEditingController provinceController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  CartController cartController = Get.find<CartController>();
  ProductController productController = Get.find<ProductController>();
  PromotionController promotionController = Get.find<PromotionController>();
  List<int> listCategoryId = [];
  String? selectedVoucherStr = "";
  double percentSelected = 0;

  String? selectedProvince;
  List<String> provinces = [];
  String? selectedDistrict;
  List<String> districts = [];
  FunctionMap functionMap = FunctionMap();
  
  @override
  void initState() {
    super.initState();
    cartController.getListCartOrder();
    loadVoucher();
    loadProvince();
  }
  void loadVoucher()async{
    await promotionController.getByUser();
  }
   void onChangedVoucher(double percentPromotion, String promotionCode) {
    setState(() {
      selectedVoucherStr = promotionCode;
      percentSelected = percentPromotion;
    });
  }

  double? latitude;
  double? longitude;
  Future<bool> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        setState(() {
          latitude = locations.first.latitude;
          longitude = locations.first.longitude;
        });
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  double calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) {
    double distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);

    return distanceInMeters;
  }

  void loadProvince() async {
    provinces = await functionMap.listProvinces();
    setState(() {});
  }

  void loadDistrict() async {
    while (selectedProvince == null) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    districts = await functionMap.listDistrict(selectedProvince!);
    setState(() {});
  }
  
  void getAddress() async {
    while (provinces.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    User user = Get.find<UserController>().userProfile!;
    List<String> listAddress = user.address!.split("|@##@|");
    getCoordinatesFromAddress( "${listAddress[2]}, ${listAddress[1]}, ${listAddress[0]}");
    homeNumberController.text = listAddress[2];
    for (String item in provinces) {
      if (item.trim().toLowerCase() == listAddress[0].toLowerCase().trim()) {
        selectedProvince = item;
      }
    }
    loadDistrict();
    while (districts.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    for (String item in districts) {
      if (item.trim().toLowerCase() == listAddress[1].toLowerCase().trim()) {
        selectedDistrict = item;
      }
    }
  }
   String formatTime(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }

  String? selectedPayment;
  List<String> paymentMethod = ["CASH", "MOMO", "ZALOPAY"];
  void onChangedPayment(String? value) {
    setState(() {
      selectedPayment = value;
    });
  }


  bool? isLoad = false;
  String? announce = "";
  Future<void> _order() async {
    String paymentMethod = selectedPayment!;
    if (paymentMethod.isEmpty ||
        homeNumberController.text.isEmpty ||
        selectedDistrict == null ||
        selectedProvince == null ) {
      setState(() {
        announce = "Vui lòng nhập đủ thông tin";
      });
    } else {
      String address = "$selectedProvince, $selectedDistrict, ${homeNumberController.text}";
      if (isChangePoint == true) {
        longitude = tappedPoint.longitude;
        latitude = tappedPoint.latitude;
      } 
          
      cartController.orderAll(address, paymentMethod, latitude!, longitude!,selectedVoucherStr!);
      while (cartController.ordering!) {
        await Future.delayed(const Duration(microseconds: 100));
      }
      if (!cartController.ordering!) {
        if (paymentMethod == "MOMO") {
          MoMoModels momo = cartController.qrcode;
          String payUrl = momo.payUrl!;

          if (await canLaunchUrl(Uri.parse(payUrl))) {
            await launchUrl(Uri.parse(payUrl));
          } else {
            throw 'Could not launch $payUrl';
          }
        } else if (paymentMethod == "ZALOPAY") {
          ZaloData zalo = cartController.qrcodeZalo;
          String payUrl = zalo.orderUrl!;
          if (await canLaunchUrl(Uri.parse(payUrl))) {
            await launchUrl(Uri.parse(payUrl));
          } else {
            throw 'Could not launch $payUrl';
          }
        }
      }
      Get.toNamed(AppRoute.ORDER_PAGE);
    }
  }

  double zoomValue = 14;
  MapController mapController = MapController();
  LatLng tappedPoint = const LatLng(16.0471, 108.2068);
  bool? isChangePoint = false;
  bool loadLocation = false;
  void _showDropdown() async {
    if (selectedProvince == null ||
        selectedDistrict == null||
        homeNumberController.text == "") {
      Point myPoint = await functionMap.getCurrentLocation();
      setState(() {
        tappedPoint = LatLng(myPoint.latitude!, myPoint.longtitude!);
        loadLocation = true;
        isChangePoint = true;
      });
    } else {
      User user = Get.find<UserController>().userProfile!;
      user.address!.split("|@##@|");
      Point addressPoint = await functionMap.getCoordinatesFromAddress(
              "$selectedProvince, $selectedDistrict, ${homeNumberController.text}");

      setState(() {
        tappedPoint = LatLng(addressPoint.latitude!, addressPoint.longtitude!);
        isChangePoint = true;
        loadLocation = true;
      });
    }
  if (mounted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size100 * 5,
            decoration: const BoxDecoration(color: Colors.amber),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Stack(
                  children: [
                    loadLocation
                        ? FlutterMap(
                            mapController: mapController,
                            options: MapOptions(
                              initialCenter: tappedPoint,
                              initialZoom: zoomValue,
                              onTap: (tapPosition, LatLng latLng) {
                                setState(() {
                                  tappedPoint = latLng;
                                  mapController.move(tappedPoint, zoomValue);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Tọa độ: ${latLng.latitude}, ${latLng.longitude}',
                                    ),
                                  ),
                                );
                              },
                            ),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                subdomains: const ['a', 'b', 'c'],
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 100.0,
                                    height: 80.0,
                                    point: tappedPoint,
                                    child: const Column(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const CircularProgressIndicator(),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          mapController.move(tappedPoint, zoomValue);
                        },
                        child: Container(
                          width: AppDimention.size40,
                          height: AppDimention.size40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size5),
                              border:
                                  Border.all(width: 1, color: Colors.black26)),
                          child: const Center(
                            child: Icon(
                              Icons.my_location,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            mapController.move(tappedPoint, zoomValue);
                          },
                          child: Container(
                            width: AppDimention.size40,
                            height: AppDimention.size40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size5),
                                border: Border.all(
                                    width: 1, color: Colors.black26)),
                            child: const Center(
                              child: Icon(
                                Icons.my_location,
                                size: 20,
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                        top: 10,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              zoomValue = zoomValue + 1;
                            });
                            mapController.move(tappedPoint, zoomValue);
                          },
                          child: Container(
                            width: AppDimention.size40,
                            height: AppDimention.size40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size5),
                                border: Border.all(
                                    width: 1, color: Colors.black26)),
                            child: const Center(
                              child: Icon(
                                Icons.zoom_out_map_outlined,
                                size: 20,
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                        top: 10,
                        left: 60,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              zoomValue = zoomValue - 1;
                            });
                            mapController.move(tappedPoint, zoomValue);
                          },
                          child: Container(
                            width: AppDimention.size40,
                            height: AppDimention.size40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size5),
                                border: Border.all(
                                    width: 1, color: Colors.black26)),
                            child: const Center(
                              child: Icon(
                                Icons.zoom_in_map_outlined,
                                size: 20,
                              ),
                            ),
                          ),
                        )),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
  }
  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }
  // Show list water
  void _showDialogWater(List<int> listWater) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimention.size10),
              ),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: AppDimention.screenWidth,
                  height: AppDimention.size100 * 2.5,
                  padding: EdgeInsets.all(AppDimention.size10),
                  child: Column(
                    children: listWater.map((item) {
                      Productitem? productitem =
                          productController.getProductById(item);
                      return Container(
                          width: AppDimention.screenWidth,
                          height: AppDimention.size100,
                          padding: EdgeInsets.all(AppDimention.size10),
                          margin: EdgeInsets.only(bottom: AppDimention.size10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size10),
                              image: DecorationImage(
                                  image: MemoryImage(
                                      base64Decode(productitem!.image!)),
                                  fit: BoxFit.cover)),
                          child: Container(
                            width: AppDimention.screenWidth,
                            height: AppDimention.size100,
                            padding: EdgeInsets.all(AppDimention.size10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  productitem.productName!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "đ${_formatNumber(productitem.discountedPrice != null ? productitem.discountedPrice!.toInt() : productitem.price!.toInt())}",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ));
                    }).toList(),
                  ),
                );
              }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          const CartOrderHeader(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                GetBuilder<CartController>(builder: (cartController) {
                  if (cartController.listCartInOrder.isEmpty) {
                    return SizedBox(
                      width: AppDimention.screenWidth,
                      height: AppDimention.size170 + AppDimention.size5,
                      child: const Center(
                        child: Text("Bạn không có món ăn trong giỏ hàng"),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartController.listCartInOrder.length,
                      itemBuilder: (context, index) {
                        for (CartData cart in cartController
                            .listCartInOrder[index].cartData!) {
                          listCategoryId.add(cart.cartId!);
                        }
                       
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: AppDimention.screenWidth,
                            margin: EdgeInsets.only(
                              bottom: AppDimention.size10,
                            ),
                            padding: EdgeInsets.only(
                              left: AppDimention.size10,
                              right: AppDimention.size10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: AppDimention.screenWidth,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: AppDimention.screenWidth,
                                        height: AppDimention.size50,
                                        padding: EdgeInsets.only(
                                            left: AppDimention.size20),
                                        decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5)),
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 1,
                                                    color: Colors.black26))),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: AppDimention.size100 * 3.3,
                                              child: Text(
                                                cartController
                                                    .listCartInOrder[index]
                                                    .storeItem!
                                                    .storeName!,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: AppDimention.screenWidth,
                                        padding: EdgeInsets.only(
                                            left: AppDimention.size20),
                                        margin: EdgeInsets.only(
                                            bottom: AppDimention.size10),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(5),
                                              bottomRight: Radius.circular(5)),
                                        ),
                                        child: Column(
                                          children: cartController.listCartInOrder[index].cartData!.asMap().entries.map((entry) {
                                            var item = entry.value;
                                            ProductInCart? productInCart;
                                            ComboInCart? comboInCart;
                                            bool? key;
                                            if (item.type == "product") {
                                              productInCart = item.product;
                                              key = true;
                                            } else {
                                              comboInCart = item.combo;
                                              key = false;
                                            }
                                            return Container(
                                              width: AppDimention.screenWidth,
                                              padding: EdgeInsets.only(
                                                  top: AppDimention.size10,
                                                  bottom: AppDimention.size10),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(AppRoute
                                                          .get_product_detail(
                                                              item.product!
                                                                  .productId!));
                                                    },
                                                    child: Container(
                                                      width:
                                                          AppDimention.size70,
                                                      height:
                                                          AppDimention.size70,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: const Color.fromARGB(
                                                                  22, 0, 0, 0)),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  AppDimention
                                                                      .size5),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: MemoryImage(
                                                                  base64Decode(key
                                                                      ? productInCart!
                                                                          .image!
                                                                      : comboInCart!.image!)))),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: AppDimention.size20,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        AppDimention.size100 *
                                                            2.3,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            "${key ? productInCart!.productName : comboInCart!.comboName}"),
                                                        Text(
                                                            "Size : ${key ? productInCart!.size : comboInCart!.size}"),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "đ${key ? _formatNumber(productInCart!.unitPrice!.toInt()) : _formatNumber(comboInCart!.unitPrice!.toInt())}",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap: () {},
                                                                  child:
                                                                      Container(
                                                                        padding: EdgeInsets.only(left: AppDimention.size10,right: AppDimention.size10),
                                                                        height: AppDimention.size30,
                                                                        decoration: BoxDecoration(
                                                                      color: Colors.grey,
                                                                      borderRadius: BorderRadius.circular(3)
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "SL : ${key ? productInCart!.quantity : comboInCart!.quantity}",
                                                                        style: const TextStyle(
                                                                            fontSize:12,color: Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if(!key)
                                                                GestureDetector(
                                                                  onTap: (){
                                                                    _showDialogWater(comboInCart!.drinkId!);
                                                                  },
                                                                  child: Container(
                                                                    margin: EdgeInsets.only(left: AppDimention.size10),
                                                                    width: AppDimention.size30,
                                                                    height: AppDimention.size30,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.grey,
                                                                      borderRadius: BorderRadius.circular(3)
                                                                    ),
                                                                    child: const Center(
                                                                      child: Icon(Icons.coffee_sharp,size: 18,color: Colors.white,),
                                                                    ),
                                                                  )
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
                 Container(
                  width: AppDimention.screenWidth,
                 
                  padding: EdgeInsets.only(
                      left: AppDimention.size10, right: AppDimention.size10),
                  child: Text("Tổng : đ${_formatNumber(cartController.totalPrice)}"),      
                
                ),
                
                Container(
                  width: AppDimention.screenWidth,
                  margin: EdgeInsets.only(top: AppDimention.size30),
                  padding: EdgeInsets.only(
                      left: AppDimention.size10, right: AppDimention.size10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: AppDimention.screenWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Địa chỉ giao hàng"),
                            GestureDetector(
                              onTap: () {
                                getAddress();
                              },
                              child: const Text(
                                "Lấy địa chỉ của bạn",
                                style: TextStyle(color: Colors.black38),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppDimention.size10,
                      ),
                      Container(
                        width: AppDimention.screenWidth,
                        height: AppDimention.size60,
                        margin: EdgeInsets.only(
                          left: AppDimention.size5,
                          right: AppDimention.size5,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedProvince,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedProvince = newValue;
                              selectedDistrict = null;
                              loadDistrict();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Tỉnh",
                            hintStyle:
                                const TextStyle(color: Colors.black26, fontSize: 13),
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: AppColor.yellowColor,
                              size: AppDimention.size25,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppDimention.size15),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size5),
                              borderSide:
                                  const BorderSide(width: 1.0, color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size30),
                              borderSide:
                                  const BorderSide(width: 1.0, color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size10),
                            ),
                          ),
                          items: provinces
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: AppDimention.screenWidth,
                        height: AppDimention.size60,
                        margin: EdgeInsets.only(
                          left: AppDimention.size5,
                          right: AppDimention.size5,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedDistrict,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedDistrict = newValue;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Quận / huyện",
                            hintStyle:
                                const TextStyle(color: Colors.black26, fontSize: 13),
                            prefixIcon: Icon(
                              Icons.location_city,
                              color: AppColor.yellowColor,
                              size: AppDimention.size25,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppDimention.size15),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size5),
                              borderSide:
                                  const BorderSide(width: 1.0, color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size30),
                              borderSide:
                                  const BorderSide(width: 1.0, color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size10),
                            ),
                          ),
                          items: districts
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 12),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: AppDimention.size10,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: AppDimention.size5,
                            right: AppDimention.size5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: homeNumberController,
                          decoration: InputDecoration(
                            hintText: "Số nhà , đường ...",
                            hintStyle:
                                const TextStyle(color: Colors.black26, fontSize: 13),
                            prefixIcon: Icon(
                              Icons.roundabout_left_outlined,
                              color: AppColor.yellowColor,
                              size: AppDimention.size25,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: AppDimention.size15),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size30),
                                borderSide: const BorderSide(
                                    width: 1.0, color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size30),
                                borderSide: const BorderSide(
                                    width: 1.0, color: Colors.white)),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showDropdown();
                      },
                      child: const Text(
                        "Gim map",
                        style: TextStyle(color: Colors.black38),
                      ),
                    ),
                    SizedBox(
                      width: AppDimention.size10,
                    ),
                  ],
                ),
                SizedBox(
                  height: AppDimention.size15,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: AppDimention.size10,
                    ),
                    const Text("Phương thức thanh toán"),
                  ],
                ),
                // Get payment select field
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.all(AppDimention.size10),
                  decoration: const BoxDecoration(),
                  child: DropdownButtonFormField(
                    dropdownColor: Colors.amber.withOpacity(0.5),
                    hint: const Text(
                      "Chọn phương thức thanh toán",
                      style: TextStyle(color: Colors.black26, fontSize: 12),
                    ),
                    items: paymentMethod.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Container(
                          width: AppDimention.screenWidth,
                          margin: EdgeInsets.only(
                              top: AppDimention.size10,
                              bottom: AppDimention.size10),
                          padding: EdgeInsets.all(AppDimention.size10),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                                BorderRadius.circular(AppDimention.size5),
                          ),
                          child: SizedBox(
                              width: AppDimention.screenWidth,
                              child: Row(
                                children: [
                                  if (item == "ZALOPAY")
                                    Container(
                                      width: AppDimention.size40,
                                      height: AppDimention.size40,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/image/zalopay.jpg"),
                                              fit: BoxFit.cover)),
                                    ),
                                  if (item == "MOMO")
                                    Container(
                                      width: AppDimention.size40,
                                      height: AppDimention.size40,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/image/momo.png"),
                                              fit: BoxFit.cover)),
                                    ),
                                  if (item == "CASH")
                                    Container(
                                      width: AppDimention.size40,
                                      height: AppDimention.size40,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/image/cash.png"),
                                              fit: BoxFit.cover)),
                                    ),
                                  SizedBox(
                                    width: AppDimention.size20,
                                  ),
                                  Text(
                                    "Thanh toán bằng $item",
                                  ),
                                ],
                              )),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      var selectedMethod = value as String;
                      onChangedPayment(selectedMethod);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimention.size5),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimention.size5),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimention.size5),
                        borderSide: const BorderSide(
                          color: Colors.green,
                          width: 1.0,
                        ),
                      ),
                    ),
                    selectedItemBuilder: (BuildContext context) {
                      return paymentMethod.map((item) {
                        return Container(
                          alignment: Alignment.centerLeft,
                          height: 60,
                          width: AppDimention.size100 * 3,
                          child: Text(item, style: const TextStyle(fontSize: 16)),
                        );
                      }).toList();
                    },
                  ),
                ),
                Row(
                    children: [
                      SizedBox(
                        width: AppDimention.size10,
                      ),
                      const Text("Mã giảm giá"),
                    ],
                  ),
                  GetBuilder<PromotionController>(builder: (controller) {
                    
                    return controller.loadingByUser!? const CircularProgressIndicator() : cartController.listCartInOrder.isNotEmpty && controller.getByStoreIdAndUser(cartController.listCartInOrder[0].storeItem!.storeId!).isEmpty
                            ? const Center(
                                child: Text(
                                  "Bạn không có mã giảm giá cho cửa hàng này",
                                  style: TextStyle(color: Colors.black45),
                                ),
                              )
                            : Container(
                                width: AppDimention.screenWidth,
                                padding: EdgeInsets.all(AppDimention.size10),
                                decoration: const BoxDecoration(),
                                child: DropdownButtonFormField(
                                  dropdownColor: Colors.amber.withOpacity(0.5),
                                  hint: const Text(
                                    "Chọn mã giảm giá",
                                    style: TextStyle(
                                        color: Colors.black26, fontSize: 12),
                                  ),
                                  items: controller.getVoucherByUser().map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Container(
                                        width: AppDimention.screenWidth,
                                        padding:
                                            EdgeInsets.all(AppDimention.size10),
                                        child: Column(
                                          children: [
                                            Container(
                                                width: AppDimention.screenWidth,
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        AppDimention.size10),
                                                padding: EdgeInsets.all(
                                                    AppDimention.size10),
                                                decoration: BoxDecoration(
                                                    image: const DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                          "assets/image/Voucher0.png",
                                                        )),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimention
                                                                .size10)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Mã giảm giá : ${item.code}",
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white)),
                                                    Text(
                                                        "Giá trị : ${item.discountPercent}%",
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white)),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          formatTime(item.startDate!),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text(
                                                          formatTime(item.endDate!),
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    var selectedVoucher =
                                        value as PromotionData;
                                    onChangedVoucher(
                                        selectedVoucher.discountPercent!,
                                        selectedVoucher.code!);
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimention.size5),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimention.size5),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimention.size5),
                                      borderSide: const BorderSide(
                                        color: Colors.green,
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  selectedItemBuilder: (BuildContext context) {
                                    return controller.listPromotion.map((item) {
                                      return Container(
                                        alignment: Alignment.centerLeft,
                                        height: 60,
                                        width: AppDimention.size100 * 3,
                                        child: Text(item.code!,
                                            style: const TextStyle(fontSize: 16)),
                                      );
                                    }).toList();
                                  },
                                ),
                              );
                  }),
                
                Center(
                  child: Text(announce!),
                ),
                SizedBox(
                  width: AppDimention.screenWidth,
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      _order();
                    },
                    child: Container(
                      width: AppDimention.size150,
                      height: AppDimention.size50,
                      margin: EdgeInsets.only(
                          top: AppDimention.size10,
                          bottom: AppDimention.size20),
                      decoration: BoxDecoration(
                          color: AppColor.mainColor,
                          borderRadius:
                              BorderRadius.circular(AppDimention.size5)),
                      child: const Center(
                        child: Text(
                          "Đặt hàng",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
