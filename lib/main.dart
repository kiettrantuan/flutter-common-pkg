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

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ChopperClientInstance.initializeChopperClient();
  await SharedPreferencesService.init();

  /// Must initializeApp before any Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // TODO: Apple requires dev-account
  if (Platform.isAndroid) {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');
    final fcmToken = await messaging.getToken();
    debugPrint(fcmToken);
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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
