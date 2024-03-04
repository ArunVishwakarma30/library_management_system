import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_system/constants/constants.dart';
import 'package:library_management_system/controllers/auth_provider.dart';
import 'package:library_management_system/models/req_models/login_req_model.dart';
import 'package:library_management_system/views/auth_screens/register_page.dart';
import 'package:library_management_system/views/common/app_style.dart';
import 'package:library_management_system/views/common/customTextField.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController passwordController;
  late TextEditingController emailController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var focusScope = FocusScope.of(context);
    return SafeArea(
      child: GestureDetector(onTap: () {
        if (focusScope.hasFocus) {
          focusScope.unfocus();
        }
      }, child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset("assets/images/auth_screen_bg.jpg",
                    fit: BoxFit.cover),
                Form(
                  key: formKey,
                  child: ListView(children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.2, horizontal: width * 0.1),
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Login",
                              style:
                                  roundFont(30, darkHeading, FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
                            prefixIcon: const Icon(
                              Icons.email,
                              color: lightBlue,
                            ),
                            controller: emailController,
                            label: "Email",
                            keyType: TextInputType.emailAddress,
                            textSce: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address!';
                              }
                              // Regular expression to validate email format
                              final emailRegex = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                              if (!emailRegex.hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null; // Validation passed
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: lightBlue,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  authProvider.setSecure();
                                },
                                child: Icon(
                                  authProvider.secure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: lightBlue,
                                ),
                              ),
                              controller: passwordController,
                              label: "Password",
                              keyType: TextInputType.text,
                              textSce: authProvider.secure,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Password';
                                }
                                return null; // Validation passed
                              }),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (focusScope.hasFocus) {
                                    focusScope.unfocus();
                                  }
                                  authProvider.setWaiting(true);
                                  LogInReqModel model = LogInReqModel(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  authProvider.login(model);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: darkHeading,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                              ),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Login",
                                  style: roundFont(
                                      25, Colors.white, FontWeight.bold),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have and account? ",
                                  style: roundFont(17, Color(darkHeading.value),
                                      FontWeight.w600)),
                              InkWell(
                                  onTap: () {
                                    Get.to(() => const RegisterPage(),
                                        transition: Transition.fadeIn);
                                  },
                                  child: Text("Sign Up",
                                      style: roundFont(
                                              16,
                                              Color(lightBlue.value),
                                              FontWeight.bold)
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline)))
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
