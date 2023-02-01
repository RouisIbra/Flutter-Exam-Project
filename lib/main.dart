import 'package:examen_flutter/app.dart';
import 'package:examen_flutter/provider/pets_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PetsProvider(),
      builder: (context, child) => const App(),
    ),
  );
}
