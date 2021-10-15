import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

class UserSimplePreferences {
  static SharedPreferences _preferences = "" as SharedPreferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future<String> getID() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  static Future setLoggedIn(bool loggedIn) async =>
      await _preferences.setBool('Acc', loggedIn);
  static Future setContact(List<String> numbers) async =>
      await _preferences.setStringList('Emergency', numbers);
  static Future setCategory(String category) async =>
      await _preferences.setString('Category', category);
  static Future initialMessage() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String message =
        "Hello! I am feeling unsafe and have messaged you\nThis is my current location https://www.google.com/maps/search/?api=1&query=${position.latitude.toString()},${position.longitude.toString()} ($position).\nHere is what you can do to help:\n1) Call the police @ 100\n2)Try to reach the co-ordinates. You yourself can reach there or ask a friend to reach there as early as possible\n3)Video Call or even a normal call will help as this can often disarm the attacker\n";
    await _preferences.setString('Message', message);
  }

  static Future saveName(String name) async =>
      await _preferences.setString('Name', name);

  static Future saveEmail(String email) async =>
      await _preferences.setString('Email', email);

  static Future savePhone(String phoneNumber) async =>
      await _preferences.setString('number', phoneNumber);

  static String? getCategory() => _preferences.getString('Category');
  static bool? loggedin() => _preferences.getBool('Acc');
  static List? getContacts() => _preferences.getStringList('Emergency');
  static String? getMessage() => _preferences.getString('Message');
  static String? getName() => _preferences.getString('Name');
  static String? getEmail() => _preferences.getString('Email');
  static String? getPhone() => _preferences.getString('number');
}
