import 'package:ausales_application/controller/auth/login_controller.dart';
import 'package:ausales_application/core/constants/image_constant.dart';
import 'package:ausales_application/responsive.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_label.dart';
import 'package:ausales_application/view/widgets/form_widgets/custom_text_input.dart';
import 'package:ausales_application/view/widgets/form_widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String _aupayurl = 'https://srjewellery.aupay.auss.co/';

  void _aupayURL() async {
    final Uri uri = Uri.parse(_aupayurl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $_aupayurl';
    }
  }

  final LoginController _loginController = Get.put(LoginController());

  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(ImagesConstant.imgLogoBlack),
                width: 200.w,
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                width: Responsive.isDesktop(context) ? 375.w : 300.w,
                padding: Responsive.isDesktop(context)
                    ? EdgeInsets.all(35.w)
                    : EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Enter your login details",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Form(
                      key: _loginFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomLabel(label: "Username"),
                          SizedBox(
                            height: 5.h,
                          ),
                          CustomTextInput(
                            controller: _loginController.usernameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            validator: "username",
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          CustomLabel(label: "Password"),
                          SizedBox(
                            height: 5.h,
                          ),
                          Obx(() => CustomTextInput(
                                hideText:
                                    _loginController.isPasswordVisible.value,
                                controller: _loginController.passwordController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                validator: "password",
                                suffixIcon:
                                    _loginController.isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                hasSuffixIcon: true,
                                suffixClicked: () {
                                  _loginController.isPasswordVisible(
                                      !_loginController
                                          .isPasswordVisible.value);
                                },
                              )),
                          SizedBox(
                            height: 25.h,
                          ),
                          Obx(() => PrimaryButton(
                              isLoading: _loginController.isLoading.value,
                              text: "Login",
                              onPressed: () {
                                if (_loginFormKey.currentState!.validate()) {
                                  _loginController.submitLogin(context);
                                }
                              }))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // First InkWell
                    InkWell(
                      onTap:_aupayURL,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image(
                              image: AssetImage(ImagesConstant.imgLogoAurum),
                              width: 50.w,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                'AURUM',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
