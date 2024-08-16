class ApiConfig {
  static const String baseUrl = 'http://192.168.1.111:8000/api';

  static String get loginUrl => '$baseUrl/login';
  static String get meUrl => '$baseUrl/me';
}
