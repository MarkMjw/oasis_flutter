import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class Api {
  static const String HOST = 'http://i.oasis-test.chengdu.weibo.cn/v1';
  static const String COMMON_PARAM = 'cuid=1823115863'
      '&version=3.6.5'
      '&debug=true'
      '&platform=ANDROID';

  static const Map<String, String> COMMON_HEADER = {
    "gsid": "O1dGmriqebHVuxbd6uJCMS5AbuPtmezAlQJktRL3cFJvY8hh5aVfcF1lLTL20uOmSKP3/ifRf9bSAlkUWLGPlcVRUnP52P6H6KuAq0qUEt0kB4r4zrIa2+XKJEKCzluH",
    "User-Agent": "HUAWEI-LIO-AL00__oasis__3.6.5__Android__Android10"
  };
}

final Dio dio = Dio()
  ..options.headers = Api.COMMON_HEADER
  ..httpClientAdapter = IOHttpClientAdapter(
    createHttpClient: () {
      final client = HttpClient();
      client.findProxy = (uri) {
        // Proxy all request to localhost:8888.
        // Be aware, the proxy should went through you running device,
        // not the host platform.
        return 'PROXY 192.168.50.41:9091';
      };
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    },
  );
