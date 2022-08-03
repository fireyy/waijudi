import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:waijudi/pages/settings/controller.dart';
import 'package:waijudi/util/colors.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.LIGHT,
          appBar: CustomAppBar(
            title: Text('设置', style: TextStyle(color: AppColors.DARK),),
            autoLeading: true,
            actions: [
              TextButton(
                onPressed: () => controller.onSave(),
                child: Text(
                  '保存',
                  style: TextStyle(color: AppColors.DARK),
                )
              ),
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text('${controller.appName} Ver: ${controller.version}(${controller.buildNumber})', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    ),
                    const SizedBox(height: 16,),
                    const Text('选择API地址:'),
                    RadioListTile<String>(
                      title: const Text('https://api.mdwifi.com:778'),
                      value: 'https://api.mdwifi.com:778',
                      groupValue: controller.currentApiUrl,
                      onChanged: (String? value) {
                        controller.setCurrentApiUrl(value);
                      },
                    ),
                    ...(
                      controller.apiUrl.map(
                        (url) => RadioListTile<String>(
                          title: Text(url),
                          value: url,
                          groupValue: controller.currentApiUrl,
                          onChanged: (String? value) {
                            controller.setCurrentApiUrl(value);
                          },
                        )
                      )
                    ),
                  ],
                );
              }
            ),
          ),
        );
      }
    );
  }
}