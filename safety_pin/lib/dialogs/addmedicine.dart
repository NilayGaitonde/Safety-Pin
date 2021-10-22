import 'package:flutter/material.dart';
import 'package:safety_pin/helpers/firebaseHelper.dart';
import 'package:safety_pin/services/notifications.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final NotificationManager manager = NotificationManager();
  final TextEditingController _medicine = TextEditingController();
  TimeOfDay _time = TimeOfDay(hour: 9, minute: 10);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context, manager),
    );
  }

  _buildChild(BuildContext context, NotificationManager manager) {
    print('Adding medicine dialog');
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Add medicine',
              style: TextStyle(
                color: Colors.pink,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text(
                  'Enter medicine name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.pink[500]),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 300,
                  child: TextField(
                    controller: _medicine,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'You will be notified to take ${_medicine.text} everyday at ${_time.hour}:${_time.minute}',
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final TimeOfDay? _newtime = await showTimePicker(
                      context: context,
                      initialTime: _time,
                    );
                    if (_newtime != null) {
                      setState(() {
                        _time = _newtime;
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                    backgroundColor: Colors.pink,
                    primary: Colors.white,
                  ),
                  child: Text(
                    'Enter time',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                print(_medicine.text);
                print(_time);
                Database.addItem(name: _medicine.text, time: _time.toString());
                manager.showNotificationDaily(
                    _medicine.text, _time.hour, _time.minute);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                backgroundColor: Colors.pink,
                primary: Colors.white,
              ),
              child: Text('Add Medicine',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }

  saveMedicine() {}
}
