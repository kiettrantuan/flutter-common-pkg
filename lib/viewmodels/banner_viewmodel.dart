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
      var res =
          await _apiService.fetchBanners(page: page ?? 3, limit: limit ?? 5);
      if (res.isSuccessful && res.body != null) {
        _banners = res.body!;
      } else {
        throw res.error.toString();
      }
    } catch (e) {
      debugPrint('Error fetching banners: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
