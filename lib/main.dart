import 'dart:io';

import 'package:f_common_package_1/firebase_options.dart';
import 'package:f_common_package_1/services/auth_service.dart';
import 'package:f_common_package_1/services/banner_service.dart';
import 'package:f_common_package_1/services/chopper_client.dart';
import 'package:f_common_package_1/services/shared_preferences.dart';
import 'package:f_common_package_1/viewmodels/auth_viewmodel.dart';
import 'package:f_common_package_1/viewmodels/banner_viewmodel.dart';
import 'package:f_common_package_1/views/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ChopperClientInstance.initializeChopperClient();
  await SharedPreferencesService.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (Platform.isAndroid) {
    await FirebaseMessaging.instance.requestPermission(provisional: true);
    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint(fcmToken);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => BannerViewModel(
                apiService:
                    BannerService.create(ChopperClientInstance.client))),
        ChangeNotifierProvider(
            create: (_) => AuthViewModel(
                apiService: AuthService.create(ChopperClientInstance.client))),
      ],
      child: MaterialApp(
        title: 'Flutter Common Packages',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
