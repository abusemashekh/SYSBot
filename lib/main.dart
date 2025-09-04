import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sysbot3/provider/bottom_nav_bar_provider.dart';
import 'package:sysbot3/provider/chatProvider.dart';
import 'package:sysbot3/provider/onboard_provider.dart';
import 'package:sysbot3/provider/upgrade_provider.dart';
import 'package:sysbot3/screens/main_screens/road_map.dart';
import 'package:sysbot3/screens/onboarding/onboarding1.dart';
import 'package:sysbot3/screens/onboarding/splash_screen.dart';

import 'backend/local_storage/local_storage.dart';
import 'backend/payment/payment_constant.dart';
import 'config/colors.dart';
import 'dummy_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await LocalStorage.initialize();

  // await dotenv.load(fileName: "api.env");
  AnimationPrecache.precacheAnimation('assets/animations/car.riv');

  await initPlatformState();

  await checkIsUserUpgraded();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => OnboardProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (_) => UpgradeProvider()),
      ],
      child: GetMaterialApp(
        title: 'SYS Bot',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.black,
            useMaterial3: true,
            fontFamily: 'ReservationWide'),
        // home: DummyScreen(),
        home: SplashScreen(),
      ),
    );
  }
}
