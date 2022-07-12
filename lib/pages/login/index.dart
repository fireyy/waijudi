import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/login/controller.dart';
import 'package:waijudi/util/colors.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //   image: AssetImage('Assets/image1.png'),
                  //   fit: BoxFit.fitWidth,
                  //   alignment: Alignment.topCenter
                  // )
                  color: Colors.black,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 270),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(23),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.always,
                    onChanged: () {
                      _formKey.currentState!.save();
                    },
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Container(
                            color: const Color(0xfff5f5f5),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              onSaved: (String? value) {
                                if (value != null) controller.mobile = value;
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter mobile number';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                                prefixIcon: Icon(Icons.person_outline),
                                labelStyle: TextStyle(
                                  fontSize: 15
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xfff5f5f5),
                          child: Obx(
                            () {
                              return TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !controller.passwordVisible,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                onSaved: (String? value) {
                                  if (value != null) controller.password = value;
                                },
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  labelStyle: const TextStyle(
                                    fontSize: 15
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      controller.passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                      color: Theme.of(context).primaryColorDark,
                                      ),
                                    onPressed: () => controller.passwordVisible = !controller.passwordVisible,
                                  ),
                                ),
                              );
                            }
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (_formKey.currentState!.validate() && !controller.isLoading.value) {
                                controller.login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.LIGHT_GREEN,
                              elevation: 0,
                              minimumSize: const Size(400, 50),
                            ),
                            icon: controller.isLoading.value
                              ? Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(2.0),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Icon(Icons.feedback),
                            label: const Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 0,
                child: IconButton(
                  color: AppColors.LIGHT,
                  icon: Icon(Icons.close, color: AppColors.LIGHT,),
                  onPressed: () => Get.back(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}