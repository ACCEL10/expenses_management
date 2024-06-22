import 'package:flutter/material.dart';
import 'package:expenses_management/screens/auth/homepage.dart';
import 'package:expenses_management/models/user.dart';
import 'package:expenses_management/services/f_database.dart';
import 'package:provider/provider.dart';
import 'package:expenses_management/screens/user_wrapper.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass?>(context);
    print(user);
    if (user == null) {
      return const HomePage();
    } else {
      return FutureBuilder<String?>(
        future: DatabaseService(uid: user.uid).fetchedUserRoleFromFirestore(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              // Handle errors in fetching user role
              return const Text('Error fetching user role');
            } else {
              String? userRole = snapshot.data;

              if (userRole != null) {
                if (userRole == 'normal') {
                  return const UserWrapper();
                } else {
                  return const Text('Unhandled user role');
                }
              } else {
                return const Text('User role not available');
              }
            }
          }
        },
      );
    }
  }
}
