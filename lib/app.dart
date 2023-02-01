import 'package:examen_flutter/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp.router(
      routerConfig: routerConfig,
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.robotoTextTheme(textTheme),
        scaffoldBackgroundColor: Colors.yellow[50],
      ),
    );
  }
}
