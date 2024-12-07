import 'dart:async';
import 'dart:convert';

import 'package:android_project/caCuLaTor/function.dart';
import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class StoreList extends StatefulWidget {
  const StoreList({super.key});

  @override
  StoreListState createState() => StoreListState();
}

class StoreListState extends State<StoreList> {
  List<LatLng> routePoints = [];
  Future<List<LatLng>?> getRoute(LatLng startPoint, LatLng endPoint) async {
    const apiKey = '5b3ce3597851110001cf62482f6aa59251a040bca10bfec215ef276c';
    final url =
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$apiKey&start=${startPoint.longitude},${startPoint.latitude}&end=${endPoint.longitude},${endPoint.latitude}';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coordinates =
          data['features'][0]['geometry']['coordinates'];
      return coordinates.map((point) => LatLng(point[1], point[0])).toList();
    } else {
      Get.snackbar("Thông báo", "Không lấy được đường đi");
      return null;
    }
  }

  Point? pointCurrent;
  bool? isLoadedLocation = false;
  double zoomValue = 14;
  FunctionMap functionMap = FunctionMap();
  bool? showRoute = false;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    PermissionStatus permission = await Permission.location.request();

    if (permission.isGranted) {
      pointCurrent = await functionMap.getCurrentLocation();

      setState(() {
        isLoadedLocation = true;
      });
    }
  }

  MapController mapController = MapController();

  String formatTime(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return DateFormat('hh:mm a').format(dateTime);
  }

  void _showDropdown(double latitude, double longitude) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: StatefulBuilder(builder: (builder,context){
            return Container(
            width: AppDimention.screenWidth,
            height: AppDimention.size100 * 5,
            decoration: const BoxDecoration(color: Colors.amber),
            child: isLoadedLocation!
                ? Stack(
                    children: [
                      FlutterMap(
                        mapController: mapController,
                        options: MapOptions(
                          initialCenter: LatLng(pointCurrent!.latitude!,
                              pointCurrent!.longtitude!),
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
                                          "Cửa hàng",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.yellow,
                                      ),
                                    ],
                                  )),
                              Marker(
                                width: 80.0,
                                height: 80.0,
                                point: LatLng(pointCurrent!.latitude!,
                                    pointCurrent!.longtitude!),
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          if (showRoute!)
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
                              mapController.move(
                                  LatLng(pointCurrent!.latitude!,
                                      pointCurrent!.longtitude!),
                                  zoomValue);
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
                              mapController.move(
                                  LatLng(pointCurrent!.latitude!,
                                      pointCurrent!.longtitude!),
                                  zoomValue);
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
                              mapController.move(
                                  LatLng(pointCurrent!.latitude!,
                                      pointCurrent!.longtitude!),
                                  zoomValue);
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
                                _showRoute(
                                    LatLng(pointCurrent!.latitude!,
                                        pointCurrent!.longtitude!),
                                    LatLng(latitude, longitude));
                                showRoute = !showRoute!;
                              });
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
                                  Icons.roundabout_left_rounded,
                                  size: 20,
                                ),
                              ),
                            ),
                          )),
                    ],
                  )
                : const CircularProgressIndicator(),
          );
          })
        );
      },
    );
  }

  void _showRoute(LatLng start, LatLng end) async {
    routePoints = await getRoute(start, end) as List<LatLng>;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Storecontroller>(builder: (storecontroller) {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: storecontroller.storeList.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              width: AppDimention.screenWidth - AppDimention.size20,
              margin: EdgeInsets.only(bottom: AppDimention.size20),
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(width: 1, color: const Color.fromRGBO(0, 0, 0, 0.1)),
                borderRadius: BorderRadius.circular(AppDimention.size10),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: AppDimention.size10,
                            left: AppDimention.size10,
                            right: AppDimention.size10),
                        child:
                            const Icon(Icons.location_on, color: AppColor.mainColor),
                      )
                    ],
                  ),
                  Container(
                    width: AppDimention.screenWidth - AppDimention.size70,
                    padding: EdgeInsets.only(bottom: AppDimention.size20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppDimention.size10),
                        SizedBox(
                          width: AppDimention.size100 * 2.9,
                          child: Text(
                            storecontroller.storeList[index].storeName!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: AppDimention.size10),
                        Row(
                          children: [
                            Container(
                              width: AppDimention.size20,
                              height: AppDimention.size20,
                              decoration: BoxDecoration(
                                color: AppColor.yellowColor,
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size10),
                              ),
                              child: const Center(
                                child: Icon(Icons.home, size: 12),
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: AppDimention.size100 * 2.8,
                              child: Text(
                                  storecontroller.storeList[index].location!),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width: AppDimention.size20,
                              height: AppDimention.size20,
                              decoration: BoxDecoration(
                                color: AppColor.yellowColor,
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size10),
                              ),
                              child: const Center(
                                child: Icon(Icons.phone, size: 12),
                              ),
                            ),
                            const SizedBox(width: 5),
                            SizedBox(
                              width: AppDimention.size100 * 2.5,
                              child: Text(storecontroller
                                  .storeList[index].numberPhone!),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width: AppDimention.size20,
                              height: AppDimention.size20,
                              decoration: BoxDecoration(
                                color: AppColor.yellowColor,
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size10),
                              ),
                              child: const Center(
                                child: Icon(Icons.timelapse_rounded, size: 12),
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: AppDimention.size100 * 2.5,
                              child: Text(
                                "${formatTime(storecontroller
                                        .storeList[index].openingTime!)} - ${formatTime(storecontroller
                                        .storeList[index].closingTime!)}",
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: AppDimention.size10),
                        SizedBox(
                          width: AppDimention.screenWidth,
                          child: Center(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: AppDimention.size120,
                                height: AppDimention.size40,
                                decoration: BoxDecoration(
                                  color: AppColor.mainColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      _showDropdown(
                                          storecontroller
                                              .storeList[index].latitude!,
                                          storecontroller
                                              .storeList[index].longitude!);
                                    },
                                    child: const Text(
                                      "Xem bản đồ",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: AppDimention.size10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(AppRoute.get_store_detail(
                                      storecontroller
                                          .storeList[index].storeId!));
                                },
                                child: Container(
                                  width: AppDimention.size120,
                                  height: AppDimention.size40,
                                  decoration: BoxDecoration(
                                    color: AppColor.mainColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Chi tiết",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
