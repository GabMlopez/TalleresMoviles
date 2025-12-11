import 'package:flutter/material.dart';
import './layout/api_consumer_page.dart';
import './layout/firebase_page.dart';
import './layout/personaje_edit_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gabriel Lopez_test2p',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: "/",
      routes: {
        //lista inicial
        '/': (context) => const ApiConsumerPage(),
        //pagina de
        '/firebase': (context) => const FirebasePage(),
        //pagina de
        '/edit': (context) => const PersonajeEditPage(),
      },
      home: const ApiConsumerPage(),
    );
  }
}
