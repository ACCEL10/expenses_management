import 'package:flutter/material.dart';
import 'package:expenses_management/API/firebase_api.dart';
import 'package:expenses_management/models/user.dart';
import 'package:expenses_management/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:expenses_management/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyABK_28pq5n5iwDZ-p_GsY4ou8EgMCykz4",
      appId: "1:675121704241:android:7d80da87ba1803c9bd9410",
      messagingSenderId: "675121704241",
      projectId: "expensesmanagement-9ccc0",
    ),
  );
  await FirebaseAPI().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserClass?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        routes: {
          '/home': (context) => const SplashScreen(),
        },
        home: const SplashScreen(),
      ),
    );
  }
}
