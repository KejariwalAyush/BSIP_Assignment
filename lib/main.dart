import 'package:bill_seperator/providers/bills_provider.dart';
import 'package:bill_seperator/views/home_page.dart';
import 'package:bill_seperator/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String kFileName = 'bills_db.json';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BillListProvider>(
      create: (context) => BillListProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen()
        // HomePage(),
      ),
    );
  }
}
