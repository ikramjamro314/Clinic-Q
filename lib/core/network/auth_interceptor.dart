import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var session = Supabase.instance.client.auth.currentSession;

    // Auto-refresh expired session if a user is logged in
    if (session != null && session.isExpired) {
      debugPrint('[AuthInterceptor] Session is expired. Attempting refresh...');
      try {
        final response = await Supabase.instance.client.auth.refreshSession();
        session = response.session;
      } catch (e) {
        debugPrint('[AuthInterceptor] Session refresh failed: $e');
      }
    }

    if (session != null) {
      final token = session.accessToken;
      options.headers['Authorization'] = 'Bearer $token';
      debugPrint('[AuthInterceptor] Authorization header added.');
    } else {
      debugPrint('[AuthInterceptor] WARNING: No active session found.');
    }

    super.onRequest(options, handler);
  }
}
