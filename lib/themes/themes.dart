import 'package:flutter/material.dart';

// Tema Claro Aplicacion
final ThemeData temaClaro = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 209, 194, 153),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
    ), 
  primaryColor: Colors.blue,
);

// Tema Oscuro Aplicacion
final ThemeData temaOscuro = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(backgroundColor: Color.fromARGB(255, 60, 35, 72)),
  primaryColor: const Color.fromARGB(255, 177, 63, 181),
);


class ThemeProvider with ChangeNotifier {
  
  ThemeData _currentTheme = temaClaro;

  ThemeData get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == temaClaro
        ? temaOscuro
        : temaClaro;
    notifyListeners();
  }
}
