import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserDataSource {

  static const userIdKey = "userId";

  static Future<bool> isUserIdSet() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(userIdKey) != null;
  }

  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(userIdKey)!;
  }

  static Future<String> setUserId() async {
    final prefs = await SharedPreferences.getInstance();

    final generatedUserId = const Uuid().v4().toString();
    await prefs.setString(userIdKey, generatedUserId);

    return generatedUserId;
  }
}