import 'dart:convert';
import 'dart:io';

import 'package:health_statistics/data/api/config/url_api.dart';
import 'package:health_statistics/domain/models/health_statistic_model.dart';
import 'package:http/http.dart' as http;

class HealthStatisticApi {
  Future<List<HealthStatisticModel>> fetchHealth() async {
    List<HealthStatisticModel> listHealthStatisitcs = [];
    try {
      final response = await http.get(Uri.parse(UrlApi.healthUri));
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        listHealthStatisitcs = data
            .map(
                (e) => HealthStatisticModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } on SocketException catch (e) {
      print('Сетевая ошибка fethcHealth: $e');
    } catch (e) {
      print("Ошибка fetchHealth: $e");
    }
    return listHealthStatisitcs;
  }

  Future<void> saveHealthData(HealthStatisticModel healthData) async {
    try {
      final response = await http.post(
        Uri.parse(UrlApi.healthUri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          healthData.toJson(),
        ),
      );

      if (response.statusCode == 201) {
        print('Данные сохранены');
      } else {
        print('Данные не сохранены!');
      }
    } catch (e) {
      print('Ошибка saveHealthData: $e');
    }
  }
}
