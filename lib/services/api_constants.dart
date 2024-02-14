import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get apiKey => dotenv.env['API_KEY'] ?? 'default_api_key';
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'default_base_url';
}
