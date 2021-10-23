import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:safety_pin/services/store.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _medicinecollection =
    _firestore.collection('medicines');
final CollectionReference _trackcollection = _firestore.collection('track');
final geo = Geoflutterfire();

class Device {
  static String deviceId = "";
  static Future init() async => deviceId = await UserSimplePreferences.getID();
}

class Database {
  static String? userUid = Device.deviceId;

  static Future<void> addItem({
    required String name,
    required String time,
  }) async {
    print(userUid);
    DocumentReference documentReference =
        _medicinecollection.doc(userUid).collection('items').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "medicine": name,
      "time": time,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print('Medicine added'))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> readItems() {
    print('Read items');
    CollectionReference<Map<String, dynamic>> notesItemCollection =
        _medicinecollection.doc(userUid).collection('items');
    return notesItemCollection.snapshots();
  }

  static Future<void> updateItem({
    required String title,
    required String time,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _medicinecollection.doc(userUid).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "medicine": title,
      "time": time,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _medicinecollection.doc(userUid).collection('items').doc(docId);
    print(docId);
    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}

class ParentChild {
  static String? userUid = Device.deviceId;

  static Future<void> initial({
    required String time,
    required String latitude,
    required String longitude,
    required String childDevID,
    required bool request,
    required bool response,
  }) async {
    var output = await placemarkFromCoordinates(
        double.parse(latitude), double.parse(longitude));
    String address = "${output[0].locality},${output[0].subAdministrativeArea}";
    print(output);
    print('User ID:$userUid');
    DocumentReference documentReference =
        _trackcollection.doc(userUid).collection(childDevID).doc();
    Map<String, dynamic> data = <String, dynamic>{
      "time": time,
      "request": request,
      "response": response,
      "Address": address,
      "Child address": "none",
    };
    await documentReference
        .set(data)
        .whenComplete(() => print('Address requested'))
        .catchError((e) => print(e));
  }

  static Future<void> updateRequest({
    required String time,
    required String childDevID,
    required bool request,
    required bool response,
    required String latitude,
    required String longitude,
    required String docId,
  }) async {
    var output = await placemarkFromCoordinates(
        double.parse(latitude), double.parse(longitude));
    String address = "${output[0].locality},${output[0].subAdministrativeArea}";
    print(output);
    DocumentReference documentReference =
        _trackcollection.doc(userUid).collection(childDevID).doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "time": time,
      "request": request,
      "Address": address,
      "response": response,
    };
    await documentReference
        .update(data)
        .whenComplete(() => print("Track item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> readItems() {
    print('Read items');
    String devId = UserSimplePreferences.getDeviceID()!;
    CollectionReference<Map<String, dynamic>> notesItemCollection =
        _trackcollection.doc(userUid).collection(devId);
    return notesItemCollection.snapshots();
  }

  static updateResponse({
    required String childDevId,
    required bool response,
    required String docId,
  }) async {
    DocumentReference documentReference =
        _trackcollection.doc(userUid).collection(childDevId).doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "response": response,
    };
    await documentReference
        .update(data)
        .whenComplete(() => print("Response changed in database"))
        .catchError((e) => print(e));
  }

  static sendLocation({
    required String childDevId,
    required String latitude,
    required String longitude,
    required String docId,
  }) async {
    var output = await placemarkFromCoordinates(
        double.parse(latitude), double.parse(longitude));
    String address = "${output[0].locality},${output[0].subAdministrativeArea}";
    print(docId);
    print(output);
    DocumentReference documentReference =
        _trackcollection.doc(userUid).collection(childDevId).doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      "Child address": address,
    };
    await documentReference
        .update(data)
        .whenComplete(() => print("Child location updated"))
        .catchError((e) => print(e));
  }
}
