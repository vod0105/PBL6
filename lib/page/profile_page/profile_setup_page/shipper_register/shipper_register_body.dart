import 'dart:convert';
import 'dart:io';

import 'package:android_project/caCuLaTor/function.dart';
import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/models/Dto/RegisterShipperDto.dart';
import 'package:android_project/page/profile_page/profile_setup_page/shipper_register/shipper_register_finish.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShipperRegisterBody extends StatefulWidget {
  const ShipperRegisterBody({
    super.key,
  });
  @override
  ShipperRegisterBodyState createState() => ShipperRegisterBodyState();
}

class ShipperRegisterBodyState extends State<ShipperRegisterBody> {
  List<String> title = ["Thông tin", " Xác thực", "Hoàn thành"];
  int titleSelected = 0;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  TextEditingController currentProvinceController = TextEditingController();
  TextEditingController currentDistrictController = TextEditingController();
  TextEditingController currentHomeNumberController = TextEditingController();

  TextEditingController provinceController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController homeNumberController = TextEditingController();

  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController vehicleLicenseController = TextEditingController();
  TextEditingController vehicleStyleController = TextEditingController();
  TextEditingController citizenID = TextEditingController();

  String? selectedProvince;
  List<String> provinces = [];
  String? selectedDistrict;
  List<String> districts = [];
  FunctionMap functionMap = FunctionMap();
  @override
  void initState() {

    super.initState();
    loadProvince();
  }

  void loadProvince() async {
    provinces = await functionMap.listProvinces();
    setState(() {});
  }

  void loadDistrict() async {
    districts = await functionMap.listDistrict(selectedProvince!);
    setState(() {});
  }

  File? imageCccD1;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        imageCccD1 = imageFile;
      });
    }
  }

  File? imageCccD2;
  Future<void> pickImageCccD2() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      setState(() {
        imageCccD2 = imageFile;
      });
    }
  }

  bool _isChecked = false;

  String announceFirst = "";
  String announceSecond = "";
  String announceThird = "";

  bool checkValidateFirst() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty ||
        birthdayController.text.isEmpty ||
        selectedDistrict == null ||
        selectedProvince == null ||
        currentHomeNumberController.text.isEmpty) {
      setState(() {
        announceFirst = "Vui lòng nhập đủ thông tin";
      });
      return false;
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      final phoneRegex = RegExp(r'^(0|\+84)(3|5|7|8|9)\d{8}$');

      if (!emailRegex.hasMatch(emailController.text)) {
        setState(() {
          announceFirst = "Email không hợp lệ";
        });
        return false;
      }
      if (!phoneRegex.hasMatch(phoneController.text)) {
        setState(() {
          announceFirst = "Số điện thoại không hợp lệ";
        });
        return false;
      }
    }
    return true;
  }

  bool checkValidateSecond() {
    if (imageCccD1 == null ||
        imageCccD2 == null ||
        vehicleNumberController.text.isEmpty ||
        vehicleLicenseController.text.isEmpty ||
        citizenID.text.isEmpty ||
        vehicleStyleController.text.isEmpty) {
      setState(() {
        announceSecond = "Vui lòng nhập đủ thông tin";
      });
      return false;
    }
    return true;
  }

  Future<String> convertImageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  void _register() async {
    if (!_isChecked) {
      setState(() {
        announceThird = "Vui lòng xác nhận điều khoản";
      });
    } else {
      String fullName =
          "${firstNameController.text} ${lastNameController.text}";
      String phone = phoneController.text;
      String email = emailController.text;
      String birthday = birthdayController.text;
      String address = "$selectedProvince, $selectedDistrict, ${homeNumberController.text}";

      String veilCleNumber = vehicleLicenseController.text;
      String vehiCleLicense = vehicleLicenseController.text;
      String vehicleStyle = vehicleStyleController.text;

      File? image1 = imageCccD1!;
      String imageFront = "";
      imageFront = await convertImageToBase64(image1);
          File? image2 = imageCccD2!;
      String imageBack = "";
      imageBack = await convertImageToBase64(image2);
          RegisterShipperDto dto = RegisterShipperDto(
          name: fullName,
          citizenID: citizenID.text,
          imageCitizenFront: imageFront,
          imageCitizenBack: imageBack,
          email: email,
          phone: phone,
          address: address,
          birthday: birthday,
          vehicle: vehicleStyle,
          licensePlate: veilCleNumber,
          driverLicense: vehiCleLicense);
      UserController userController = Get.find<UserController>();
      userController.registerShipper(dto).then((status) {
        if (status) {
          Get.to(const ShipperRegisterFinish());
        } else {
          Get.snackbar(
            "Thông báo",
            "Đăng kí thất bại",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white,
            colorText: Colors.black,
            icon: const Icon(Icons.warning_rounded, color: Colors.red),
            borderRadius: 10,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 1),
            isDismissible: true,
          );
        }
      });
    }
  }

  List<int> listFinish = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimention.screenWidth,
      child: Column(
        children: [
          SizedBox(
              width: AppDimention.screenWidth,
              height: AppDimention.size70,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 36,
                    left: 0,
                    child: Container(
                      width: AppDimention.screenWidth,
                      height: AppDimention.size10,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(104, 255, 193, 7),
                          borderRadius:
                              BorderRadius.circular(AppDimention.size10)),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: SizedBox(
                        width: AppDimention.screenWidth,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(title.length, (index) {
                              return GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Container(
                                        width: AppDimention.size50,
                                        height: AppDimention.size50,
                                        margin: EdgeInsets.only(
                                            left: AppDimention.size10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: listFinish.contains(index)
                                              ? Colors.greenAccent
                                              : Colors.grey,
                                          borderRadius: BorderRadius.circular(
                                              AppDimention.size30),
                                        ),
                                        child: Center(
                                          child: index == titleSelected
                                              ? const Icon(Icons.check_circle_outline)
                                              : listFinish.contains(index)
                                                  ? const Icon(Icons.check)
                                                  : null,
                                        ),
                                      ),
                                      Text(title[index]),
                                    ],
                                  ));
                            })),
                      ))
                ],
              )),
          if (titleSelected == 0)
            Container(
              width: AppDimention.screenWidth,
              padding: EdgeInsets.all(AppDimention.size10),
              margin: EdgeInsets.only(top: AppDimention.size10),
              decoration: const BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Họ",
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            width: AppDimention.screenWidth / 2.2,
                            height: AppDimention.size50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black26))),
                            child: TextField(
                              controller: firstNameController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                hintStyle: const TextStyle(color: Colors.black26),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: AppDimention.size10,
                                  horizontal: AppDimention.size10,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppDimention.size30),
                                    borderSide: const BorderSide(
                                        width: 1.0, color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppDimention.size30),
                                    borderSide: const BorderSide(
                                        width: 1.0, color: Colors.white)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tên",
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            width: AppDimention.screenWidth / 2.2,
                            height: AppDimention.size50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black26))),
                            child: TextField(
                              controller: lastNameController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                hintStyle: const TextStyle(color: Colors.black26),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: AppDimention.size10,
                                  horizontal: AppDimention.size10,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppDimention.size30),
                                    borderSide: const BorderSide(
                                        width: 1.0, color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        AppDimention.size30),
                                    borderSide: const BorderSide(
                                        width: 1.0, color: Colors.white)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size30),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppDimention.size15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Số điện thoại",
                        style: TextStyle(fontSize: 16),
                      ),
                      Container(
                        width: AppDimention.screenWidth,
                        height: AppDimention.size50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Colors.black26))),
                        child: TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            hintStyle: const TextStyle(color: Colors.black26),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: AppDimention.size10,
                              horizontal: AppDimention.size10,
                            ),
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
                  SizedBox(
                    height: AppDimention.size15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email",
                        style: TextStyle(fontSize: 16),
                      ),
                      Container(
                        width: AppDimention.screenWidth,
                        height: AppDimention.size50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Colors.black26))),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            hintStyle: const TextStyle(color: Colors.black26),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: AppDimention.size10,
                              horizontal: AppDimention.size10,
                            ),
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
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  const Text(
                    "Địa chỉ hiện tại",
                    style: TextStyle(fontSize: 16),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: AppDimention.screenWidth,
                            height: AppDimention.size50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black26))),
                            child: DropdownButtonFormField<String>(
                              value: selectedProvince,
                              onChanged: (String? newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    selectedProvince = newValue;
                                    loadDistrict();
                                  }
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Tỉnh",
                                hintStyle: const TextStyle(
                                  color: Colors.black26,
                                  fontSize: 14,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: AppDimention.size10,
                                  horizontal: AppDimention.size10,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size30),
                                  borderSide: const BorderSide(
                                      width: 1.0, color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size30),
                                  borderSide: const BorderSide(
                                      width: 1.0, color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size10),
                                ),
                              ),
                              items: provinces.map<DropdownMenuItem<String>>(
                                  (String value) {
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
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: AppDimention.screenWidth,
                            height: AppDimention.size50,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.black26))),
                            child: DropdownButtonFormField<String>(
                              value: selectedDistrict,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDistrict = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: "Quận / huyện",
                                hintStyle: const TextStyle(
                                  color: Colors.black26,
                                  fontSize: 14,
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: AppDimention.size10,
                                  horizontal: AppDimention.size10,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size30),
                                  borderSide: const BorderSide(
                                      width: 1.0, color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size30),
                                  borderSide: const BorderSide(
                                      width: 1.0, color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      AppDimention.size10),
                                ),
                              ),
                              items: districts.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value.toString(),
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppDimention.size15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: AppDimention.screenWidth,
                        height: AppDimention.size50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Colors.black26))),
                        child: TextField(
                          controller: currentHomeNumberController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_on_outlined),
                            hintText: "Số nhà / đường",
                            hintStyle:
                                const TextStyle(color: Colors.black26, fontSize: 14),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: AppDimention.size10,
                              horizontal: AppDimention.size10,
                            ),
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
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Tuổi",
                        style: TextStyle(fontSize: 16),
                      ),
                      Container(
                        width: AppDimention.screenWidth,
                        height: AppDimention.size50,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Colors.black26))),
                        child: TextField(
                          controller: birthdayController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.phone),
                            hintStyle: const TextStyle(color: Colors.black26),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: AppDimention.size10,
                              horizontal: AppDimention.size10,
                            ),
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
                  SizedBox(
                    height: AppDimention.size10,
                  ),
                  if (announceFirst.isNotEmpty)
                    Center(
                      child: Text(
                        announceFirst,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(
                    height: AppDimention.size10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (checkValidateFirst()) {
                          if (!listFinish.contains(titleSelected)) {
                            listFinish.add(titleSelected);
                          }
                          titleSelected = titleSelected + 1;
                        }
                      });
                    },
                    child: SizedBox(
                      width: AppDimention.screenWidth,
                      child: Center(
                          child: Icon(
                        Icons.arrow_circle_right_outlined,
                        size: AppDimention.size30,
                      )),
                    ),
                  ),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                ],
              ),
            )
          else if (titleSelected == 1)
            Container(
              width: AppDimention.screenWidth,
              padding: EdgeInsets.all(AppDimention.size10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  Container(
                    width: AppDimention.screenWidth,
                    height: AppDimention.size100 * 3,
                    padding: EdgeInsets.all(AppDimention.size10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Mặt trước căn cước công dân"),
                        SizedBox(
                          height: AppDimention.size10,
                        ),
                        GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: Container(
                            width: AppDimention.screenWidth,
                            height: AppDimention.size100 * 2.4,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageCccD1 == null
                                        ? const AssetImage("assets/image/upload.png")
                                        : FileImage(imageCccD1!))),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: AppDimention.screenWidth,
                    height: AppDimention.size100 * 3,
                    padding: EdgeInsets.all(AppDimention.size10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Mặt sau căn cước công dân"),
                        SizedBox(
                          height: AppDimention.size10,
                        ),
                        GestureDetector(
                          onTap: () {
                            pickImageCccD2();
                          },
                          child: Container(
                            width: AppDimention.screenWidth,
                            height: AppDimention.size100 * 2.4,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageCccD2 == null
                                        ? const AssetImage("assets/image/upload.png")
                                        : FileImage(imageCccD2!))),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("CCCD"),
                      Container(
                        width: AppDimention.screenWidth,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.black26),
                          ),
                        ),
                        child: TextField(
                          controller: citizenID,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_searching_sharp),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: AppDimention.size10,
                              horizontal: AppDimention.size10,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontSize: 15,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size30),
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
                                  BorderRadius.circular(AppDimention.size30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Biển số xe"),
                      Container(
                        width: AppDimention.screenWidth,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.black26),
                          ),
                        ),
                        child: TextField(
                          controller: vehicleNumberController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_searching_sharp),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: AppDimention.size10,
                              horizontal: AppDimention.size10,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontSize: 15,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size30),
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
                                  BorderRadius.circular(AppDimention.size30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Loại bằng lái xe"),
                      Container(
                        width: AppDimention.screenWidth,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.black26),
                          ),
                        ),
                        child: TextField(
                          controller: vehicleLicenseController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_searching_sharp),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: AppDimention.size10,
                              horizontal: AppDimention.size10,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontSize: 15,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size30),
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
                                  BorderRadius.circular(AppDimention.size30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Loại xe"),
                      Container(
                        width: AppDimention.screenWidth,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(width: 1, color: Colors.black26),
                          ),
                        ),
                        child: TextField(
                          controller: vehicleStyleController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.location_searching_sharp),
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: AppDimention.size10,
                              horizontal: AppDimention.size10,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontSize: 15,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size30),
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
                                  BorderRadius.circular(AppDimention.size30),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppDimention.size10,
                  ),
                  if (announceSecond.isNotEmpty)
                    Center(
                      child: Text(
                        announceSecond,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(
                    height: AppDimention.size10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              titleSelected = titleSelected - 1;
                            });
                          },
                          child: Icon(
                            Icons.arrow_circle_left_outlined,
                            size: AppDimention.size30,
                          )),
                      SizedBox(
                        width: AppDimention.size20,
                      ),
                      GestureDetector(
                          onTap: () {
                            if (checkValidateSecond()) {
                              setState(() {
                                if (!listFinish.contains(titleSelected)) {
                                  listFinish.add(titleSelected);
                                }
                                titleSelected = titleSelected + 1;
                              });
                            }
                          },
                          child: Icon(
                            Icons.arrow_circle_right_outlined,
                            size: AppDimention.size30,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                ],
              ),
            )
          else
            Container(
              width: AppDimention.screenWidth,
              padding: EdgeInsets.all(AppDimention.size10),
              child: Column(
                children: [
                  SizedBox(
                    height: AppDimention.size10,
                  ),
                  const Text(
                    "Điều khoản cần biết",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: AppDimention.size10,
                  ),
                  SizedBox(
                      width: AppDimention.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Điều khoản sử dụng dịch vụ",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: AppDimention.size10,
                          ),
                          const Text(
                            "Người dùng cần tuân thủ các quy định và chính sách của nền tảng khi sử dụng dịch vụ.Không sử dụng tài khoản vào các hoạt động bất hợp pháp hoặc vi phạm quyền lợi của bên thứ ba.Tài khoản shipper chỉ dành riêng cho mục đích giao hàng và các công việc liên quan đến dịch vụ.",
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  SizedBox(
                      width: AppDimention.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Trách nhiệm của shipper",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: AppDimention.size10,
                          ),
                          const Text(
                            "Bảo đảm tính chính xác của thông tin cá nhân cung cấp khi đăng ký.Thực hiện các đơn hàng một cách an toàn, đúng thời gian và tuân thủ các quy định về giao thông và pháp luật hiện hành. Chịu trách nhiệm về sự mất mát hoặc hư hỏng hàng hóa trong quá trình giao nhận nếu do lỗi cá nhân.",
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  SizedBox(
                      width: AppDimention.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Quyền lợi của nền tảng",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: AppDimention.size10,
                          ),
                          const Text(
                            "Nền tảng có quyền thay đổi, bổ sung hoặc tạm dừng dịch vụ mà không cần thông báo trước. Nền tảng có thể khóa hoặc xóa tài khoản nếu phát hiện vi phạm điều khoản sử dụng, như gian lận, hành vi bất hợp pháp.",
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  SizedBox(
                      width: AppDimention.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Chính sách bảo mật",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: AppDimention.size10,
                          ),
                          const Text(
                            "Thông tin cá nhân của shipper sẽ được bảo mật theo quy định của nền tảng và chỉ được sử dụng trong phạm vi cung cấp dịch vụ. Nền tảng cam kết không chia sẻ thông tin của shipper với bên thứ ba trừ khi có yêu cầu từ cơ quan có thẩm quyền.",
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  SizedBox(
                      width: AppDimention.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Chính sách thanh toán",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: AppDimention.size10,
                          ),
                          const Text(
                            "Quy định về mức phí hoa hồng, thời gian thanh toán và phương thức nhận tiền đối với shipper. Các khoản phí phát sinh như xăng xe, tiền ăn, tiền điện thoại đều do shipper tự chi trả.",
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  SizedBox(
                      width: AppDimention.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hủy đơn hàng và phạt",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: AppDimention.size10,
                          ),
                          const Text(
                            "Quy định về việc hủy đơn hàng sau khi đã nhận. Phí phạt nếu shipper vi phạm các quy định như giao hàng trễ hoặc làm hư hỏng hàng hóa.",
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  SizedBox(
                      width: AppDimention.screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Giới hạn trách nhiệm pháp lý",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: AppDimention.size10,
                          ),
                          const Text(
                            "Nền tảng không chịu trách nhiệm cho các sự cố xảy ra ngoài ý muốn hoặc do sự cố kỹ thuật khi sử dụng dịch vụ.",
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = !_isChecked;
                          });
                        },
                      ),
                      const Text(
                        "Tôi đã đọc hết điều khoản",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (announceThird.isNotEmpty)
                        Text(
                          announceThird,
                          style: const TextStyle(color: AppColor.mainColor),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: AppDimention.size10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            titleSelected = titleSelected - 1;
                          });
                        },
                        child: Icon(
                          Icons.arrow_circle_left_outlined,
                          size: AppDimention.size30,
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            _register();
                          },
                          child: Container(
                            width: AppDimention.size150,
                            height: AppDimention.size50,
                            decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size5)),
                            child: Center(
                              child: Text(
                                "Đăng kí",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppDimention.size20,
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: AppDimention.size20,
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
