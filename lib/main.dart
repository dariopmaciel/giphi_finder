import 'package:flutter/material.dart';
import 'package:giphi_finder/ui/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        hintColor: Colors.white,
        primaryColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          //hintStyle: TextStyle(color: Colors.amber),
        ),
      ),
    ),
  );
}
