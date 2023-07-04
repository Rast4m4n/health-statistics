abstract class ConfigApi {
  // URL
  // ip 10.0.2.2 для андроид эмулятора
  // static const _baseUri = 'http://10.0.2.2:8000';
  static const _baseUri = 'http://192.168.1.65:8000';
  static const healthUri = '$_baseUri/api/health/';
  static const userUri = '$_baseUri/api/users/';

  // headers
  static const headersJson = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
}
