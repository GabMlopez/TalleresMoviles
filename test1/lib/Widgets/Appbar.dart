import 'package:flutter/material.dart';

class AppbarPag extends StatefulWidget {
  const AppbarPag({super.key});

  @override
  State<AppbarPag> createState() => _AppbarPagState();
}

class _AppbarPagState extends State<AppbarPag> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.blue,
        title: Text("Consumo de Api"),

    );
  }
}
