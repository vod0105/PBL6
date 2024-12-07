// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:android_project/caCuLaTor/function.dart';
import 'package:android_project/data/controller/Combo_controller.dart';
import 'package:android_project/data/controller/Order_controller.dart';
import 'package:android_project/data/controller/Product_controller.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/models/Model/Item/ComboItem.dart';
import 'package:android_project/models/Model/Item/ProductItem.dart';
import 'package:android_project/models/Model/OrderModel.dart';
import 'package:android_project/models/Model/UserModel.dart';
import 'package:android_project/page/order_page/order_footer.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class OrderDetailPage extends StatefulWidget {
  final String orderCode;
  const OrderDetailPage({super.key, required this.orderCode});
  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  ProductController productController = Get.find<ProductController>();
  Storecontroller storecontroller = Get.find<Storecontroller>();
  LatLng daNangCoordinates = const LatLng(16.0544, 108.2022);
  MapController mapController = MapController();
  FunctionMap mapFunction = FunctionMap();
  List<LatLng> routePoints = [];
  bool? isShowRoute = false;
  double zoomValue = 14;
  User? shipper;
  @override
  void initState() {
    super.initState();
    Get.find<OrderController>().getOrderByOrderCode(widget.orderCode);
    _fetchShipper();
  }
  Future<void> _fetchShipper() async {
    final orderController = Get.find<OrderController>();
    while (orderController.isLoading) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    if (orderController.orderDetail!.shipperId != 0) {
      final userController = Get.find<UserController>();
      shipper = await userController.getById(orderController.orderDetail!.shipperId!);
      setState(() {});
    }
  }
  Future<void> getRoute(LatLng startPoint, LatLng endPoint) async {
    const apiKey = '5b3ce3597851110001cf62482f6aa59251a040bca10bfec215ef276c';
    final url = 'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${startPoint.longitude},${startPoint.latitude}&end=${endPoint.longitude},${endPoint.latitude}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coordinates = data['features'][0]['geometry']['coordinates'];
      setState(() {
        routePoints = coordinates.map((point) => LatLng(point[1], point[0])).toList();
      });
    } else {
      Get.snackbar(
          "Thông báo",
          "Lấy đường đi thất bại",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.black,
          icon: const Icon(Icons.card_giftcard_sharp, color: Colors.green),
          borderRadius: 10,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 1),
          isDismissible: true,
        );
    }
  }
  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }
  String formatTime(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return DateFormat('yyyy/MM/dd').format(dateTime);
  }
  void _showDialogRoad(User shipper ,double latitude,double longitude ,Function getRoute) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: SizedBox(
            width: AppDimention.screenWidth,
            height: AppDimention.size100 * 4,
            child: Container(
                width: AppDimention.screenWidth,
                height: AppDimention.size100 * 3,
                decoration: const BoxDecoration(color: Colors.amber),
                child: Stack(
                  children: [
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        initialCenter: daNangCoordinates,
                        initialZoom: zoomValue,
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
                                point: LatLng(shipper.latitude!, shipper.longitude!),
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.all(AppDimention.size10),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                              AppDimention.size5)),
                                      child: const Text(
                                        "Shipper",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.blue,
                                    ),
                                  ],
                                )),
                            Marker(
                                width: 100.0,
                                height: 80.0,
                                point: LatLng(latitude, longitude),
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.all(AppDimention.size10),
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius: BorderRadius.circular(
                                              AppDimention.size5)),
                                      child: const Text(
                                        "Điểm giao",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.yellow,
                                    ),
                                  ],
                                )),
                           
                          ],
                        ),
                        if (isShowRoute!)
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: routePoints,
                                strokeWidth: 4.0,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                      ],
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            mapController.move(LatLng(shipper.latitude!, shipper.longitude!), zoomValue);
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
                        bottom: 10,
                        left: 10,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              zoomValue = zoomValue + 1;
                            });
                            mapController.move(LatLng(shipper.latitude!, shipper.longitude!), zoomValue);
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
                        bottom: 10,
                        left: 60,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              zoomValue = zoomValue - 1;
                            });
                            mapController.move(LatLng(shipper.latitude!, shipper.longitude!), zoomValue);
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
                    Positioned(
                        bottom: 10,
                        left: 110,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              getRoute(
                                  LatLng(shipper.latitude!, shipper.longitude!),
                                  LatLng(latitude, longitude));
                              isShowRoute = !isShowRoute!;
                            });
                          },
                          child: Container(
                            width: AppDimention.size40,
                            height: AppDimention.size40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    AppDimention.size5),
                                border: Border.all(
                                    width: 1, color: Colors.black26)),
                            child: const Center(
                              child: Icon(
                                Icons.roundabout_left,
                                size: 20,
                              ),
                            ),
                          ),
                        )),
                  ],
                )),
          ));
        });
  }
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
  void _sendSMS(String phoneNumber) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not send SMS to $phoneNumber';
    }
  }
  void _sendEmail(String email, String subject, String body) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not send email to $email';
    }
  }
  void _showDialogContact(User shipper) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: SizedBox(
            width: AppDimention.screenWidth,
            height: AppDimention.size100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    _sendEmail("${shipper.email}",
                        "Khách hàng đơn hàng được giao", "");
                  },
                  child: Container(
                    width: AppDimention.size100,
                    height: AppDimention.size40,
                    decoration: const BoxDecoration(color: Colors.green),
                    child: const Center(
                      child: Icon(
                        Icons.email,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _sendSMS("${shipper.phoneNumber}");
                  },
                  child: Container(
                    width: AppDimention.size100,
                    height: AppDimention.size40,
                    decoration: const BoxDecoration(color: Colors.green),
                    child: const Center(
                      child: Icon(
                        Icons.chat_bubble_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _makePhoneCall("${shipper.phoneNumber}");
                  },
                  child: Container(
                    width: AppDimention.size100,
                    height: AppDimention.size40,
                    decoration: const BoxDecoration(color: Colors.green),
                    child: const Center(
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return !orderController.isLoading
          ? Scaffold(
              backgroundColor: Colors.grey[200],
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  Container(
                    width: AppDimention.screenWidth,
                    height: AppDimention.size70,
                    decoration: const BoxDecoration(color: AppColor.mainColor),
                    child: Center(
                      child: Text("Chi tiết đơn hàng",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimention.size25,
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: AppDimention.screenWidth,
                            margin: EdgeInsets.all(AppDimention.size10),
                            padding: EdgeInsets.all(AppDimention.size10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:BorderRadius.circular(AppDimention.size10)
                            ),
                            child: 
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.qr_code_2_outlined,size: 16,color: AppColor.mainColor,),
                                      SizedBox(width: AppDimention.size10,),
                                      Text("${orderController.orderDetail!.orderCode}",style: const TextStyle(color: AppColor.mainColor,),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.timelapse_rounded,size: 16,color: AppColor.mainColor,),
                                      SizedBox(width: AppDimention.size10,),
                                      Text(formatTime (orderController.orderDetail!.createdAt!),style: const TextStyle(color: AppColor.mainColor,),),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.money,size: 16,color: AppColor.mainColor,),
                                      SizedBox(width: AppDimention.size10,),
                                      Text("đ${_formatNumber(orderController.orderDetail!.totalAmount!.toInt())}",style: const TextStyle(color: AppColor.mainColor,),),
                                    ],
                                  ),
                                  Text("Địa chỉ giao hàng : ${ orderController.orderDetail!.deliveryAddress}",style: const TextStyle(color: AppColor.mainColor,),),
                                  Text("Trạng thái đơn hàng : ${orderController.orderDetail!.status}",style: const TextStyle(color: Colors.blue,),)
                                  
                                ],
                              )
                        ),
                        if (orderController.orderDetail!.shipperId != 0)
                          shipper == null
                              ? const CircularProgressIndicator()
                              : Column(
                                  children: [
                                    Container(
                                      width: AppDimention.screenWidth,
                                      margin:
                                          EdgeInsets.all(AppDimention.size10),
                                      padding:
                                          EdgeInsets.all(AppDimention.size10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            AppDimention.size10),
                                      ),
                                      child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("Thông tin người giao hàng",style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700
                                                ),),
                                                Text(shipper!.fullName!),
                                                Text(
                                                    "Số điện thoại : ${shipper!.phoneNumber!}"),
                                                Text("Email : ${shipper!.email!}"),
                                              ],
                                            ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.all(AppDimention.size10),
                                      width: AppDimention.screenWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _showDialogContact(shipper!);
                                            },
                                            child: Container(
                                              width: AppDimention.size100 * 1.8,
                                              height: AppDimention.size50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppDimention.size10),
                                                  color: Colors.green),
                                              child: const Center(
                                                child: Text(
                                                  "Liên hệ",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _showDialogRoad(shipper!,orderController.orderDetail!.latitude!,orderController.orderDetail!.longitude!,getRoute);
                                            },
                                            child: Container(
                                              width: AppDimention.size100 * 1.8,
                                              height: AppDimention.size50,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppDimention.size10),
                                                  color: Colors.green),
                                              child: const Center(
                                                child: Text(
                                                  "Lộ trình",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        if(orderController.orderDetail!.shipperId == 0)
                        const Center(
                                child: Text("Chưa có người giao hàng cho đơn hàng"),
                              ),
                        Column(
                          children: orderController.orderDetail!.orderDetails!
                              .map((item) {
                            OrderDetails detail = item;

                            ProductDetail? productOrder;
                            ComboDetail? comboOrder;
                            ComboItem? comboItem;
                            bool? key;
                            if (detail.type == "product") {
                              productOrder = detail.productDetail;
                              key = true;
                            } else {
                              comboOrder = detail.comboDetail;
                              comboItem = Get.find<ComboController>()
                                  .getComboById(comboOrder!.comboId!);
                              key = false;
                            }

                            return GestureDetector(
                              onTap: () {},
                              child: key
                                  ? Container(
                                      width: AppDimention.screenWidth,
                                      margin:
                                          EdgeInsets.all(AppDimention.size10),
                                      padding:
                                          EdgeInsets.all(AppDimention.size10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppDimention.size5),
                                          color: Colors.white),
                                      child: Container(
                                          width: AppDimention.screenWidth,
                                          padding: EdgeInsets.all(
                                              AppDimention.size10),
                                          margin: EdgeInsets.only(
                                              bottom: AppDimention.size10),
                                          decoration: BoxDecoration(
                                              color: Colors.amber.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppDimention.size5)),
                                          child: Column(
                                            children: [

                                              Row(
                                                children: [
                                                  Container(
                                                    width: AppDimention.size80,
                                                    height: AppDimention.size80,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: MemoryImage(
                                                                base64Decode(
                                                                    productOrder!
                                                                        .productImage!))),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppDimention
                                                                        .size5)),
                                                  ),
                                                  SizedBox(
                                                    width: AppDimention.size10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          "${productOrder.productName}"),
                                                      Text(
                                                          "đ${_formatNumber(productOrder.unitPrice!.toInt())}"),
                                                      SizedBox(
                                                        width: AppDimention
                                                                .size100 *
                                                            2.3,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                "Size : ${productOrder.size}"),
                                                            Text(
                                                                "Số lượng : ${productOrder.quantity}"),
                                                          ],
                                                        ),
                                                      ),
                                                      
                                                    ],
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: AppDimention.size10,
                                              ),
                                              Text(
                                                  "Cửa hàng : ${storecontroller.addressOfStore(productOrder.storeId!)}")
                                            ],
                                          )),
                                    )
                                  : Container(
                                      width: AppDimention.screenWidth,
                                      margin:
                                          EdgeInsets.all(AppDimention.size10),
                                      padding:
                                          EdgeInsets.all(AppDimention.size10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppDimention.size5),
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          Text(
                                            comboItem!.comboName!,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Container(
                                              width: AppDimention.screenWidth,
                                              padding: EdgeInsets.all(
                                                  AppDimention.size20),
                                              decoration: BoxDecoration(
                                                  color: Colors.amber
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppDimention.size10)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text("Chi tiết combo"),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "đ${_formatNumber(comboOrder!.totalPrice!.toInt())}"),
                                                      Text(
                                                          "Số lượng ${comboOrder.quantity}"),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                          "Size : ${comboOrder.size}"),
                                                      Text(
                                                          "${comboOrder.status}"),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: AppDimention.size20,
                                                  ),
                                                  Text(
                                                      "Cửa hàng :${storecontroller.addressOfStore(comboOrder.storeId!)} ")
                                                ],
                                              )),
                                          SizedBox(
                                            height: AppDimention.size20,
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text("Danh sách sản phẩm"),
                                            ],
                                          ),
                                          Column(
                                            children: comboItem.products!
                                                .map((item) => Container(
                                                  width: AppDimention
                                                      .screenWidth,
                                                  padding: EdgeInsets.all(
                                                      AppDimention
                                                          .size10),
                                                  margin: EdgeInsets.only(
                                                      top: AppDimention
                                                          .size10),
                                                  decoration: BoxDecoration(
                                                      color: Colors
                                                          .grey[200],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              AppDimention
                                                                  .size5)),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width:
                                                            AppDimention
                                                                .size80,
                                                        height:
                                                            AppDimention
                                                                .size80,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: MemoryImage(
                                                                    base64Decode(item
                                                                        .image!))),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    AppDimention
                                                                        .size5)),
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            AppDimention
                                                                .size10,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "${item.productName}"),
                                                          Text(
                                                              "đ${_formatNumber(item.price!.toInt())}"),
                                                          Row(
                                                            children: [
                                                              Wrap(
                                                                children:
                                                                    List.generate(
                                                                        5,
                                                                        (index) {
                                                                  if (index <
                                                                      item.averageRate!
                                                                          .floor()) {
                                                                    return Icon(
                                                                        Icons.star,
                                                                        color: Colors.red,
                                                                        size: AppDimention.size15);
                                                                  } else if (index == item.averageRate!.floor() &&
                                                                      item.averageRate! % 1 !=
                                                                          0) {
                                                                    return Icon(
                                                                        Icons.star_half,
                                                                        color: Colors.red,
                                                                        size: AppDimention.size15);
                                                                  } else {
                                                                    return Icon(
                                                                        Icons.star_border,
                                                                        color: Colors.red,
                                                                        size: AppDimention.size15);
                                                                  }
                                                                }),
                                                              ),
                                                              Text(
                                                                "(${item.averageRate})",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: AppDimention
                                                                    .size100 *
                                                                2.3,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                GestureDetector(
                                                                  onTap:
                                                                      () {
                                                                    Get.toNamed(
                                                                        AppRoute.get_product_detail(item.productId!));
                                                                  },
                                                                  child:
                                                                      const Center(
                                                                    child:
                                                                        Text("Chi tiết"),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ))
                                                .toList(),
                                          ),
                                          if (comboOrder.drinkId!.isNotEmpty)
                                            Column(
                                              children: [
                                                SizedBox(
                                                  height: AppDimention.size20,
                                                ),
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Danh sách nước uống mua thêm"),
                                                  ],
                                                ),
                                                Column(
                                                  children: comboOrder.drinkId!
                                                      .map((item) {
                                                    Productitem? productitem =
                                                        productController
                                                            .getProductById(
                                                                int.parse(
                                                                    item));
                                                    return Container(
                                                      width: AppDimention
                                                          .screenWidth,
                                                      padding: EdgeInsets.all(
                                                          AppDimention
                                                              .size10),
                                                      margin: EdgeInsets.only(
                                                          top: AppDimention
                                                              .size10),
                                                      decoration: BoxDecoration(
                                                          color: Colors
                                                              .grey[200],
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  AppDimention
                                                                      .size5)),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width:
                                                                AppDimention
                                                                    .size80,
                                                            height:
                                                                AppDimention
                                                                    .size80,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    image: MemoryImage(base64Decode(
                                                                        productitem!
                                                                            .image!))),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        AppDimention
                                                                            .size5)),
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                AppDimention
                                                                    .size10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  "${productitem.productName}"),
                                                              Text(
                                                                  "đ${_formatNumber(productitem.price!.toInt())}"),
                                                              Row(
                                                                children: [
                                                                  Wrap(
                                                                    children:
                                                                        List.generate(
                                                                            5,
                                                                            (index) {
                                                                      if (index <
                                                                          productitem.averageRate!
                                                                              .floor()) {
                                                                        return Icon(
                                                                            Icons.star,
                                                                            color: Colors.red,
                                                                            size: AppDimention.size15);
                                                                      } else if (index == productitem.averageRate!.floor() &&
                                                                          productitem.averageRate! % 1 !=
                                                                              0) {
                                                                        return Icon(
                                                                            Icons.star_half,
                                                                            color: Colors.red,
                                                                            size: AppDimention.size15);
                                                                      } else {
                                                                        return Icon(
                                                                            Icons.star_border,
                                                                            color: Colors.red,
                                                                            size: AppDimention.size15);
                                                                      }
                                                                    }),
                                                                  ),
                                                                  Text(
                                                                    "(${productitem.averageRate})",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: AppDimention
                                                                        .size100 *
                                                                    2.3,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Get.toNamed(
                                                                            AppRoute.get_product_detail(productitem.productId!));
                                                                      },
                                                                      child:
                                                                          const Center(
                                                                        child:
                                                                            Text("Chi tiết"),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  )),
                  const OrderFooter()
                ],
              ),
            )
          : Scaffold(
            body: SizedBox(
              width: AppDimention.screenWidth,
              height: AppDimention.screenHeight,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
    });
  }
}
