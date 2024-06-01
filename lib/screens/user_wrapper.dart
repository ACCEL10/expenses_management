import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:expenses_management/screens/profile/profile_screen.dart';

class UserWrapper extends StatefulWidget {
  const UserWrapper({Key? key});

  @override
  State<UserWrapper> createState() => _CustomerWrapperState();
}

class _CustomerWrapperState extends State<UserWrapper> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      ProfilePage(),
    ];

    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 60, 190, 28),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: GNav(
            selectedIndex: currentIndex,
            onTabChange: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color.fromARGB(255, 80, 239, 88),
            padding: EdgeInsets.all(16),
            tabs: [
              GButton(
                gap: 5,
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                gap: 5,
                icon: Icons.delivery_dining_rounded,
                text: 'Activity',
              ),
              GButton(
                gap: 5,
                icon: Icons.notifications,
                text: 'Notifications',
              ),
              GButton(
                gap: 5,
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
