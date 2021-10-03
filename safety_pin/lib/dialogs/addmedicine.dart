import 'package:flutter/material.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final TextEditingController _medicine = TextEditingController();
  late DateTime _dateTime = DateTime.now();

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
    print('Adding medicine');
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
              ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year),
                    lastDate: DateTime(DateTime.now().year + 1),
                  ).then((value) {
                    setState(() {
                      _dateTime = value!;
                    });
                  });
                },
                child: Text(
                  'Enter date',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Date picked:'),
              Text(
                  '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()}')
            ],
          ),
          ElevatedButton(onPressed: () {}, child: Text('Add Medicine')),
        ],
      ),
    );
  }

  saveMedicine() {}
}
