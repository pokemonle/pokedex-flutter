import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  static const String _baseUrl = 'https://api-rs.pokemonle.incubator4.com/v1';

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    final uri = Uri.parse('$_baseUrl/$path').replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      // 添加类型检查
      if (jsonData is! Map<String, dynamic>) {
        throw FormatException('Expected Map but got ${jsonData.runtimeType}');
      }

      return jsonData;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
