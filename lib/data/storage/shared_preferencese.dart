import 'dart:convert';

import 'package:health_statistics/domain/models/health_model.dart';
import 'package:health_statistics/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _KeysStorage {
  static const userKey = 'userKey';
  static const healthKey = 'healthKey';
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

  // -------------------USER------------------------
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

  // --------------------HEALTH----------------------
  Future<void> saveHealthData(HealthModel health) async {
    final List<HealthModel> healths = await getHealthData();
    final index = healths.indexWhere(
      (element) => element.dateTimeActivity.day == health.dateTimeActivity.day,
    );
    if (index == -1) {
      healths.add(health);
    } else {
      healths[index] = health;
    }
    healths.sort((a, b) => a.dateTimeActivity.compareTo(b.dateTimeActivity));
    final healthsJson = jsonEncode(
      healths.map((e) => e.toJson()).toList(),
    );
    await (await prefs).setString(_KeysStorage.healthKey, healthsJson);
  }

  Future<List<HealthModel>> getHealthData() async {
    final data = (await prefs).getString(_KeysStorage.healthKey) ?? '[]';
    final json = jsonDecode(data) as List;
    final healths = json
        .map((e) => HealthModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return healths;
  }

  Future<void> clearOldHealthData() async {
    final healths = await getHealthData();
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    healths.removeWhere(
      (element) => element.dateTimeActivity.isBefore(weekAgo),
    );
    for (var health in healths) {
      await saveHealthData(health);
    }
  }
}
