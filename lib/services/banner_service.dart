import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:f_common_package_1/models/banner.dart';
import 'package:f_common_package_1/services/banner_converter.dart';

part 'banner_service.chopper.dart';

@ChopperApi(baseUrl: 'https://picsum.photos')
abstract class BannerService extends ChopperService {
  static BannerService create([ChopperClient? client]) =>
      _$BannerService(client);

  @Get(path: "/v2/list")
  @FactoryConverter(response: _bannerListResponseConverter)
  Future<Response<List<Banner>>> fetchBanners({
    @Query('page') int page = 3,
    @Query('limit') int limit = 5,
  });

  static FutureOr<Response<List<Banner>>> _bannerListResponseConverter(
      Response response) {
    if (response.isSuccessful) {
      return response.copyWith(
        body: BannerListConverter()
            .fromJson(jsonDecode(response.body) as List<dynamic>),
      );
    }
    return response.copyWith();
  }
}

// class BannerConverter
//     extends JsonConverter<List<Banner>, List<Map<String, dynamic>>> {
//   @override
//   List<Banner> fromJson(List<Map<String, dynamic>> json) =>
//       json.map((bannerMap) => Banner.fromJson(bannerMap)).toList();
//
//   @override
//   List<Map<String, dynamic>> toJson(List<Banner> object) =>
//       object.map((banner) => banner.toJson()).toList();
// }
