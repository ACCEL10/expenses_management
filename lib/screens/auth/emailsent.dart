import 'package:flutter/material.dart';

class EmailSent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 28, 190, 36),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email, // Use Icons.email instead of icon: Icon(Icons.email)
              size: 100, // Set the size of the icon as needed
              color: const Color.fromARGB(
                  255, 115, 229, 162), // Set the color of the icon
            ),
            SizedBox(
              height: 60,
            ),
            Container(
              width: 300,
              child: Text(
                'Reset email has been sent to your mail box!',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 52, 211, 47),
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}
