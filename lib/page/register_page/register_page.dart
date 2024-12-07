import 'package:android_project/caCuLaTor/function.dart';
import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/models/Dto/UserRegisterDto.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController homeNumber = TextEditingController();
  bool page = true;

  String announce = "";

  String? selectedProvince;
  List<String> provinces = [];
  String? selectedDistrict;
  List<String> districts = [];
  bool? isHidden = true;

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
    while (selectedProvince == null) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    districts = await functionMap.listDistrict(selectedProvince!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    void register() async {
      var authController = Get.find<AuthController>();
      String fullname = fullnameController.text.trim();
      String password = passwordController.text.trim();
      String rePassword = rePasswordController.text.trim();
      String phoneNumber = phoneNumberController.text.trim();
      String email = emailController.text.trim();
      String address = "$selectedProvince|@##@|$selectedDistrict|@##@|${homeNumber.text}";

      String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\W).{9,}$';
      RegExp regExp = RegExp(pattern);
      bool isValid = regExp.hasMatch(password);

      if (fullname.isEmpty ||
          password.isEmpty ||
          rePassword.isEmpty ||
          phoneNumber.isEmpty ||
          email.isEmpty ||
          selectedProvince.toString().isEmpty ||
          selectedDistrict.toString().isEmpty ||
          homeNumber.text.isEmpty) {
        setState(() {
          announce = "Vui lòng nhập đủ thông tin";
        });
      } else if (password != rePassword) {
        setState(() {
          announce = "Mật khẩu xác nhận chưa chính xác ";
        });
      } else if (!isValid) {
        setState(() {
          announce =
              "Mật khẩu phải hơn 8 kí tự. Có in hoa, in thường, kí tự đặc biệt";
        });
      } else {
        if (!await getCoordinatesFromAddress(address)) {
          setState(() {
            announce = "Địa chỉ không chính xác";
          });
        } else {
          UserRegisterDto userDto = UserRegisterDto(
              fullname: fullname,
              password: password,
              phoneNumber: phoneNumber,
              email: email,
              latitude: latitude!,
              longTiTuDe: longitude!,
              address: address);
          authController.register(userDto).then((status) {
            if (status) {
              setState(() {
                announce = "Đăng kí thành công";
              });
            } else {
              setState(() {
                announce = Get.find<AuthController>().validateRegister;
              });
            }
          });
        }
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/LoadingBg.png'),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                width: Get.width,
                height: 100,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                        child: Center(
                      child: Text(
                        "Đăng kí",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ))
                  ],
                ),
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
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    hintText: "Số điện thoại",
                    hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: AppColor.yellowColor,
                      size: AppDimention.size25,
                    ),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: AppDimention.size15),
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
                      borderRadius: BorderRadius.circular(AppDimention.size30),
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
                  controller: fullnameController,
                  decoration: InputDecoration(
                    hintText: "Họ tên",
                    hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
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
                        borderSide:
                            const BorderSide(width: 1.0, color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimention.size30),
                        borderSide:
                            const BorderSide(width: 1.0, color: Colors.white)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimention.size30),
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
                    hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
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
                        borderSide:
                            const BorderSide(width: 1.0, color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimention.size30),
                        borderSide:
                            const BorderSide(width: 1.0, color: Colors.white)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimention.size30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppDimention.size20,
              ),
              Container(
                width: AppDimention.screenWidth,
                height: AppDimention.size50,
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
                    hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
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
                      borderSide: const BorderSide(width: 1.0, color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimention.size30),
                      borderSide: const BorderSide(width: 1.0, color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimention.size10),
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
                height: 20,
              ),
              Container(
                width: AppDimention.screenWidth,
                height: AppDimention.size50,
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
                    hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
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
                      borderSide: const BorderSide(width: 1.0, color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimention.size30),
                      borderSide: const BorderSide(width: 1.0, color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimention.size10),
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
                  controller: homeNumber,
                  decoration: InputDecoration(
                    hintText: "Số nhà , đường ...",
                    hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
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
                        borderSide:
                            const BorderSide(width: 1.0, color: Colors.white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppDimention.size30),
                        borderSide:
                            const BorderSide(width: 1.0, color: Colors.white)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppDimention.size30),
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
                  controller: passwordController,
                  obscureText: isHidden!,
                  decoration: InputDecoration(
                    hintText: "Mật khẩu",
                    hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
                    prefixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isHidden = !isHidden!;
                        });
                      },
                      child: Icon(
                        Icons.visibility_outlined,
                        color: AppColor.yellowColor,
                        size: AppDimention.size25,
                      ),
                    ),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: AppDimention.size15),
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
                      borderRadius: BorderRadius.circular(AppDimention.size30),
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
                  controller: rePasswordController,
                  obscureText: isHidden!,
                  decoration: InputDecoration(
                    hintText: "Xác nhận mật khẩu",
                    hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
                    prefixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isHidden = !isHidden!;
                        });
                      },
                      child: Icon(
                        Icons.visibility_outlined,
                        color: AppColor.yellowColor,
                        size: AppDimention.size25,
                      ),
                    ),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: AppDimention.size15),
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
                      borderRadius: BorderRadius.circular(AppDimention.size30),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppDimention.size20,
              ),
              SizedBox(
                width: AppDimention.size290,
                child: Center(
                  child: Text(
                    announce,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 202, 189),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: AppDimention.size20,
              ),
              Center(
                child: Container(
                    width: AppDimention.screenWidth / 2.6,
                    height: AppDimention.screenHeight / 16,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 255, 202, 189),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        register();
                      },
                      child: Center(
                        child: Text(
                          "Đăng kí",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: AppDimention.size20,
                          ),
                        ),
                      ),
                    )),
              ),
            ],
          )),
        ));
  }
}
