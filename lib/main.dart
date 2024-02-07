import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kuyum_app/pricePanel.dart';
import 'firebase_options.dart';
import 'imagePanel.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Top(),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Bottom(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}