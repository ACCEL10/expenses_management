import 'package:flutter/material.dart';
import 'package:expenses_management/screens/auth/LoginPage.dart';
import 'package:carousel_slider/carousel_slider.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final List<String> images = [
    "assets/images/tBZ9t8k.png",
  ];

  final List<Widget> texts = [
    RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontFamily: 'Helvetica', // Replace with your preferred font
        ),
        children: [
          TextSpan(
            text: 'Welcome to Our App \n Let\'s get to know Money Management',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text:
                "\n\n Our app helps you manage your monthly expenses.\nIf you are too busy to pick it up, we will send it to you.\nSave time, stay organized and receive your package without any hassle!",
          ),
        ],
      ),
    ),
    RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontFamily: 'Helvetica', // Replace with your preferred font
        ),
        children: [
          TextSpan(
            text: 'Choose Your Purpose',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text:
                "\n\n Our app is an easy-to-use tool for managing expenses. \nSign up to start managing your finances more effectively.",
          ),
        ],
      ),
    ),
    RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontStyle: FontStyle.normal,
          fontFamily: 'Helvetica', // Replace with your preferred font
        ),
        children: [
          TextSpan(
            text: 'Let\'s Register Now',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "\n\n Let's use our app to make your day easier",
          ),
        ],
      ),
    ),
  ];
  int _currentIndex = 0;

  void _showSignUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Sign Up',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 21, 130, 11), // Button color
            ),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width *
                0.3, // Adjust the width as needed
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
                // Add your logic for signing up as a user
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 11, 130, 11),
              ),
              child: const Text('Sign Up'),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 74, 190, 28),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CarouselSlider.builder(
                itemCount: images.length,
                itemBuilder: (context, index, realIndex) {
                  return SlideItem(
                    image: images[index],
                    text: texts[index],
                    isLastSlide: index == images.length - 1,
                  );
                },
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_currentIndex == images.length - 1)
              ElevatedButton(
                onPressed: () {
                  // Show the sign-up dialog
                  _showSignUpDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 11, 130, 11),
                ),
                child: const Text('Get Started'),
              ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => buildDot(index: index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDot({required int index}) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentIndex == index ? Colors.white : Colors.grey,
      ),
    );
  }
}

class SlideItem extends StatelessWidget {
  final String image;
  final Widget text;
  final bool isLastSlide;

  const SlideItem(
      {required this.image, required this.text, required this.isLastSlide});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            height: 400,
            width: 400,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          text,
        ],
      ),
    );
  }
}
