import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticPage extends StatefulWidget {
  @override
  _StatisticPageState createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  Future<List<Map<String, dynamic>>> _fetchExpenses() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Expenses').get();
    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Budgets'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchExpenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          }

          List<Map<String, dynamic>> expenses = snapshot.data!;
          double food = expenses
              .map((e) => e['food'] as int)
              .reduce((a, b) => a + b)
              .toDouble();
          double petrol = expenses
              .map((e) => e['petrol'] as int)
              .reduce((a, b) => a + b)
              .toDouble();
          double haircuts = expenses
              .map((e) => e['haircuts'] as int)
              .reduce((a, b) => a + b)
              .toDouble();
          double supermarket = expenses
              .map((e) => e['supermarket'] as int)
              .reduce((a, b) => a + b)
              .toDouble();
          double cafe = expenses
              .map((e) => e['cafe'] as int)
              .reduce((a, b) => a + b)
              .toDouble();
          double restaurant = expenses
              .map((e) => e['restaurant'] as int)
              .reduce((a, b) => a + b)
              .toDouble();

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Weekly Expenses',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  'June 15, 2024 - June 21, 2024',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(16.0),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barGroups: [
                        makeGroupData(0, food),
                        makeGroupData(1, petrol),
                        makeGroupData(2, haircuts),
                        makeGroupData(3, supermarket),
                        makeGroupData(4, cafe),
                        makeGroupData(5, restaurant),
                      ],
                      titlesData: FlTitlesData(),
                      borderData: FlBorderData(show: false),
                      barTouchData: BarTouchData(enabled: false),
                      gridData: FlGridData(
                          show: true,
                          checkToShowHorizontalLine: (value) =>
                              value % 50 == 0),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
        x: x, barRods: [BarChartRodData(toY: y, color: Colors.blue)]);
  }

  SettingsPage() {}
}
