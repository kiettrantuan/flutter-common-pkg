import 'package:f_common_package_1/models/user.dart';
import 'package:f_common_package_1/services/auth_service.dart';
import 'package:f_common_package_1/services/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _apiService;
  User? _user;
  bool _isLoading = false;
  bool _disposed = false;

  User? get user => _user;

  bool get isLoading => _isLoading;

  bool get disposed => _disposed;

  AuthViewModel({required AuthService apiService}) : _apiService = apiService {
    getUser();
  }

  Future<void> getUser({int? page, int? limit}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = SharedPreferencesService.getModel<User>(
          SharedPreferencesKeys.userInfo, (json) => User.fromJson(json));
      _user = user;
    } catch (e) {
      debugPrint('Error getting user: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.login(
        body: {
          'username': 'emilys',
          'password': 'emilyspass',
          // 'expiresInMins': 5,
        },
      );

      if (response.isSuccessful && response.body != null) {
        await SharedPreferencesService.saveModel(
            SharedPreferencesKeys.userInfo, response.body!);
        _user = response.body;
        debugPrint("Login successful: ${response.body}");
      } else {
        await SharedPreferencesService.remove(SharedPreferencesKeys.userInfo);
        debugPrint("Login failed: ${response.statusCode} ${response.error}");
      }
    } catch (e) {
      debugPrint('Error login: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      final isSuccess =
          await SharedPreferencesService.remove(SharedPreferencesKeys.userInfo);

      if (isSuccess) {
        _user = null;
        debugPrint("Logout successful !");
      } else {
        debugPrint("Logout failed !");
      }
    } catch (e) {
      debugPrint('Error logout: $e');
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
