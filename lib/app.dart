import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:test_flutter/utils/constants/text_strings.dart';
import 'package:test_flutter/utils/theme/theme.dart';
import 'package:test_flutter/features/authentication/screens/onBoarding/onboarding.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
     // initialBinding: GeneralBindings(),
      home: const OnboardingScreen()
    );
  }
}
