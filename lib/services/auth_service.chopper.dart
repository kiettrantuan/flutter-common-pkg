// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AuthService extends AuthService {
  _$AuthService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AuthService;

  @override
  Future<Response<User>> login({
    required Map<String, dynamic> body,
    String contentType = "application/json",
  }) {
    final Uri $url = Uri.parse('auth/login');
    final Map<String, String> $headers = {
      'Content-Type': contentType,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
    );
    return client.send<User, User>(
      $request,
      responseConverter: AuthService._loginResponseConverter,
    );
  }
}
