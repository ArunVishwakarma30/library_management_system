import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_system/constants/constants.dart';
import 'package:library_management_system/controllers/auth_provider.dart';
import 'package:library_management_system/models/req_models/signup_req_model.dart';
import 'package:library_management_system/views/common/app_style.dart';
import 'package:library_management_system/views/common/customTextField.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController psidController;
  final formKey = GlobalKey<FormState>();
  bool isLibrarian = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    psidController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    psidController.dispose();
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
                  child: ListView(shrinkWrap: true, children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.2, horizontal: width * 0.1),
                      color: const Color.fromRGBO(0, 0, 0, 0.5),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              "Register",
                              style:
                                  roundFont(30, darkHeading, FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
                            controller: nameController,
                            prefixIcon: Icon(
                              Icons.person,
                              color: lightBlue,
                            ),
                            label: "Full Name",
                            keyType: TextInputType.name,
                            textSce: false,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter Your Full Name';
                              }

                              // Splitting the entered value in to words
                              List<String> nameParts = value.trim().split(' ');
                              if (nameParts.length < 2) {
                                return 'Please enter both First Name and Last Name';
                              }

                              return null; // Validation passed
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomTextField(
                            prefixIcon: Icon(
                              Icons.email,
                              color: lightBlue,
                            ),
                            controller: emailController,
                            label: "Email",
                            keyType: TextInputType.emailAddress,
                            textSce: false,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address';
                              }
                              // Regular expression to validate email format
                              final emailRegex = RegExp(regEx);
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
                            controller: passwordController,
                            prefixIcon: Icon(
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
                            label: "Password",
                            keyType: TextInputType.text,
                            textSce: authProvider.secure,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter password';
                              }
                              if (value.length < 6) {
                                return "Password must contain more then 6 characters";
                              }

                              return null; // Validation passed
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          !kIsWeb
                              ? CustomTextField(
                                  controller: psidController,
                                  prefixIcon: Icon(
                                    Icons.star_border,
                                    color: lightBlue,
                                  ),
                                  label: "PSID",
                                  keyType: TextInputType.number,
                                  textSce: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter PSID';
                                    }
                                    if ((value.length < 8) ||
                                        (value.length > 8)) {
                                      return "PSID should contain 8 numbers";
                                    }

                                    return null; // Validation passed
                                  },
                                )
                              : const SizedBox.shrink(),
                          !kIsWeb
                              ? const SizedBox(
                                  height: 40,
                                )
                              : const SizedBox.shrink(),
                          // Checkbox for librarian
                          kIsWeb
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: lightBlue,
                                      child: Checkbox(
                                        checkColor: lightBlue,
                                        value: isLibrarian,
                                        onChanged: (value) {
                                          setState(() {
                                            isLibrarian = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Are you a librarian?',
                                      style: roundFont(
                                          20, lightBlue, FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 350,
                                    )
                                  ],
                                )
                              : const SizedBox.shrink(),
                          kIsWeb
                              ? const SizedBox(
                                  height: 30,
                                )
                              : const SizedBox.shrink(),
                          ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (focusScope.hasFocus) {
                                    focusScope.unfocus();
                                  }
                                  int psid = kIsWeb ? 0000 : int.parse(psidController.text.toString());
                                  authProvider.setWaiting(true);
                                  int spaceIndex = nameController.text
                                      .toString()
                                      .indexOf(' ');
                                  String firstName = nameController.text
                                      .toString()
                                      .substring(0, spaceIndex);
                                  String lastName = nameController.text
                                      .toString()
                                      .substring(spaceIndex + 1);
                                  SignUpReqModel model = SignUpReqModel(
                                      firstName: firstName,
                                      lastName: lastName,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      isLibrarian: isLibrarian,
                                      psid: psid);
                                  authProvider.signUp(model);
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
                                  "Register",
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
                              Text("Already and user? ",
                                  style: roundFont(17, Color(darkHeading.value),
                                      FontWeight.w600)),
                              InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Text("Login",
                                      style: roundFont(
                                              16,
                                              Color(lightBlue.value),
                                              FontWeight.bold)
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline)))
                            ],
                          ),
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
