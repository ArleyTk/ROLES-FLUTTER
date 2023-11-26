import 'package:flutter/material.dart';

import 'acceso.dart';

void main() {
  runApp(const EjemploListViews());
}

class EjemploListViews extends StatelessWidget {
  const EjemploListViews({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Acceso(),
      debugShowCheckedModeBanner: false,
    );
  }
}
