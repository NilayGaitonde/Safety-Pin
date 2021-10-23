import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:safety_pin/helpers/firebaseHelper.dart';
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
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
  }

  static Future parentChild(String age) async =>
      await _preferences.setString('Age', age);

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

  static void trackCount() async {
    if (_preferences.containsKey('Counter')) {
      print('Counter exists');
      var counter = _preferences.getInt('Counter') as int;
      _preferences.setInt('Counter', counter + 1);
    } else {
      print('Counter exists');
      _preferences.setInt('Counter', 0);
    }
  }

  static bool checkDeviceID() {
    if (_preferences.containsKey('DeviceID')) {
      print('We good');
      return true;
    } else {
      return false;
    }
  }

  static Future location(bool share) async =>
      await _preferences.setBool('ShareLocation', share);

  static Future saveName(String name) async =>
      await _preferences.setString('Name', name);

  static Future saveEmail(String email) async =>
      await _preferences.setString('Email', email);

  static Future savePhone(String phoneNumber) async =>
      await _preferences.setString('number', phoneNumber);
  static Future saveDOC(List<String> docIDs) async =>
      await _preferences.setStringList('DocIDs', docIDs);

  static void saveDeviceID(String deviceID) async =>
      await _preferences.setString('DeviceID', deviceID);
  static String? getCategory() => _preferences.getString('Category');
  static bool? loggedin() => _preferences.getBool('Acc');
  static List? getContacts() => _preferences.getStringList('Emergency');
  static String? getMessage() => _preferences.getString('Message');
  static String? getName() => _preferences.getString('Name');
  static String? getEmail() => _preferences.getString('Email');
  static String? getPhone() => _preferences.getString('number');
  static int? getCount() => _preferences.getInt('Counter');
  static String? getParentChild() => _preferences.getString('Age');
  static String? getDeviceID() => _preferences.getString('DeviceID');
  static bool? getLocation() => _preferences.getBool('ShareLocation');
  static List<String>? getDocIDs() => _preferences.getStringList('DocIDs');

  static sendLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (UserSimplePreferences.getLocation() == null) {
      print('We think it is null');
    } else if (UserSimplePreferences.getLocation()!) {
      print('Hello');
      List<String> docIDs = UserSimplePreferences.getDocIDs()!;
      docIDs.forEach((docId) {
        ParentChild.sendLocation(
            childDevId: Device.deviceId,
            latitude: position.latitude.toString(),
            longitude: position.longitude.toString(),
            docId: docId);
      });
    } else {
      print(UserSimplePreferences.getLocation()!);
    }
  }
}
