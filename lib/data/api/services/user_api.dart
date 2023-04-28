import 'dart:convert';
import 'dart:io';

import 'package:health_statistics/data/api/config/config_api.dart';
import 'package:health_statistics/data/storage/shared_preferencese.dart';
import 'package:health_statistics/domain/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserApi {
  Future<void> saveUserData(UserModel userData) async {
    final users = await fetchUserData();
    final currentUser = (await SharedPrefRepository.instance.getUserData())!;
    for (var user in users) {
      if (user.id == currentUser.id) {
        await _updateData(userData);
        return;
      }
    }
    if (!users.contains(currentUser)) {
      await _saveData(userData);
      print(userData.toJson());
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
      throw Exception('Сетевая ошибка');
    } catch (e) {
      throw Exception('Общая ошибка');
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
      if (response.statusCode == 201) {
        print('Данные пользователя сохранены');
      } else {
        print(
            'Данные пользователя не сохранены! ошибка ${response.statusCode}');
      }
    } catch (e) {
      print('Ошибка сохранения пользователя: $e');
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
        print('Данные пользователя успешно изменены');
      } else if (response.statusCode == 404) {
        print(
            'Статус код 404: страница ${ConfigApi.userUri}${userData.id}/ не найдена');
      } else {
        print('Ошибка изменения данных пользователя: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }
}
