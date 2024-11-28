import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:f_common_package_1/models/user.dart';

part 'auth_service.chopper.dart';

@ChopperApi(baseUrl: 'auth')
abstract class AuthService extends ChopperService {
  static AuthService create([ChopperClient? client]) => _$AuthService(client);

  @Post(path: "login")
  @FactoryConverter(response: _loginResponseConverter)
  Future<Response<User>> login({
    @Body() required Map<String, dynamic> body,
    @Header("Content-Type") String contentType = "application/json",
  });

  static FutureOr<Response<User>> _loginResponseConverter(Response response) {
    if (response.isSuccessful) {
      return response.copyWith(
        body: User.fromJson(jsonDecode(response.body) as Map<String, dynamic>),
      );
    }
    return response.copyWith();
  }
}
