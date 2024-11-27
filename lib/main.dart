import 'package:f_common_package_1/services/banner_service.dart';
import 'package:f_common_package_1/services/chopper_client.dart';
import 'package:f_common_package_1/viewmodels/banner_viewmodel.dart';
import 'package:f_common_package_1/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ChopperClientInstance.initializeChopperClient();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BannerViewModel(
          apiService: BannerService.create(ChopperClientInstance.client)),
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
