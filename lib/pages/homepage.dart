import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gateway Gas'),
      ),
      body: Column(
        children: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/customer');
              },
              icon: const Icon(Icons.person))
        ],
      ),
    );
  }
}
