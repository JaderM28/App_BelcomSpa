import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/alertas.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/request.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/sesion.dart';
import 'package:proyecto_belcomspa_flutter/screens/acceso/signup.dart';
import 'package:proyecto_belcomspa_flutter/screens/usuarios/listarUsuarios.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final url = "https://backend-valhalla.onrender.com/ruta/usuarios";
  final _formKey = GlobalKey<FormState>();
  bool ocultText = true;

  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtCorreo = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  final apiService = ApiService(
      "https://backend-valhalla.onrender.com/ruta/usuarios", "usuarios");

  List<dynamic> listData = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    listData = await apiService.getPeticion();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final sesionProvider = Provider.of<SesionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF776B5D),
        centerTitle: true,
        title: const Text("App - BelcomSpa", style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold,),),
      ),
      body: Container(
        color: const Color.fromARGB(255, 234, 232, 232),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              child: Container(
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color(0xFFB0A695)),
                height: 350,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(125),
                      child: Image.asset('assets/img/Logo.png',
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: txtUsername,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFB0A695),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "Username",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 42, 42, 42)),
                            prefixIcon: Icon(Icons.person),
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Por Favor, Introduce tu username";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: txtCorreo,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFB0A695),
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 42, 42, 42)),
                            prefixIcon: Icon(Icons.email),
                            floatingLabelBehavior: FloatingLabelBehavior.never),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Por Favor, Introduce tu correo";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: ocultText,
                        obscuringCharacter: '*',
                        controller: txtPassword,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xFFB0A695),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                            hintText: "Password",
                            hintStyle: const TextStyle(
                                color: Color.fromARGB(255, 42, 42, 42)),
                            prefixIcon: const Icon(Icons.lock),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    ocultText = !ocultText;
                                  });
                                },
                                icon: Icon(ocultText
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Por Favor, Introduce tu contraseña";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size(double.infinity,
                                  48.0), 
                            ),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(
                                    0xFF776B5D)),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              bool bandera = false;

                              for (var datos in listData) {
                                if (datos['username'] == txtUsername.text &&
                                    datos['correo'] == txtCorreo.text) {
                                  bandera = true;
                                  break;
                                }
                              }
                              if (bandera) {
                                sesionProvider.guardarToken(txtUsername.text);
                                Alertas.tipoAlerta(
                                    context,
                                    2,
                                    "Credenciales Correctas",
                                    "las credenciales son correctas, bienvenido usuario.");
                                Future.delayed(const Duration(seconds: 3), () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ListarUsuarios()));
                                });
                              } else {
                                Alertas.tipoAlerta(
                                    context,
                                    3,
                                    "Error Credenciales",
                                    "las credenciales no son correctas o no se encontro usuario");
                              }
                              _formKey.currentState?.reset();
                            }
                          },
                          child: const Text(
                            "Enviar",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                      const SizedBox(
                        height: 50,
                      ),
                      TextButton(
                        onPressed: () {
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                          });
                        },
                        child: const Text('¿No tienes una cuenta? Regístrate', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 89, 80, 70)),),
                      ),

                      // Enlace para olvidar la contraseña
                      TextButton(
                        onPressed: () {
                          // Navegar a la pantalla de recuperación de contraseña
                        },
                        child: const Text('¿Olvidaste tu contraseña?', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 90, 80, 70)),),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
