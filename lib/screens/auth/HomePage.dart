import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_management/screens/statisticpage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Management',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _foodController = TextEditingController();
  final TextEditingController _petrolController = TextEditingController();
  final TextEditingController _haircutsController = TextEditingController();
  final TextEditingController _supermarketController = TextEditingController();
  final TextEditingController _cafeController = TextEditingController();
  final TextEditingController _restaurantController = TextEditingController();

  @override
  void dispose() {
    _foodController.dispose();
    _petrolController.dispose();
    _haircutsController.dispose();
    _supermarketController.dispose();
    _cafeController.dispose();
    _restaurantController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    try {
      await FirebaseFirestore.instance.collection('Expenses').add({
        'food': int.parse(_foodController.text),
        'petrol': int.parse(_petrolController.text),
        'haircuts': int.parse(_haircutsController.text),
        'supermarket': int.parse(_supermarketController.text),
        'cafe': int.parse(_cafeController.text),
        'restaurant': int.parse(_restaurantController.text),
        'date': Timestamp.now(),
      });
    } catch (error) {
      print("Failed to add expense: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Expenses'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to profile page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.green,
            child: const Column(
              children: [
                Text(
                  'June 2024',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('left', style: TextStyle(color: Colors.white)),
                    Text('Savings', style: TextStyle(color: Colors.white)),
                    Text('spend', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1,101', style: TextStyle(color: Colors.white)),
                    Text('0', style: TextStyle(color: Colors.white)),
                    Text('399', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildExpenseItem('Food', _foodController),
                  _buildExpenseItem('Petrol', _petrolController),
                  _buildExpenseItem('Haircuts', _haircutsController),
                  _buildExpenseItem('Supermarket', _supermarketController),
                  _buildExpenseItem('Cafe', _cafeController),
                  _buildExpenseItem('Restaurant', _restaurantController),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: _submitData,
                  child: Text('Submit'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StatisticPage()),
                    );
                  },
                  child: Text('View Statistics'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem(String label, TextEditingController controller) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(fontSize: 16.0)),
            SizedBox(
              width: 100,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Amount',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Center(
        child: Text('Profile Page Content'),
      ),
    );
  }
}
