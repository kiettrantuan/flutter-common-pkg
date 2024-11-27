import 'package:chopper/chopper.dart';
import 'package:f_common_package_1/services/chopper_client.dart';

part 'banner_service.chopper.dart';

@ChopperApi(baseUrl: 'https://picsum.photos')
abstract class BannerService extends ChopperService {
  static BannerService create([ChopperClient? client]) =>
      _$BannerService(client);

  @Get(path: "/v2/list")
  Future<Response<List>> fetchBanners({
    @Query('page') int? page = 3,
    @Query('limit') int? limit = 5,
  });
}
