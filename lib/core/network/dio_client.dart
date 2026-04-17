import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

class DioClient {
  late final Dio _dio;
  late final PersistCookieJar _cookieJar;
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    final server = dotenv.env['SERVER'];
    if (server == null || server.isEmpty) {
      throw Exception('Server в .env отсутствует');
    }
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://$server',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    await _initCookieJar();
    _initialized = true;
  }

  Future<void> _initCookieJar() async {
    final dir = await getApplicationDocumentsDirectory();
    _cookieJar = PersistCookieJar(
      storage: FileStorage(dir.path + '/.cookies/'),
      ignoreExpires: true,
    );
    _dio.interceptors.add(CookieManager(_cookieJar));

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (msg) => print('🌐 DIO: $msg'),
      ),
    );
  }

  Dio get dio => _dio;

  Future<String?> getToken() async {
    final cookies = await _cookieJar.loadForRequest(
      Uri.parse(_dio.options.baseUrl),
    );
    final tokenCookie = cookies.firstWhere(
      (c) => c.name == 'user_token',
      orElse: () => Cookie('', ''),
    );
    return tokenCookie.value.isEmpty ? null : tokenCookie.value;
  }

  Future<void> clearCookies() async {
    await _cookieJar.deleteAll();
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
