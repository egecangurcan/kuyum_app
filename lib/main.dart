import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kuyum_app/editPanel.dart';
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50,),
            const Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Top(),
              ),
            ),
            const SizedBox(height: 16),
            const Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Bottom(),
              ),
            ),
            Expanded(flex: 1,
                child: Positioned.fill(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PasswordScreen()),
                      );
                    },
                    behavior: HitTestBehavior.opaque, // This ensures that the gesture detector consumes all touches
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}