import 'dart:convert';
import 'dart:io';

import 'package:health_statistics/data/api/config/url_api.dart';
import 'package:health_statistics/domain/models/health_statistic_model.dart';
import 'package:http/http.dart' as http;

class HealthStatisticApi {
  final _client = http.Client();

  Future<List<HealthStatisticModel>> fetchHealth() async {
    List<HealthStatisticModel> listHealthStatisitcs = [];
    try {
      final response = await _client.get(Uri.parse(UrlApi.healthUri));
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        listHealthStatisitcs = data
            .map(
                (e) => HealthStatisticModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on SocketException catch (e) {
      print('Сетевая ошибка: $e');
    } catch (e) {
      print("Ошибка: $e");
    }
    return listHealthStatisitcs;
  }
}
