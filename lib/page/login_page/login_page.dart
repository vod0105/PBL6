
import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/page/login_page/component/login_textfield.dart';
import 'package:android_project/page/login_page/loading/loading_animation.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String announce = "";
  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  void _login() async {
    var authController = Get.find<AuthController>();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty && password.isNotEmpty) {
      setState(() {
        announce = "Vui lòng nhập số điện thoại";
      });
    } else if (password.isEmpty && username.isNotEmpty) {
      setState(() {
        announce = "Vui lòng nhập mật khẩu";
      });
    } else if (username.isEmpty && password.isEmpty) {
      setState(() {
        announce = "Vui lòng nhập đầy đủ thông tin";
      });
    } else {
      UserDto userdto = UserDto(password: password, username: username);
      authController.login(userdto).then((status) {
        if (status) {
          Get.to(const BarLoadingScreen());
        } else {
          setState(() {
            announce = Get.find<AuthController>().validateLogin;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                SizedBox(
                  width: AppDimention.screenWidth,
                  height: AppDimention.screenHeight * 0.35,
                  child: Center(
                    child: SizedBox(
                      width: AppDimention.size100 * 2.5,
                      height: (AppDimention.screenHeight * 0.4) * 0.8,
                      child: Column(
                        children: [
                          Container(
                            width:
                                (AppDimention.screenHeight * 0.4) * 0.8 * 0.65,
                            height:
                                (AppDimention.screenHeight * 0.4) * 0.8 * 0.65,
                            margin:
                                EdgeInsets.only(bottom: AppDimention.size10),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: AppDimention.size10,
                                      spreadRadius: 7,
                                      offset: const Offset(1, 10),
                                      color: Colors.red.withOpacity(0.2))
                                ],
                                borderRadius:
                                    BorderRadius.circular(AppDimention.size100),
                                image: const DecorationImage(
                                    image:
                                        AssetImage("assets/image/logo.png"))),
                          ),
                          const Text(
                            "Welcome to our",
                            style: TextStyle(
                              color: Colors.white,
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          const Text(
                            "F-FUS",
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColor.mainColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                LoginTextfield(
                  controller: usernameController,
                  title: "Số điện thoại",
                  type: 1,
                ),
                SizedBox(
                  height: AppDimention.size20,
                ),
                LoginTextfield(
                  controller: passwordController,
                  title: "Mật khẩu",
                  type: 2,
                ),
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.all(AppDimention.size20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: AppDimention.size10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoute.FORGET_PASSWORD_PAGE);
                        },
                        child: const Text("Quên mật khẩu ?",style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                ),
                if (announce != "")
                  Column(
                    children: [
                      Center(
                        child: Text(
                          announce,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: AppDimention.size10,
                      )
                    ],
                  ),
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.only(
                      left: AppDimention.size20, right: AppDimention.size20),
                  child: Center(
                      child: GestureDetector(
                    onTap: () {
                      _login();
                    },
                    child: Container(
                      width: AppDimention.size150,
                      height: AppDimention.size50,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: AppColor.mainColor),
                          borderRadius:
                              BorderRadius.circular(AppDimention.size10)),
                      child: const Center(
                        child: Text(
                          "Đăng nhập",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )),
                ),
                Container(
                  width: AppDimention.screenWidth,
                  padding: EdgeInsets.all(AppDimention.size20),
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        Container(
                          width: AppDimention.size150,
                          height: AppDimention.size50,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size10)),
                          child: const Center(
                            child: Text(
                              "Google",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: AppDimention.size150,
                          height: AppDimention.size50,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.circular(AppDimention.size10)),
                          child: const Center(
                            child: Text(
                              "Facebook",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ])),
                ),
                SizedBox(
                  width: AppDimention.screenWidth,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Bạn chưa có tài khoản ? ",style: TextStyle(color: Colors.white),),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoute.REGISTER_PAGE);
                          },
                          child: const Text(
                            "Đăng kí",
                            style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
