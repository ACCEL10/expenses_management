import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_management/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  final CollectionReference parcelsCollection =
      FirebaseFirestore.instance.collection('Expenses');

  final CollectionReference deliveryRequestsCollection =
      FirebaseFirestore.instance.collection('Statistics');

  Future<void> updateFcmToken(String fcmToken) async {
    try {
      await usersCollection.doc(uid).update({'FCMToken': fcmToken});
    } catch (e) {
      print('Error updating FCM token: $e');
    }
  }

  Future updateUserData(String fullName, String phoneNumber) async {
    return await usersCollection.doc(uid).update({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    });
  }

  Future createUserData(String fullName, String phoneNumber,
      String emailAddress, String role) async {
    return await usersCollection.doc(uid).update({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress,
      'Role': role,
      'FCMToken': '',
    });
  }

  List<UserObject> _objectFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) {
          final data = doc.data() as Map<String, dynamic>?;

          if (data != null) {
            return UserObject(
              fullName: data['fullName'],
              phoneNumber: data['phoneNumber'],
              emailAddress: data['emailAddress'],
            );
          }
        })
        .whereType<UserObject>()
        .toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>?;
    return UserData(
      uid: uid,
      fullName: data?['fullName'],
      phoneNumber: data?['phoneNumber'],
      emailAddress: data?['emailAddress'],
    );
  }

  Stream<UserData> get userDataStream {
    return usersCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  fetchedUserRoleFromFirestore() {}
}
