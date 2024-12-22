import 'package:flutter/material.dart';
import 'package:taptap/home_scree/widgets/theme_changer.dart';
import 'package:get/get.dart';

import '../../theme/theme_controller.dart';
class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(onPressed: (){}, child: Text('Chat')),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child:
                      Obx((){
                        return
                          MultipleChoice(currentTheme: Get.find<ThemeCOntroller>().isLightTheme.value,
                            onChange: (theme ) {
                              print(theme);
                              if (theme) {
                                Get.find<ThemeCOntroller>().changeTheme(true);
                              } else {
                                Get.find<ThemeCOntroller>().changeTheme(false);
                              }
                            },);
                      }),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
