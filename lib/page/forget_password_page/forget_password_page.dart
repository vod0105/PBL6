// ignore_for_file: library_private_types_in_public_api

import 'package:android_project/custom/input_text_custom.dart';
import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/page/register_page/register_page.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  bool isHidden = true;
  bool isValidEmail = false;
  String announce = "";
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void sendotp() {
      var authController = Get.find<AuthController>();
      String email = emailController.text.trim();
      String password = passwordController.text;
      String rePassword = rePasswordController.text;

      String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\W).{9,}$';
      RegExp regExp = RegExp(pattern);
      bool isValid = regExp.hasMatch(password);

      if (email.isEmpty || password.isEmpty || rePassword.isEmpty) {
        setState(() {
          announce = "Vui lòng nhập đủ thông tin";
        });
      } else if (!isValid) {
        setState(() {
          announce =
              "Mật khẩu phải trên 8 kí tự gồm in hoa , in thường và kí tự đặc biệt";
        });
      } else {
        authController.sendotp(email).then((status) {
          if (status) {
            setState(() {
              announce = "Mã xác nhận được gửi qua email của bạn gồm 6 số";
              isValidEmail = true;
            });
          } else {
            setState(() {
              announce = Get.find<AuthController>().validateSendotp;
              isValidEmail = false;
            });
          }
        });
      }
    }

    void verifyotp() {
      var authController = Get.find<AuthController>();
      String otp = otpController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text;
      if (otp.isEmpty) {
        announce = "Vui lòng nhập mã otp";
      } else {
        authController.verifyotp(email, otp, password).then((status) {
          if (status) {
            setState(() {
              announce = "Thay đổi mật khẩu thành công";
              otpController.text = "";
              emailController.text = "";
              passwordController.text = "";
              rePasswordController.text = "";
              isValidEmail = false;
            });
          } else {
            setState(() {
              announce = "Mã xác nhận không chính xác";
              otpController.text = "";
              isValidEmail = true;
            });
          }
        });
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // Form login
            Positioned(
              left: 10,
              right: 10,
              bottom: 10,
              top: 250,
              child: Container(
                width: Get.width,
                height: Get.height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColor.mainColor),
                    image: const DecorationImage(
                        image: AssetImage('assets/image/LoadingBg.png'),
                        fit: BoxFit.cover)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    isValidEmail
                        ? Column(
                            children: [
                              InputTextCustom(
                                controller: otpController,
                                hintText: "Otp",
                                icon: Icons.account_tree_rounded,
                              ),
                              SizedBox(
                                height: AppDimention.size10,
                              ),
                              Container(
                                width: AppDimention.screenWidth,
                                padding: EdgeInsets.only(
                                    left: AppDimention.size20,
                                    right: AppDimention.size20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        sendotp();
                                      },
                                      child: const Text("Gửi lại"),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              InputTextCustom(
                                controller: emailController,
                                hintText: "Email",
                                icon: Icons.email,
                              ),
                              SizedBox(
                                height: AppDimention.size10,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: AppDimention.size20,
                                    right: AppDimention.size20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        AppDimention.size30),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: AppDimention.size10,
                                          spreadRadius: 7,
                                          offset: const Offset(1, 10),
                                          color: Colors.grey.withOpacity(0.2))
                                    ]),
                                child: TextField(
                                  controller: passwordController,
                                  obscureText: isHidden,
                                  decoration: InputDecoration(
                                    hintText: "Mật khẩu",
                                    hintStyle: const TextStyle(color: Colors.black26),
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHidden = !isHidden;
                                        });
                                      },
                                      child: Icon(
                                        isHidden
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: AppColor.yellowColor,
                                      ),
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
                              SizedBox(
                                height: AppDimention.size10,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: AppDimention.size20,
                                    right: AppDimention.size20),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        AppDimention.size30),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: AppDimention.size10,
                                          spreadRadius: 7,
                                          offset: const Offset(1, 10),
                                          color: Colors.grey.withOpacity(0.2))
                                    ]),
                                child: TextField(
                                  controller: rePasswordController,
                                  obscureText: isHidden,
                                  decoration: InputDecoration(
                                    hintText: "Xác nhận mật khẩu",
                                    hintStyle: const TextStyle(color: Colors.black26),
                                    prefixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isHidden = !isHidden;
                                        });
                                      },
                                      child: Icon(
                                        isHidden
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: AppColor.yellowColor,
                                      ),
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
                    SizedBox(
                      height: AppDimention.size40,
                    ),
                    Container(
                      width: AppDimention.screenWidth,
                      padding: EdgeInsets.only(
                          left: AppDimention.size20,
                          right: AppDimention.size20),
                      child: Center(
                        child: Text(
                          announce,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: AppDimention.size10,
                    ),
                    if (!isValidEmail)
                      Center(
                          child: GestureDetector(
                        onTap: () {
                          sendotp();
                        },
                        child: Container(
                          width: AppDimention.screenWidth / 2,
                          height: AppDimention.screenHeight / 14,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: AppColor.mainColor),
                          child: Center(
                            child: Text(
                              "Nhận mã",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppDimention.size20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ))
                    else
                      Center(
                          child: GestureDetector(
                        onTap: () {
                          verifyotp();
                        },
                        child: Container(
                          width: AppDimention.screenWidth / 2,
                          height: AppDimention.screenHeight / 14,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: AppColor.mainColor),
                          child: Center(
                            child: Text(
                              "Xác nhận",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppDimention.size20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )),
                    SizedBox(
                      height: AppDimention.size40,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Bạn chưa có tài khoản ?",
                          style: const TextStyle(color: Colors.white, fontSize: 15),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(() => const RegisterPage(),
                                    transition: Transition.fade),
                              text: " Đăng kí",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: AppDimention.size10,
                    ),
                    Center(
                        child: SizedBox(
                      width: AppDimention.screenWidth / 2,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.snackbar(
                                  "Thông báo",
                                  "Tính năng đang phát triển",
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.white,
                                  colorText: Colors.black,
                                  icon: const Icon(Icons.card_giftcard_sharp,
                                      color: Color.fromARGB(255, 168, 175, 76)),
                                  borderRadius: 10,
                                  margin: const EdgeInsets.all(10),
                                  duration: const Duration(milliseconds: 800),
                                  isDismissible: true,
                                );
                              },
                              child: Icon(
                                Icons.facebook,
                                color: Colors.blue,
                                size: AppDimention.size40,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.snackbar(
                                  "Thông báo",
                                  "Tính năng đang phát triển",
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.white,
                                  colorText: Colors.black,
                                  icon: const Icon(Icons.card_giftcard_sharp,
                                      color: Color.fromARGB(255, 168, 175, 76)),
                                  borderRadius: 10,
                                  margin: const EdgeInsets.all(10),
                                  duration: const Duration(milliseconds: 800),
                                  isDismissible: true,
                                );
                              },
                              child: Icon(
                                Icons.email,
                                color: Colors.white,
                                size: AppDimention.size40,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.snackbar(
                                  "Thông báo",
                                  "Tính năng đang phát triển",
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.white,
                                  colorText: Colors.black,
                                  icon: const Icon(Icons.card_giftcard_sharp,
                                      color: Color.fromARGB(255, 168, 175, 76)),
                                  borderRadius: 10,
                                  margin: const EdgeInsets.all(10),
                                  duration: const Duration(milliseconds: 800),
                                  isDismissible: true,
                                );
                              },
                              child: Icon(
                                Icons.phone,
                                color: Colors.yellow,
                                size: AppDimention.size40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
            // LOGO
            Positioned(
              top: AppDimention.size30,
              left: AppDimention.size110,
              width: AppDimention.size170,
              height: AppDimention.size170,
              child: ClipOval(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 5, color: AppColor.mainColor),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/image/logo.png"),
                      )),
                ),
              ),
            )
          ],
        ));
  }
}
