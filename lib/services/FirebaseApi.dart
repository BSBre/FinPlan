import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _dataBase = FirebaseFirestore.instance;

class FirebaseApi {

  static String? userId;

  static Future<void> addItem({
    required String userEmail,
    required DateTime dateCreated,
    required String userPassword,
    required String userFirstName,
    required String userLastName,
  }) async {
    DocumentReference usersDocument =
    _dataBase.collection('users').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "userEmail": userEmail,
      "dateCreated": dateCreated,
      "userPassword": userPassword,
      "userFirstName" : userFirstName,
      "userLastName" : userLastName,
    };



    await usersDocument
        .set(data)
        .whenComplete(() => print("Notes item added to the database"))
        .catchError((e) => print(e));


    
  }

}

