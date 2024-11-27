// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$BannerService extends BannerService {
  _$BannerService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = BannerService;

  @override
  Future<Response<List<Banner>>> fetchBanners({
    int page = 3,
    int limit = 5,
  }) {
    final Uri $url = Uri.parse('https://picsum.photos/v2/list');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<Banner>, Banner>(
      $request,
      responseConverter: BannerService._bannerListResponseConverter,
    );
  }
}
