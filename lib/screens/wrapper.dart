import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expenses_management/services/auth.dart';
import 'package:expenses_management/screens/auth/HomePage.dart';
import 'package:expenses_management/screens/authenticate/authenticate.dart';
import 'package:expenses_management/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserClass?>(context);

    // Return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return HomePage();
    }
  }
}
