import 'package:flutter/material.dart';
import 'package:gateway_erp/pages/customerdetailspage.dart';
import 'package:gateway_erp/pages/customerpage.dart';
import 'package:gateway_erp/pages/homepage.dart';
import 'package:gateway_erp/theme/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://fsogcozrohprhqfilhix.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZzb2djb3pyb2hwcmhxZmlsaGl4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI3OTgwMjgsImV4cCI6MjAxODM3NDAyOH0.E_rnV3uupAHaIw3y4YXRjtAfQ9XaFPfSb0NOnsM8Xng");
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/customer': (context) => const CustomerPage(),
        '/customerdetails': (context) => const CustomerDetailsPage(),
      },
    );
  }
}
