import 'dart:convert';
import 'dart:io';

import 'package:health_statistics/data/api/config/config_api.dart';
import 'package:health_statistics/data/storage/shared_preferencese.dart';
import 'package:health_statistics/domain/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserApi {
  const UserApi();
  Future<void> saveUserData(UserModel userData) async {
    final users = await fetchUserData();
    final currentUser = (await SharedPrefRepository.instance.getUserData())!;
    if (users.contains(currentUser)) {
      await _updateData(userData);
    } else {
      await _saveData(userData);
    }
  }

  Future<List<UserModel>> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse(ConfigApi.userUri));
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
        final usersList = data
            .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return usersList;
      } else {
        throw Exception('Ошибка загрузки пользователей');
      }
    } on SocketException catch (e) {
      throw Exception('Сетевая ошибка: $e');
    } catch (e) {
      throw Exception('Общая ошибка: $e');
    }
  }

  Future<void> _saveData(UserModel userData) async {
    try {
      var response = await http.post(
        Uri.parse(ConfigApi.userUri),
        headers: ConfigApi.headersJson,
        body: jsonEncode(
          userData.toJson(),
        ),
      );
      if (response.statusCode != 201) {
        throw Exception(
            'Данные пользователя не сохранены: статус код ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка сохранения данных: $e');
    }
  }

  Future<void> _updateData(UserModel userData) async {
    try {
      var response = await http.put(
        Uri.parse("${ConfigApi.userUri}${userData.id}/"),
        headers: ConfigApi.headersJson,
        body: jsonEncode(userData.toJson()),
      );
      if (response.statusCode == 200) {
        // print('Данные пользователя успешно изменены');
      } else if (response.statusCode == 404) {
        throw Exception(
            'Страница  ${ConfigApi.userUri}${userData.id} не найдена');
      } else {
        throw Exception(
            'Ошибка изменения данных пользователя: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Ошибка изменения данных: $e');
    }
  }
}
