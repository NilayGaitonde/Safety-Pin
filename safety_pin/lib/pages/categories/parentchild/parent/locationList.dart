import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:safety_pin/helpers/dialogHelper.dart';
import 'package:safety_pin/helpers/firebaseHelper.dart';
import 'package:safety_pin/services/store.dart';

class LocationList extends StatefulWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location history of your child"),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: locationList(context),
    );
  }

  Widget locationList(BuildContext context) {
    print('Location history list');
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: ParentChild.readItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('error mate');
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            print('No error');
            return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(
                      height: 16.0,
                    ),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var requestInfo = snapshot.data!.docs[index].data();
                  print('Title:$requestInfo');
                  print(requestInfo.runtimeType);
                  String childAddress = requestInfo['Child address'];
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
                      onTap: () => onoff(context),
                      title: Text(
                        childAddress,
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

  onoff(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: const Text(
          "This seems to be the last known location of your child's device"),
    ));
  }

  Future<void> trackrequest() async {
    Position parent = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (UserSimplePreferences.checkDeviceID()) {
      UserSimplePreferences.trackCount();
      int counter = UserSimplePreferences.getCount()!;
      print('Track requested\n$counter');
      String time = DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());
      ParentChild.initial(
        time: time,
        latitude: parent.latitude.toString(),
        longitude: parent.longitude.toString(),
        childDevID: UserSimplePreferences.getDeviceID()!,
        request: true,
        response: false,
      );
    } else {
      DialogHelper.getDeviceId(context);
    }
  }
}
