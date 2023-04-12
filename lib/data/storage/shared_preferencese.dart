import 'package:shared_preferences/shared_preferences.dart';

abstract class _KeysStorage {
  static const genderKey = 'genderKey';
  static const ageKey = 'ageKey';
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

  Future<void> saveUserData(String gender, int age) async {
    await (await prefs).setString(_KeysStorage.genderKey, gender);
    await (await prefs).setInt(_KeysStorage.ageKey, age);
  }

  Future<int> getUserAgeData() async {
    return (await prefs).getInt(_KeysStorage.ageKey) ?? 0;
  }

  Future<String> getUserGenderData() async {
    return (await prefs).getString(_KeysStorage.genderKey) ?? '';
  }
}
