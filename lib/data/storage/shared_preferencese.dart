import 'dart:convert';

import 'package:health_statistics/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _KeysStorage {
  static const userKey = 'userKey';
}

class SharedPrefRepository {
  static SharedPrefRepository? _singleton;
  static SharedPrefRepository get instance => _singleton!;

  SharedPrefRepository._internal();

  factory SharedPrefRepository() {
    _singleton ??= SharedPrefRepository._internal();
    return instance;
  }

  final prefs = SharedPreferences.getInstance();

  Future<void> saveUserData(UserModel user) async {
    final userJson = jsonEncode(user.toJson());
    await (await prefs).setString(_KeysStorage.userKey, userJson);
  }

  Future<UserModel?> getUserData() async {
    final data = (await prefs).getString(_KeysStorage.userKey) ?? '';
    if (data.isNotEmpty) {
      final json = jsonDecode(data) as Map<String, dynamic>;
      final user = UserModel.fromJson(json);
      return user;
    }
    return null;
  }
}
