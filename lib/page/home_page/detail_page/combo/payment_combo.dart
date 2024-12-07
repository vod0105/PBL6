// ignore_for_file: use_build_context_synchronously

import 'package:android_project/data/controller/Promotion_controller.dart';
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/data/controller/Combo_controller.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/data/controller/Size_controller.dart';
import 'package:android_project/models/Model/Item/ProductItem.dart';
import 'package:android_project/models/Model/Item/StoresItem.dart';
import 'package:android_project/models/Model/PromotionModel.dart';
import 'package:android_project/models/Model/Item/ComboItem.dart';
import 'package:android_project/models/Dto/OrderComboDto.dart';
import 'package:android_project/models/Model/ZaloModels.dart';
import 'package:android_project/models/Model/UserModel.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:android_project/blocs/QuantityBlocs.dart';
import 'package:android_project/caCuLaTor/function.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/blocs/SizeBlocs.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:convert';

class PaymentCombo extends StatefulWidget {
  final List<int> idDrink;
  final int quantity;
  final int idCombo;
  const PaymentCombo({
    required this.quantity,
    required this.idCombo,
    required this.idDrink,
    super.key,
  });
  @override
  // ignore: library_private_types_in_public_api
  _PaymentComboState createState() => _PaymentComboState();
}

class _PaymentComboState extends State<PaymentCombo> {
  TextEditingController homeNumberController = TextEditingController();
  ProductController productController = Get.find<ProductController>();
  TextEditingController provinceController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  ComboController comboController = Get.find<ComboController>();
  Storecontroller storecontroller = Get.find<Storecontroller>();
  List<String> paymentMethod = ["CASH", "MOMO", "ZALOPAY"];
  LatLng tappedPoint = const LatLng(16.0471, 108.2068);
  MapController mapController = MapController();
  QuantityBloc quantityBloc = QuantityBloc();
  FunctionMap functionMap = FunctionMap();
  List<Productitem> productitem = [];
  Sizeblocs sizeblocs = Sizeblocs();
  String? selectedVoucherStr = "";
  bool isChangePoint = false;
  double percentSelected = 0;
  bool loadLocation = false;
  bool? isLoadPoint = false;
  String? selectedPayment;
  bool? haveDrink = false;
  String? selectedValue;
  String? announce = "";
  double zoomValue = 14;
  ComboItem? comboItem;
  bool? isLoad = false;
  int? selectSize = 1;
  Point? currentPoint;
  double? longitude;
  double? latitude;
  int? storeid;

  String? selectedProvince;
  List<String> provinces = [];
  String? selectedDistrict;
  List<String> districts = [];
  @override
  void initState() {
    super.initState();
    loadingData();
    getCurrentPosition();
    quantityBloc.setQuantity(widget.quantity);
    loadProvince();
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

  String formatTime(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return DateFormat('hh:mm').format(dateTime);
  }

  Future<void> getCurrentPosition() async {
    currentPoint = await functionMap.getCurrentLocation();
    setState(() {
      isLoadPoint = true;
    });
  }

  void loadingData() async {
    if (widget.idDrink[0] != 0) {
      for (int id in widget.idDrink) {
        productitem.add(productController.getProductById(id)!);
      }
      haveDrink = true;
    }
    comboItem = comboController.getComboById(widget.idCombo);

    setState(() {
      isLoad = true;
    });
  }

  void getAddress() async {
    while (provinces.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    User user = Get.find<UserController>().userProfile!;
    List<String> listAddress = user.address!.split("|@##@|");
    getCoordinatesFromAddress(
        "${listAddress[2]}, ${listAddress[1]}, ${listAddress[0]}");
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

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }

  void onChanged(String? value, int id) {
    setState(() {
      selectedValue = value;
      storeid = id;
    });
  }

  void onChangedPayment(String? value) {
    setState(() {
      selectedPayment = value;
    });
  }

  void onChangedVoucher(double percentPromotion, String promotionCode) {
    setState(() {
      selectedVoucherStr = promotionCode;
      percentSelected = percentPromotion;
    });
  }

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

  void _showDropdown() async {
    if (selectedProvince == null || selectedDistrict == null ||
        homeNumberController.text.isEmpty) {
      Point myPoint = await functionMap.getCurrentLocation();
      setState(() {
        tappedPoint = LatLng(myPoint.latitude!, myPoint.longtitude!);
        loadLocation = true;
        isChangePoint = true;
      });
    } else {
    
      Point addressPoint = await functionMap.getCoordinatesFromAddress(
              "$selectedProvince, $selectedDistrict, ${homeNumberController.text}");

      setState(() {
        tappedPoint = LatLng(addressPoint.latitude!, addressPoint.longtitude!);
        loadLocation = true;
        isChangePoint = true;
      });
    }

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

  void orderCombo() async {
    if (homeNumberController.text.isEmpty ||
        selectedDistrict == null ||
        selectedProvince == null ||
        storeid == null ||
        selectedPayment!.isEmpty) {
      setState(() {
        announce = "Vui lòng nhập đủ thông tin";
      });
    } else {
      String address = "$selectedProvince, $selectedDistrict, ${homeNumberController.text}";
      await Get.find<SizeController>().getById(sizeblocs.getSize());
      String sizeName = Get.find<SizeController>().sizeName;
      int quantity = quantityBloc.getQuantity();
      String paymentMethod = selectedPayment!;
      int idCombo = comboItem!.comboId!;
      int storeId = storeid!;
      if (isChangePoint) {
        longitude = tappedPoint.longitude;
        latitude = tappedPoint.latitude;
      }

      OrderComboDto dto;
      if (selectedVoucherStr != "") {
        if (widget.idDrink[0] == 0) {
          dto = OrderComboDto(
              paymentMethod: paymentMethod,
              comboId: idCombo,
              drinkIds: [],
              storeId: storeId,
              quantity: quantity,
              size: sizeName,
              deliveryAddress: address,
              latitude: latitude,
              longitude: longitude,
              discountCode: selectedVoucherStr);
        } else {
          dto = OrderComboDto(
              paymentMethod: paymentMethod,
              comboId: idCombo,
              drinkIds: widget.idDrink,
              storeId: storeId,
              quantity: quantity,
              size: sizeName,
              deliveryAddress: address,
              latitude: latitude,
              longitude: longitude,
              discountCode: selectedVoucherStr);
        }
      } else {
        if (widget.idDrink[0] == 0) {
          dto = OrderComboDto(
              paymentMethod: paymentMethod,
              comboId: idCombo,
              drinkIds: [],
              storeId: storeId,
              quantity: quantity,
              size: sizeName,
              deliveryAddress: address,
              latitude: latitude,
              longitude: longitude);
        } else {
          dto = OrderComboDto(
              paymentMethod: paymentMethod,
              comboId: idCombo,
              drinkIds: widget.idDrink,
              storeId: storeId,
              quantity: quantity,
              size: sizeName,
              deliveryAddress: address,
              latitude: latitude,
              longitude: longitude);
        }
      }
      await comboController.order(dto);
      while (comboController.ordering) {
        await Future.delayed(const Duration(microseconds: 100));
      }
      if (paymentMethod == "MOMO") {
        var payUrl = comboController.qrcode.payUrl;
        final Uri url = Uri.parse(payUrl!);
        if (!await launchUrl(url)) {
          throw Exception('Could not launch $url');
        }
      } else if (selectedPayment == "ZALOPAY") {
        ZaloData zalo = comboController.qrcodeZalo;
        String payUrl = zalo.orderUrl!;
        if (await canLaunchUrl(Uri.parse(payUrl))) {
          await launchUrl(Uri.parse(payUrl));
        } else {
          throw 'Could not launch $payUrl';
        }
      }
      Get.toNamed(AppRoute.ORDER_PAGE);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size70,
            padding: EdgeInsets.only(
                left: AppDimention.size20, right: AppDimention.size20),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black26))),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: AppDimention.size25,
                  ),
                ),
                SizedBox(
                  width: AppDimention.size20,
                ),
                Text(
                  "Thanh toán đơn hàng",
                  style: TextStyle(
                    fontSize: AppDimention.size20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppDimention.screenWidth,
                  margin: EdgeInsets.only(top: AppDimention.size20),
                  padding: EdgeInsets.only(
                      left: AppDimention.size10, right: AppDimention.size10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Sản phẩm đã chọn"),
                      isLoad!
                          ? Container(
                              width: AppDimention.screenWidth,
                              padding:
                                  EdgeInsets.only(top: AppDimention.size10),
                              margin: EdgeInsets.only(top: AppDimention.size10),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          width: 1, color: Colors.black26))),
                              child: Row(
                                children: [
                                  Container(
                                    width: AppDimention.size100,
                                    height: AppDimention.size100,
                                    margin: EdgeInsets.only(
                                        right: AppDimention.size20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppDimention.size5),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: MemoryImage(base64Decode(
                                                comboItem!.image!)))),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.all(AppDimention.size10),
                                    constraints: BoxConstraints(
                                      minHeight: AppDimention.size100,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: AppDimention.size20,
                                              height: AppDimention.size20,
                                              margin: const EdgeInsets.only(right: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  image: const DecorationImage(
                                                      image: AssetImage(
                                                          "assets/image/combo.jpg"))),
                                            ),
                                            Text("${comboItem!.comboName}")
                                          ],
                                        ),
                                        StreamBuilder(
                                            stream: quantityBloc.quantityStream,
                                            builder: (context, snapshot) {
                                              int quantity = widget.quantity;
                                              if (snapshot.hasData) {
                                                quantity = snapshot.data!;
                                              }
                                              return StreamBuilder(
                                                  stream: sizeblocs.sizeStream,
                                                  builder:
                                                      (context, sizeSnapshot) {
                                                    int sizeId = 1;
                                                    if (sizeSnapshot.hasData) {
                                                      sizeId =
                                                          sizeSnapshot.data!;
                                                    }
                                                    return Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.money,
                                                          color: AppColor
                                                              .mainColor,
                                                          size: 16,
                                                        ),
                                                        SizedBox(
                                                          width: AppDimention
                                                              .size10,
                                                        ),
                                                        Text(
                                                          "${_formatNumber((comboItem!.price!.toInt() + (sizeId - 1) * 10000) * quantity)}đ",
                                                          style: const TextStyle(
                                                              fontSize: 12),
                                                        ),
                                                      ],
                                                    );
                                                  });
                                            }),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                quantityBloc.decrement();
                                              },
                                              child: const Icon(
                                                Icons
                                                    .remove_circle_outline_outlined,
                                                color: AppColor.mainColor,
                                                size: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              width: AppDimention.size10,
                                            ),
                                            StreamBuilder(
                                                stream:
                                                    quantityBloc.quantityStream,
                                                builder: (context, snapshot) {
                                                  int quantity =
                                                      widget.quantity;
                                                  if (snapshot.hasData) {
                                                    quantity = snapshot.data!;
                                                  }
                                                  return Text(
                                                    " $quantity",
                                                    style:
                                                        const TextStyle(fontSize: 12),
                                                  );
                                                }),
                                            SizedBox(
                                              width: AppDimention.size10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                quantityBloc.increment();
                                              },
                                              child: const Icon(
                                                Icons.control_point_outlined,
                                                color: AppColor.mainColor,
                                                size: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppDimention.size10,
                                        ),
                                        GetBuilder<SizeController>(
                                            builder: (sizeController) {
                                          return Row(
                                            children: sizeController.sizeList
                                                .map((item) {
                                              return StreamBuilder(
                                                  stream: sizeblocs.sizeStream,
                                                  builder: (context, snapshot) {
                                                    int sizeId = 1;
                                                    if (snapshot.hasData) {
                                                      sizeId = snapshot.data!;
                                                    }
                                                    return GestureDetector(
                                                      onTap: () {
                                                        sizeblocs
                                                            .setSize(item.id!);
                                                      },
                                                      child: Container(
                                                        width:
                                                            AppDimention.size25,
                                                        height:
                                                            AppDimention.size25,
                                                        margin: const EdgeInsets.only(
                                                            right: 20),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: item
                                                                      .id ==
                                                                  sizeId
                                                              ? Colors
                                                                  .greenAccent
                                                              : Colors
                                                                  .grey[200],
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  AppDimention
                                                                      .size5),
                                                        ),
                                                        child: Center(
                                                          child:
                                                              Text(item.name!),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            }).toList(),
                                          );
                                        }),
                                        SizedBox(
                                          height: AppDimention.size10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: comboItem!.products!
                                              .map((item) => Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.circle,
                                                        size: 6,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            AppDimention.size10,
                                                      ),
                                                      Text(item.productName!)
                                                    ],
                                                  ))
                                              .toList(),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : const CircularProgressIndicator()
                    ],
                  ),
                ),
                if (haveDrink!)
                  Container(
                    width: AppDimention.screenWidth,
                    margin: EdgeInsets.only(top: AppDimention.size60),
                    padding: EdgeInsets.only(
                        left: AppDimention.size10, right: AppDimention.size10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Nước uống đã chọn"),
                        isLoad!
                            ? Column(
                                children: productitem
                                    .map((item) => Container(
                                          width: AppDimention.screenWidth,
                                          padding: EdgeInsets.only(
                                              top: AppDimention.size10),
                                          margin: EdgeInsets.only(
                                              top: AppDimention.size10),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Colors.black26))),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: AppDimention.size60,
                                                height: AppDimention.size60,
                                                margin: EdgeInsets.only(
                                                    right: AppDimention.size20),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppDimention.size5),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: MemoryImage(
                                                            base64Decode(
                                                                item.image!)))),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(
                                                    AppDimention.size10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(item.productName!),
                                                    Text(
                                                        "${_formatNumber(item.price!.toInt() + (selectSize! - 1) * 10000)}đ"),
                                                    SizedBox(
                                                      height:
                                                          AppDimention.size10,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              )
                            : const CircularProgressIndicator()
                      ],
                    ),
                  ),
                Container(
                  width: AppDimention.screenWidth,
                  margin: EdgeInsets.only(top: AppDimention.size50),
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
                    const Text("Cửa hàng"),
                  ],
                ),
                isLoad!
                    ? Container(
                        width: AppDimention.screenWidth,
                        padding: EdgeInsets.all(AppDimention.size10),
                        decoration: const BoxDecoration(),
                        child: DropdownButtonFormField(
                          dropdownColor: Colors.amber.withOpacity(0.5),
                          hint: const Text(
                            "Chọn cửa hàng",
                            style:
                                TextStyle(color: Colors.black26, fontSize: 12),
                          ),
                          items: storecontroller
                              .getCommonStores(comboItem!.products!)
                              .map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Container(
                                width: AppDimention.size100 * 3.8,
                                margin: EdgeInsets.only(
                                    top: AppDimention.size10,
                                    bottom: AppDimention.size10),
                                padding: EdgeInsets.all(AppDimention.size10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200],
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: AppDimention.size100 * 3.8,
                                      child: Text(
                                        item.storeName!,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: AppDimention.size50,
                                              height: AppDimention.size50,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: MemoryImage(
                                                          base64Decode(
                                                              item.image!)))),
                                            ),
                                            SizedBox(
                                              height: AppDimention.size10,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  size: 10,
                                                  color: Colors.blue,
                                                ),
                                                Text(
                                                  "${(functionMap.calculateDistance(item.latitude!, item.longitude!, isLoadPoint! ? currentPoint!.latitude! : 0, isLoadPoint! ? currentPoint!.longtitude! : 0) / 1000).toInt()} km",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.blue,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        Container(
                                          width: AppDimention.screenWidth * 0.7,
                                          padding: EdgeInsets.all(
                                              AppDimention.size10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
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
                                                    item.numberPhone!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColor.mainColor),
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
                                                    "${"${functionMap.formatTime(item.openingTime!)} AM - ${functionMap.formatTime(item.closingTime!)}"} PM",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            AppColor.mainColor),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                    width: AppDimention
                                                            .screenWidth *
                                                        0.58,
                                                    child: Text(
                                                      item.location!,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColor
                                                              .mainColor),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            var selectedStore = value as StoresItem;
                            onChanged(selectedStore.storeName!,
                                selectedStore.storeId!);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size5),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size5),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size5),
                              borderSide: const BorderSide(
                                color: Colors.green,
                                width: 1.0,
                              ),
                            ),
                          ),
                          selectedItemBuilder: (BuildContext context) {
                            return storecontroller
                                .getCommonStores(comboItem!.products!)
                                .map((item) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                height: 60,
                                width: AppDimention.size100 * 3,
                                child: Text(item.storeName!,
                                    style: const TextStyle(fontSize: 16)),
                              );
                            }).toList();
                          },
                        ),
                      )
                    : const CircularProgressIndicator(),
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
                if (storeid != null)
                  GetBuilder<PromotionController>(builder: (controller) {
                    controller.getByStoreId(storeid!);
                    return
                      
                        controller.listPromotionByStoreId.isEmpty
                            ? const Center(
                                child: Text(
                                  "Bạn không có mã giảm giá phù hợp",
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
                                  items: controller.listPromotionByUser
                                      .where((item) =>
                                          item.storeId!.contains(storeid))
                                      .where((item) => item.used == false)
                                      .map((item) {
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
                Row(
                  children: [
                    SizedBox(
                      width: AppDimention.size10,
                    ),
                    const Text("Ghi chú"),
                  ],
                ),
                Container(
                  width: AppDimention.screenWidth,
                  margin: EdgeInsets.all(AppDimention.size10),
                  padding: EdgeInsets.all(AppDimention.size10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppDimention.size5),
                      border: Border.all(width: 1, color: Colors.black26)),
                  child: TextField(
                    maxLines: 5,
                    controller: noteController,
                    decoration: InputDecoration(
                      hintText: ".........",
                      hintStyle: const TextStyle(color: Colors.black26),
                      focusedBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimention.size30),
                          borderSide:
                              const BorderSide(width: 1.0, color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimention.size30),
                          borderSide:
                              const BorderSide(width: 1.0, color: Colors.white)),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimention.size30),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    announce!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                SizedBox(
                  width: AppDimention.screenWidth,
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      orderCombo();
                    },
                    child: Container(
                      width: AppDimention.size150,
                      height: AppDimention.size50,
                      margin: EdgeInsets.only(
                          top: AppDimention.size10,
                          bottom: AppDimention.size50),
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
