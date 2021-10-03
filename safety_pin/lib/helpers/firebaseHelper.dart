import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safety_pin/services/store.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('medicines');

class Device {
  static String deviceId = "";
  static Future init() async => deviceId = await UserSimplePreferences.getID();
}

class Database {
  static String? userUid = Device.deviceId;

  static Future<void> addItem({
    required String name,
    required String date,
  }) async {
    print(userUid);
    DocumentReference documentReference =
        _mainCollection.doc(userUid).collection('items').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "medicine": name,
      "date": date,
    };

    await documentReference
        .set(data)
        .whenComplete(() => print('Medicine added'))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> readItems() {
    print('Read items');
    CollectionReference<Map<String, dynamic>> notesItemCollection =
        _mainCollection.doc(userUid).collection('items');

    return notesItemCollection.snapshots();
  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
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
        _mainCollection.doc(userUid).collection('items').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
