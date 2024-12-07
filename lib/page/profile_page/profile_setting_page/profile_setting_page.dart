import 'dart:async';
import 'dart:convert';

import 'package:android_project/caCuLaTor/function.dart';
import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/data/controller/User_controller.dart';
import 'package:android_project/models/Dto/UserUpdateDto.dart';
import 'package:android_project/models/Model/UserModel.dart';
import 'package:android_project/page/profile_page/profile_setting_page/profile_setting_footer.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSettingPage extends StatefulWidget {
  const ProfileSettingPage({
    super.key,
  });
  @override
  ProfileSettingPageState createState() => ProfileSettingPageState();
}

class ProfileSettingPageState extends State<ProfileSettingPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  String _validateChangePasswordValue = "";
  AuthController authController = Get.find<AuthController>();
  UserController userController = Get.find<UserController>();
  User? user;

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
    loadData();
    setState(() {});
  }

  void loadDistrict() async {
    while (selectedProvince == null) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    districts = await functionMap.listDistrict(selectedProvince!);
    setState(() {});
  }

  void loadData() async {
    while (provinces.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    user = userController.userProfile;
    emailController.text = user!.email!;
    phoneController.text = user!.phoneNumber!;
    fullNameController.text = user!.fullName!;
    List<String> listAddress = user!.address!.split("|@##@|");
    addressController.text = listAddress[2];
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
        setState(() {
          selectedDistrict = item;
        });
      }
    }
  }

  void _changePassword() {
    String password = passwordController.text;
    String newPassword = newPasswordController.text;
    String rePassword = rePasswordController.text;
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );

    if (password == "" || newPassword == "" || rePassword == "") {
      _validateChangePasswordValue = "Vui lòng nhập đủ thông tin";
    } else if (newPassword.length < 8) {
      _validateChangePasswordValue = "Mật khẩu không ít hơn 8 kí tự";
    } else if (!passwordRegExp.hasMatch(newPassword)) {
      _validateChangePasswordValue =
          "Mật khẩu phải chứa ít nhất một ký tự viết thường, viết hoa, số và ký tự đặc biệt";
    } else if (newPassword != rePassword) {
      _validateChangePasswordValue = "Mật khẩu không trùng khớp";
    } else {
      _validateChangePasswordValue = "";
      authController.changepassword(password, newPassword);
    }
    setState(() {});
  }

  void _updateProfile() {
    String? avatar = Get.find<UserController>().base64Image != null &&
            Get.find<UserController>().base64Image!.isNotEmpty
        ? Get.find<UserController>().base64Image
        : "";

    String fullName = fullNameController.text;
    String address =
        "$selectedProvince|@##@|$selectedDistrict|@##@|${addressController.text}";
    String email = emailController.text;
    UserUpdateDto userUpdateDto = UserUpdateDto(
        fullName: fullName, avatar: avatar!, email: email, address: address);
    Get.find<UserController>().updateProfile(userUpdateDto);
    Get.toNamed(AppRoute.PROFILE_PAGE);
  }

  void showDiaLogChangePassword() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          bool hiddenPassword = true;
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              insetPadding: const EdgeInsets.all(10),
              child: Container(
                width: AppDimention.screenWidth,
                height: 450,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppDimention.size20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: AppDimention.size30),
                      child: const Text("Mật khẩu cũ"),
                    ),
                    SizedBox(
                      width: AppDimention.screenWidth,
                      height: AppDimention.size60,
                      child: Center(
                          child: Container(
                        margin: EdgeInsets.only(
                            left: AppDimention.size20,
                            right: AppDimention.size20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(AppDimention.size30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: AppDimention.size10,
                                  spreadRadius: 7,
                                  offset: const Offset(1, 10),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: TextField(
                          obscureText: hiddenPassword,
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Mật khẩu cũ ...",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hiddenPassword = !hiddenPassword;
                                });
                              },
                              child: const Icon(
                                Icons.password,
                                color: AppColor.yellowColor,
                              ),
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
                      )),
                    ),
                    SizedBox(
                      height: AppDimention.size10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: AppDimention.size30),
                      child: const Text("Mật khẩu mới"),
                    ),
                    SizedBox(
                      width: AppDimention.screenWidth,
                      height: AppDimention.size60,
                      child: Center(
                          child: Container(
                        margin: EdgeInsets.only(
                            left: AppDimention.size20,
                            right: AppDimention.size20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(AppDimention.size30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: AppDimention.size10,
                                  spreadRadius: 7,
                                  offset: const Offset(1, 10),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: TextField(
                          obscureText: hiddenPassword,
                          controller: newPasswordController,
                          decoration: InputDecoration(
                            hintText: "Mật khẩu mới ...",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hiddenPassword = !hiddenPassword;
                                });
                              },
                              child: const Icon(
                                Icons.password,
                                color: AppColor.yellowColor,
                              ),
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
                      )),
                    ),
                    SizedBox(
                      height: AppDimention.size10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: AppDimention.size30),
                      child: const Text("Xác nhận mật khẩu mới"),
                    ),
                    SizedBox(
                      width: AppDimention.screenWidth,
                      height: AppDimention.size60,
                      child: Center(
                          child: Container(
                        margin: EdgeInsets.only(
                            left: AppDimention.size20,
                            right: AppDimention.size20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(AppDimention.size30),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: AppDimention.size10,
                                  spreadRadius: 7,
                                  offset: const Offset(1, 10),
                                  color: Colors.grey.withOpacity(0.2))
                            ]),
                        child: TextField(
                          obscureText: hiddenPassword,
                          controller: rePasswordController,
                          decoration: InputDecoration(
                            hintText: "Xác nhận mật khẩu ...",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            prefixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hiddenPassword = !hiddenPassword;
                                });
                              },
                              child: const Icon(
                                Icons.password,
                                color: AppColor.yellowColor,
                              ),
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
                      )),
                    ),
                    SizedBox(
                      height: AppDimention.size10,
                    ),
                    Container(
                      width: AppDimention.screenWidth,
                      margin: EdgeInsets.only(
                        left: AppDimention.size20,
                      ),
                      child: Center(
                        child: Text(
                          _validateChangePasswordValue,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppDimention.size20,
                    ),
                    Center(
                        child: GestureDetector(
                      onTap: () {
                        _changePassword();
                      },
                      child: Container(
                        width: AppDimention.size130,
                        height: AppDimention.size40,
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius:
                                BorderRadius.circular(AppDimention.size10)),
                        child: const Center(
                          child: Text(
                            "Đổi mật khẩu",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(243, 243, 243, 1),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: AppDimention.screenWidth,
                  height: AppDimention.size220,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/image/LoadingBg.png'),
                          fit: BoxFit.cover)),
                  child: Column(
                    children: [
                      Container(
                        width: AppDimention.screenWidth,
                        height: AppDimention.size130,
                        margin: EdgeInsets.only(top: AppDimention.size30),
                        child: Stack(
                          children: [
                            Positioned(
                                child: Center(
                              child: Container(
                                width: AppDimention.size130,
                                height: AppDimention.size130,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppDimention.size100),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Get.find<UserController>().base64Image ==
                                                    null ||
                                                Get.find<UserController>()
                                                        .base64Image ==
                                                    ""
                                            ? userController.userProfile?.avatar ==
                                                        null ||
                                                    userController.userProfile
                                                            ?.avatar ==
                                                        ""
                                                ? const AssetImage(
                                                    "assets/image/avatar.jpg")
                                                : MemoryImage(base64Decode(
                                                    userController
                                                        .userProfile!.avatar!))
                                            : MemoryImage(base64Decode(
                                                Get.find<UserController>().base64Image!)))),
                              ),
                            )),
                            Positioned(
                              bottom: 0,
                              left: AppDimention.screenWidth / 2 +
                                  AppDimention.size20,
                              child: SizedBox(
                                width: AppDimention.size30,
                                height: AppDimention.size30,
                                child: Center(
                                    child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoute.PROFILE_CAMERA_PAGE);
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: AppDimention.size30,
                                  ),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppDimention.size5,
                      ),
                      SizedBox(
                        width: AppDimention.screenWidth,
                        child: Center(
                          child: Text(
                            userController.userProfile!.fullName!,
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: AppDimention.size20,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: AppDimention.size20, right: AppDimention.size20),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        blurRadius: AppDimention.size10,
                        spreadRadius: 7,
                        offset: const Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2))
                  ]),
                  child: TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      hintText: "Họ tên",
                      hintStyle:
                          const TextStyle(color: Colors.black26, fontSize: 13),
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColor.yellowColor,
                        size: AppDimention.size25,
                      ),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: AppDimention.size15),
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
                SizedBox(
                  height: AppDimention.size20,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: AppDimention.size20, right: AppDimention.size20),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        blurRadius: AppDimention.size10,
                        spreadRadius: 7,
                        offset: const Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2))
                  ]),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle:
                          const TextStyle(color: Colors.black26, fontSize: 13),
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColor.yellowColor,
                        size: AppDimention.size25,
                      ),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: AppDimention.size15),
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
                SizedBox(
                  height: AppDimention.size20,
                ),
                Container(
                  width: AppDimention.screenWidth,
                  height: AppDimention.size60,
                  margin: EdgeInsets.only(
                    left: AppDimention.size20,
                    right: AppDimention.size20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: AppDimention.size10,
                        spreadRadius: 7,
                        offset: const Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ],
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: AppDimention.size15),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimention.size5),
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
                    items:
                        provinces.map<DropdownMenuItem<String>>((String value) {
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
                    left: AppDimention.size20,
                    right: AppDimention.size20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: AppDimention.size10,
                        spreadRadius: 7,
                        offset: const Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                    ],
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: AppDimention.size15),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppDimention.size5),
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
                    items:
                        districts.map<DropdownMenuItem<String>>((String value) {
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
                      left: AppDimention.size20, right: AppDimention.size20),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        blurRadius: AppDimention.size10,
                        spreadRadius: 7,
                        offset: const Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2))
                  ]),
                  child: TextField(
                    controller: addressController,
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: AppDimention.size15),
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
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: AppDimention.size20, right: AppDimention.size20),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        blurRadius: AppDimention.size10,
                        spreadRadius: 7,
                        offset: const Offset(1, 10),
                        color: Colors.grey.withOpacity(0.2))
                  ]),
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      enabled: false,
                      hintText: "Số điện thoại",
                      hintStyle:
                          const TextStyle(color: Colors.black26, fontSize: 13),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: AppColor.yellowColor,
                        size: AppDimention.size25,
                      ),
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: AppDimention.size15),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.0, color: Colors.transparent)),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.0, color: Colors.transparent)),
                      border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.transparent)),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppDimention.size10,
                ),
                SizedBox(
                  width: AppDimention.screenWidth,
                  height: AppDimention.size30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDiaLogChangePassword();
                        },
                        child: const Text("Đổi mật khẩu"),
                      ),
                      GestureDetector(
                        onTap: () {
                          _updateProfile();
                        },
                        child: const Text("Lưu thay đổi"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppDimention.size10,
                ),
              ],
            ),
          )),
          const ProfileSettingFooter()
        ],
      ),
    );
  }
}
