import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<dynamic>> getCustomers() async {
      final response = await Supabase.instance.client
          .from('customers')
          .select('*, locations(*)');
      return response;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Customers'),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: getCustomers(),
          builder: (context, snapshot) {
            final customers = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child:
                    Text('Something went wrong: ${snapshot.error.toString()}'),
              );
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text("No Customers Found"),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final location = customers![index]['locations'][0];
                return ListTile(
                  title: Text(customers[index]['primary_name']),
                  subtitle: Text(location['location_name']),
                );
              },
            );
          },
        ));
  }
}
