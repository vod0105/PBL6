import 'dart:async';

import 'package:android_project/data/controller/Store_Controller.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class StoreList extends StatefulWidget {
  const StoreList({Key? key}) : super(key: key);

  @override
  _StoreListState createState() => _StoreListState();
}

class _StoreListState extends State<StoreList> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  static const LatLng sourceLocation = LatLng(105.83416,21.027763);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  final Set<Polyline> _polylines = {};

  String formatTime(String isoDateTime) {
    DateTime dateTime = DateTime.parse(isoDateTime);
    return DateFormat('hh:mm a').format(dateTime);
  }

  void _showDropdown(double latitude, double longitude) {
  LatLng dynamicLocation = LatLng(latitude, longitude);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Bản đồ"),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              if (!_controller.isCompleted) {
                _controller.complete(controller);
              }
            },
            initialCameraPosition: CameraPosition(
              target: dynamicLocation,
              zoom: 13.5,
            ),
            markers: {
              Marker(
                markerId: MarkerId("source"),
                position: dynamicLocation,
              ),
            },
            polylines: _polylines,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Đóng"),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return GetBuilder<Storecontroller>(builder: (storecontroller) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: storecontroller.storeList.length,
        itemBuilder: (context, index) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              width: AppDimention.screenWidth - AppDimention.size20,
              height: AppDimention.size220,
              margin: EdgeInsets.only(bottom: AppDimention.size20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Color.fromRGBO(0, 0, 0, 0.1)),
                borderRadius: BorderRadius.circular(AppDimention.size10),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: AppDimention.size10, left: AppDimention.size10, right: AppDimention.size10),
                        child: Icon(Icons.location_on, color: AppColor.mainColor),
                      )
                    ],
                  ),
                  Container(
                    width: AppDimention.screenWidth - AppDimention.size70,
                    height: AppDimention.size220,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: AppDimention.size10),
                        Text(
                          storecontroller.storeList[index].storeName,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: AppDimention.size10),
                        Row(
                          children: [
                            Container(
                              width:  AppDimention.size20,
                              height:  AppDimention.size20,
                              decoration: BoxDecoration(
                                color: AppColor.yellowColor,
                                borderRadius: BorderRadius.circular(AppDimention.size10),
                              ),
                              child: Center(
                                child: Icon(Icons.home, size: 12),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: AppDimention.size290,
                              child: Text(storecontroller.storeList[index].location),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Container(
                              width:  AppDimention.size20,
                              height:  AppDimention.size20,
                              decoration: BoxDecoration(
                                color: AppColor.yellowColor,
                                borderRadius: BorderRadius.circular(AppDimention.size10),
                              ),
                              child: Center(
                                child: Icon(Icons.phone, size: 12),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 295,
                              child: Text(storecontroller.storeList[index].numberPhone),
                            )
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              width:  AppDimention.size20,
                              height:  AppDimention.size20,
                              decoration: BoxDecoration(
                                color: AppColor.yellowColor,
                                borderRadius: BorderRadius.circular(AppDimention.size10),
                              ),
                              child: Center(
                                child: Icon(Icons.timelapse_rounded, size: 12),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              width: AppDimention.size290,
                              child: Text(
                                formatTime(storecontroller.storeList[index].openingTime) +
                                    " - " +
                                    formatTime(storecontroller.storeList[index].closingTime),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: AppDimention.size10),
                        Container(
                          width: AppDimention.screenWidth,
                          child: Center(
                            child: Container(
                              width: AppDimention.size120,
                              height: AppDimention.size40,
                              decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    _showDropdown(storecontroller.storeList[index].latitude,storecontroller.storeList[index].longitude);
                                  },
                                  child: Text(
                                    "Xem bản đồ",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
