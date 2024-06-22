import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_management/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('User');

  final CollectionReference expensesCollection =
      FirebaseFirestore.instance.collection('Expenses');

  final CollectionReference statisticCollection =
      FirebaseFirestore.instance.collection('Statistic');

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
