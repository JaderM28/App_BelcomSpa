import 'package:flutter/material.dart';
import 'package:proyecto_belcomspa_flutter/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SesionProvider extends ChangeNotifier {

  void cerrarSesion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    notifyListeners();

    if (!context.mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainApp()),
    );
  }

  Future<void> guardarToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    notifyListeners();
  }
}
