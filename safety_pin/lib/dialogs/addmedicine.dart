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
      height: 372,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add medicine',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            children: [
              Text(
                'Enter medicine name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 270,
                child: TextField(
                  controller: _medicine,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'You will be notified to take ${_medicine.text} everyday at ${_time.hour}:${_time.minute}',
              ),
              SizedBox(
                height: 10,
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
                child: Text(
                  'Enter time',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
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
            child: Text('Add Medicine'),
          ),
        ],
      ),
    );
  }

  saveMedicine() {}
}
