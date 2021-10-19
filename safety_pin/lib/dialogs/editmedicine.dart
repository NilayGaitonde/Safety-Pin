import 'package:flutter/material.dart';
import 'package:safety_pin/helpers/firebaseHelper.dart';
import 'package:safety_pin/pages/categories/seniorcitizen/medicine/medicine.dart';

class EditMedicine extends StatefulWidget {
  final String currentTitle;
  final String documentID;
  final String currentTime;

  const EditMedicine(
      {required this.currentTime,
      required this.currentTitle,
      required this.documentID});

  @override
  _EditMedicineState createState() => _EditMedicineState();
}

class _EditMedicineState extends State<EditMedicine> {
  late TextEditingController _titleController;
  late String _timeString = widget.currentTime;
  late int _hour = int.parse(_timeString.substring(10, 12));
  late int _minutes = int.parse(_timeString.substring(13, 15));
  late TimeOfDay _time = TimeOfDay(hour: _hour, minute: _minutes);

  @override
  void initState() {
    _titleController = TextEditingController(
      text: widget.currentTitle,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) {
    print("Editing medicine dialog");
    return Container(
      height: 372,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Edit medicine',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Column(
            children: [
              Text(
                'Medicine name:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 270,
                child: TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                'You will be notified to take ${_titleController.text} everyday at $_hour:$_minutes',
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
                      _hour = _time.hour;
                      _minutes = _time.minute;
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Database.updateItem(
                    title: _titleController.text,
                    time: _time.toString(),
                    docId: widget.documentID,
                  );
                  Navigator.pop(context);
                },
                child: Text('Update medicine'),
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    Database.deleteItem(docId: widget.documentID);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Medicine()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: Icon(Icons.delete),
                  label: Text(''))
            ],
          )
        ],
      ),
    );
  }
}
