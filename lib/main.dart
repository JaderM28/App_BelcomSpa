import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/sesion.dart';
import 'package:proyecto_belcomspa_flutter/screens/acceso/login.dart';
import 'package:proyecto_belcomspa_flutter/screens/usuarios/listarUsuarios.dart';
import 'package:proyecto_belcomspa_flutter/themes/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => SesionProvider()),
      ],
      child: MainApp(token: token),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, this.token});

  final String? token;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.currentTheme,
      home: token != null ? const ListarUsuarios() : const LoginScreen(),
    );
  }
}
