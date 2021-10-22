import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safety_pin/helpers/dialogHelper.dart';
import 'package:safety_pin/helpers/firebaseHelper.dart';

class Medicine extends StatefulWidget {
  const Medicine({Key? key}) : super(key: key);

  @override
  _MedicineState createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  // Stream<QuerySnapshot> read = Database.readItems();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Your medicines"),
      ),
      body: medicineList(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
        onPressed: () {
          DialogHelper.addmedicine(context);
        },
      ),
    );
  }

  Widget medicineList(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: Database.readItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      height: 16.0,
                    ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var noteInfo = snapshot.data!.docs[index].data();
                  print('Title:$noteInfo');
                  String title = noteInfo['medicine'];
                  String time = noteInfo['time'];
                  String docID = snapshot.data!.docs[index].id;

                  return Ink(
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onTap: () => DialogHelper.editmedicine(
                          context, docID, title, time),
                      title: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        time,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                });
          }
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
          ));
        });
  }
}
