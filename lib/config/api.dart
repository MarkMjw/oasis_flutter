import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'request_interceptor.dart';

final Dio dio = Dio()
  ..options.baseUrl = RequestInterceptor.host
  ..interceptors.add(RequestInterceptor())
  ..interceptors.add(LogInterceptor(request: true, requestHeader: true, requestBody: false, responseBody: false, responseHeader: true, error: true))
  ..httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () {
      final client = HttpClient();
      // client.findProxy = (uri) {
      //   // Proxy all request to localhost:8888.
      //   // Be aware, the proxy should went through you running device,
      //   // not the host platform.
      //   return 'PROXY 192.168.50.41:8888';
      // };
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    },
  );
