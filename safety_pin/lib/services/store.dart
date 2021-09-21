import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences _preferences = "" as SharedPreferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setLoggedIn(bool loggedIn) async =>
      await _preferences.setBool('Acc', loggedIn);
  static Future setContact(List<String> numbers) async =>
      await _preferences.setStringList('Emergency', numbers);
  static Future setCategory(String category) async =>
      await _preferences.setString('Category', category);

  static String? getCategory() => _preferences.getString('Category');
  static bool? loggedin() => _preferences.getBool('Acc');
  static List? getContacts() => _preferences.getStringList('Emergency');
}
