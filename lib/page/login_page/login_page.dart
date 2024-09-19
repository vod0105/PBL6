import 'package:android_project/custom/clippath_customer.dart';
import 'package:android_project/custom/input_text_custom.dart';
import 'package:android_project/data/controller/Auth_controller.dart';
import 'package:android_project/models/Dto/UserDto.dart';
import 'package:android_project/page/forget_password_page/forget_password_page.dart';
import 'package:android_project/page/register_page/register_page.dart';
import 'package:android_project/route/app_route.dart';
import 'package:android_project/theme/app_color.dart';
import 'package:android_project/theme/app_dimention.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void _login() {
      var auth_controller = Get.find<AuthController>();
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();

/*
        if(username.isEmpty){
            Get.snackbar("Username", "Type in your username");
        }else if(password.isEmpty){
          Get.snackbar("Password", "Type in your password");
        }else{
          Userdto userdto =  Userdto(password: "123456789",username: "0763764915");
          auth_controller.login(userdto).then((status){
              if(status){
                  Get.toNamed(AppRoute.HOME_PAGE);
              }else{
                Get.snackbar("Error", status.toString());
              }
          });
        }*/
      Userdto userdto = Userdto(password: "123456789", username: "0763764915");
      auth_controller.login(userdto).then((status) {
        if (status) {
          Get.toNamed(AppRoute.HOME_PAGE);
        } else {
          Get.snackbar("Error", status.toString());
        }
      });
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // Background blue
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: AppDimention.size320,
              child: ClipPath(
                clipper: ClippathCustomer(
                  svgPath:
                      "M1.97342e-05 -24.75H391.904C391.904 -24.75 451.205 218.765 383.748 152.224C316.292 85.6825 6.41361e-05 470.483 1.97342e-05 152.224C-2.46677e-05 -166.036 1.97342e-05 -24.75 1.97342e-05 -24.75Z",
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                  ),
                ),
              ),
            ),
            // Background blue
            Positioned(
              bottom: 0,
              left: 0,
              right: -1,
              height: AppDimention.size320,
              child: ClipPath(
                clipper: ClippathCustomer(
                  svgPath:
                      "M0 75.0047C197.38 292.88 367.66 -173.226 407 75.0047V320H0V75.0047Z",
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                  ),
                ),
              ),
            ),
            // Form login
            Positioned(
              left: AppDimention.size40,
              top: AppDimention.size110,
              width: AppDimention.size310,
              height: AppDimention.size630,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: AppColor.mainColor),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppDimention.size170,
                    ),
                    InputTextCustom(
                      controller: usernameController,
                      hinttext: "Username",
                      icon: Icons.people,
                    ),
                    SizedBox(
                      height: AppDimention.size30,
                    ),
                    InputTextCustom(
                      controller: passwordController,
                      hinttext: "Password",
                      icon: Icons.password_sharp,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        RichText(
                            text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => ForgetPasswordPage(),
                                transition: Transition.fade),
                          text: "Forget your password ?",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 15),
                        )),
                        SizedBox(
                          width: AppDimention.size20,
                        )
                      ],
                    ),
                    SizedBox(
                      height: AppDimention.size40,
                    ),
                    Center(
                      child: Container(
                          width: AppDimention.screenWidth / 2,
                          height: AppDimention.screenHeight / 14,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              color: AppColor.mainColor),
                          child: GestureDetector(
                            onTap: () {
                              _login();
                            },
                            child: Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: AppDimention.size30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: AppDimention.size80,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "Don't you have account ?",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 15),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.to(() => RegisterPage(),
                                    transition: Transition.fade),
                              text: "Create",
                              style: TextStyle(fontSize: 15),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: AppDimention.size20,
                    ),
                    Center(
                        child: Container(
                      width: AppDimention.screenWidth / 2,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.facebook,
                              color: AppColor.mainColor,
                              size: AppDimention.size40,
                            ),
                            Icon(
                              Icons.email,
                              color: AppColor.mainColor,
                              size: AppDimention.size40,
                            ),
                            Icon(
                              Icons.phone,
                              color: AppColor.mainColor,
                              size: AppDimention.size40,
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
              child: Container(
                child: ClipOval(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 5, color: AppColor.mainColor),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/image/logo.png"),
                        )),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
