import 'package:f_common_package_1/models/banner.dart';
import 'package:f_common_package_1/services/banner_service.dart';
import 'package:flutter/foundation.dart';

class BannerViewModel extends ChangeNotifier {
  final BannerService _apiService;
  List<Banner> _banners = [];
  bool _isLoading = false;
  bool _disposed = false;

  bool get isLoading => _isLoading;

  List<Banner> get banners => _banners;

  bool get disposed => _disposed;

  BannerViewModel({required BannerService apiService})
      : _apiService = apiService {
    fetchBanners();
  }

  Future<void> fetchBanners({int? page, int? limit}) async {
    _isLoading = true;
    notifyListeners();

    try {
      var res = await _apiService.fetchBanners(page: page, limit: limit);
      if (res.isSuccessful) {
        _banners = _parseBanners(res.body) ?? _banners;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching banners: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Banner>? _parseBanners(List<dynamic>? body) {
    return body
        ?.map((json) => Banner.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  @override
  void notifyListeners() {
    if (!disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
