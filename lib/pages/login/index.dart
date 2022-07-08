import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/login/controller.dart';
import 'package:waijudi/widgets/organic_button.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:waijudi/widgets/appbar_action.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomAppBar(
            actions: [
              CustomAppBarAction(
                () => Get.back(),
                Icons.close,
              ),
            ]
          ),
          body: Center(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              onChanged: () {
                Form.of(primaryFocus!.context!)!.save();
              },
              child: Wrap(
                direction: Axis.vertical,
                spacing: 16,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone_android),
                        labelText: 'Mobile *',
                      ),
                      onSaved: (String? value) {
                        if (value != null) controller.mobile = value;
                      },
                      validator: (String? value) {
                        return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                      },
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: Obx(
                      () => TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !controller.passwordVisible,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.password),
                          labelText: 'Password *',
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
                        onSaved: (String? value) {
                          if (value != null) controller.password = value;
                        },
                        validator: (String? value) {
                          return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                        },
                      )
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 50)),
                    child: OrganicButton(
                      () => controller.login(),
                      'Login',
                      Icons.check,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}