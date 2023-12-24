import 'package:flutter/material.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      body: const Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            trailing: Text('50,000'),
            title: Text('Jack Murimi'),
            subtitle: Text(
                'Venus appartment hse no A2 Jamhuri Estate on kibra station road'),
          )
        ],
      ),
    );
  }
}
