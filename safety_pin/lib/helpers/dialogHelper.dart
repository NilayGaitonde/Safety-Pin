import 'package:flutter/material.dart';
import 'package:safety_pin/dialogs/addmedicine.dart';
import 'package:safety_pin/dialogs/editcontacts.dart';

class DialogHelper {
  static contactedit(context) =>
      showDialog(context: context, builder: (context) => EditContacts());
  static addmedicine(context) =>
      showDialog(context: context, builder: (context) => AddMedicine());
}
