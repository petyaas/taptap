import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:taptap/theme/theme.dart';
import 'package:get/get.dart';
import 'package:taptap/theme/theme_controller.dart';
import 'home_scree/view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).viewPadding;
    final themeController = Get.put(ThemeCOntroller());

  return  Obx((){
  return GetMaterialApp(
    title: 'tapapp',

    theme: ThemeData(
      colorScheme: MaterialTheme.lightScheme(),
      useMaterial3: true,
    ),
    darkTheme: ThemeData(
      colorScheme: MaterialTheme.darkScheme(),
      useMaterial3: true,
    ),
    themeMode: themeController.isLightTheme.value?ThemeMode.light:ThemeMode.dark,

    // theme: MaterialTheme.l
    home: HomeScreen(),
  );

});
  }
}
