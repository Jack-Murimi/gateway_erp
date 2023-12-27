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
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Text(
                      customers[index]['primary_name'],
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                    subtitle: Text(
                      location['location_name'],
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer),
                    ),
                    trailing: const Text(
                      '50,000',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/customerdetails',
                          arguments: customers[index]['id']);
                    },
                  ),
                );
              },
            );
          },
        ));
  }
}
