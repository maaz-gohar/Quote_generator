import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Quote Generator',
      theme: ThemeData(
        primaryColor: Colors.blue.shade900, // Change primary color
        scaffoldBackgroundColor: Color.fromRGBO(192, 244, 250, 1.0), // Change scaffold background color
        // textTheme: TextTheme(
        //   bodyText2: TextStyle(color: Colors.black87), // Change default text color
        // ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          accentColor: Colors.blue.shade900,
          // You can optionally define more colors here such as secondary and error
        ),
      ),
      home: QuoteScreen(),
    );
  }
}

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  String quote = 'Press the button to get a quote';
  String author = '';

  Future<void> fetchQuote() async {
    final response = await http.get(Uri.parse('https://api.quotable.io/random'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        quote = data['content'];
        author = data['author'];
      });
    } else {
      throw Exception('Failed to load quote');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Random Quote Generator'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 4, // Add elevation for shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0), // Add border radius
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        quote,
                        style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        '- $author',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchQuote,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary, // Use primary color from colorScheme
                  foregroundColor: Theme.of(context).colorScheme.onPrimary, // Use onPrimary color from colorScheme
                ),
                child: Text('Get Quote'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
