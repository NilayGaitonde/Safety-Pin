import 'package:flutter/material.dart';
import 'package:safety_pin/dialogs/addmedicine.dart';
import 'package:safety_pin/dialogs/deviceinfo.dart';
import 'package:safety_pin/dialogs/editcontacts.dart';
import 'package:safety_pin/dialogs/editmedicine.dart';
import 'package:safety_pin/dialogs/getDeviceId.dart';
import 'package:safety_pin/dialogs/help.dart';

class DialogHelper {
  static contactedit(context) =>
      showDialog(context: context, builder: (context) => EditContacts());
  static addmedicine(context) =>
      showDialog(context: context, builder: (context) => AddMedicine());
  static editmedicine(context, documentId, title, time) => showDialog(
      context: context,
      builder: (context) => EditMedicine(
            documentID: documentId,
            currentTitle: title,
            currentTime: time,
          ));
  static deviceInfo(context) =>
      showDialog(context: context, builder: (context) => DeviceInfo());
  static getDeviceId(context) =>
      showDialog(context: context, builder: (context) => GetDeviceID());
  static showHelp(context) =>
      showDialog(context: context, builder: (context) => Help());
}
