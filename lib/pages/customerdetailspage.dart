import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerDetailsPage extends StatelessWidget {
  const CustomerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final customerId = ModalRoute.of(context)!.settings.arguments.toString();

    //get all the customer details from the database
    Future _getCustomerDetails() async {
      final reponse = await Supabase.instance.client
          .from('customers')
          .select('*, locations(*), users(*)')
          .eq('id', customerId);
      final data = reponse;
      return data;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: FutureBuilder(
        future: _getCustomerDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('error getting customer details ${snapshot.error}');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No customer found'),
            );
          } else {
            final primaryName = snapshot.data[0]['primary_name'];
            final loctions = snapshot.data[0]['locations'][0];
            final users = snapshot.data[0]['users'][0];
            return Column(
              children: [
                const Text('Primary name'),
                Text(
                  primaryName,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary),
                ),
                Row(
                  children: [
                    ListTile(
                      title: Text(loctions['location_name']),
                    ),
                  ],
                ),
                Row(
                  children: [
                    ListTile(
                    title: Text(users['customer_name']),
                    )
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
