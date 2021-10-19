import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safety_pin/helpers/firebaseHelper.dart';
import 'package:geocoding/geocoding.dart';

class TrackList extends StatefulWidget {
  const TrackList({Key? key}) : super(key: key);

  @override
  _TrackListState createState() => _TrackListState();
}

class _TrackListState extends State<TrackList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Track request history"),
      ),
      body: historyList(context),
    );
  }

  Widget historyList(BuildContext context) {
    print('History list');
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
                  String time = requestInfo['time'];
                  String address = requestInfo['Address'];
                  String docID = snapshot.data!.docs[index].id;
                  return Ink(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onTap: () => onoff(context),
                      title: Text(
                        time,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                });
          }
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
          ));
        });
  }

  onoff(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text(
          "If this doesn't look like someplace your parent/gaurdian is or has been in the past we request you too kindly turn off your location sharing feature",
        ),
      ),
    );
  }
}
