class UserClass {
  final String uid;

  UserClass({required this.uid});

  @override
  String toString() {
    return 'UserClass(uid: $uid)';
  }
}

class UserData {
  final String uid;
  final String fullName;
  final String phoneNumber;
  final String emailAddress;

  UserData({
    required this.uid,
    required this.fullName,
    required this.phoneNumber,
    required this.emailAddress,
  });

  @override
  String toString() {
    return 'UserData(uid: $uid, fullName: $fullName, phoneNumber: $phoneNumber, emailAddress: $emailAddress)';
  }
}
