import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:health_statistics/data/api/config/config_api.dart';
import 'package:health_statistics/data/storage/shared_preferencese.dart';
import 'package:health_statistics/domain/models/health_model.dart';
import 'package:http/http.dart' as http;

class HealthApi {
  Future<void> saveHealthData(HealthModel healthData) async {
    final health = await fetchHealthData();
    final currentUser = (await SharedPrefRepository.instance.getUserData())!;
    for (var health in health) {
      if (health.userId == currentUser.id) {
        await _updateData(healthData);
        return;
      }
    }
    await _saveData(healthData);
  }

  Future<List<HealthModel>> fetchHealthData() async {
    try {
      final response = await http.get(Uri.parse(ConfigApi.healthUri));
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        final listHealthStatisitcs = data
            .map((e) => HealthModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return listHealthStatisitcs;
      } else {
        throw Exception('Ошибка загрузки статистики');
      }
    } on SocketException catch (e) {
      throw Exception('Сетевая ошибка $e');
    } catch (e) {
      throw Exception('Общая ошибка $e');
    }
  }

  Future<void> _saveData(HealthModel healthData) async {
    try {
      final response = await http.post(
        Uri.parse(ConfigApi.healthUri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          healthData.toJson(),
        ),
      );

      if (response.statusCode != 201) {
        throw Exception(
            'Данные статистики не сохранены: статус код ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка сохранения данных статистики');
    }
  }

  Future<void> _updateData(HealthModel healthData) async {
    try {
      var response = await http.put(
        Uri.parse("${ConfigApi.healthUri}${healthData.id}/"),
        headers: ConfigApi.headersJson,
        body: jsonEncode(healthData.toJson()),
      );
      if (response.statusCode == 200) {
        // print('Данные статистики успешно изменены');
      } else if (response.statusCode == 404) {
        throw Exception(
            'Страница ${ConfigApi.healthUri}${healthData.id} не найдена');
      } else {
        throw Exception(
            'Ошибка изменения данных статистики: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка изменения данных');
    }
  }
}
