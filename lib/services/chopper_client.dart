import 'package:chopper/chopper.dart';
import 'package:f_common_package_1/services/auth_service.dart';
import 'package:f_common_package_1/services/banner_service.dart';

class ChopperClientInstance {
  static ChopperClient? client;

  static void initializeChopperClient() {
    client ??= ChopperClient(
      baseUrl: Uri(scheme: 'https', host: 'dummyjson.com'),
      services: [BannerService.create(), AuthService.create()],
      converter: const JsonConverter(),
    );
  }
}
