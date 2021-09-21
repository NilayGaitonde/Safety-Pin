import 'package:flutter/material.dart';
import 'package:safety_pin/services/editcontacts.dart';

class DialogHelper {
  static contactedit(context) =>
      showDialog(context: context, builder: (context) => EditContacts());
}
