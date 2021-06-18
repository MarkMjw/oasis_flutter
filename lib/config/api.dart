class Api {
  static const String HOST = 'http://i.oasis-test.chengdu.weibo.cn/v1';
  static const String HOST_RELEASE = 'https://oasis.api.weibo.cn/v1';
  static const String COMMON_PARAM =
      'debug=true&ua=HUAWEI-LIO-AL00__oasis__3.6.5__Android__Android10&wm=3333_1001&aid=01A4Qh-CS3ICCB2mhRZsW1PAxJgmeoiOSL9ZJrwJa8EnhpacA.&vid=2000534460082&cuid=1823115863&sign=7470dc2970bc5eb34de3ae672b905b7f&timestamp=1623401753910&cfrom=28B6395010&version=3.6.5&is_recommend_channel=false&noncestr=5Maj2Cv0T7H03a1FW74012b2L9942H&platform=ANDROID';

  static const Map<String, String> COMMON_HEADER = {
    "gsid": "O1dGmriqebHVuxbd6uJCMS5AbuPtmezAlQJktRL3cFJvY8hh5aVfcF1lLTL20uOmSKP3/ifRf9bSAlkUWLGPlcVRUnP52P6H6KuAq0qUEt0kB4r4zrIa2+XKJEKCzluH",
    "User-Agent": "HUAWEI-LIO-AL00__oasis__3.6.5__Android__Android10"
  };
}
