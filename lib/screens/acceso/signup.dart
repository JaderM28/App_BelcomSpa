// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/alertas.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/request.dart';
import 'package:proyecto_belcomspa_flutter/screens/acceso/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final url = "https://backend-valhalla.onrender.com/ruta/usuarios";
  final _formKey = GlobalKey<FormState>();
  bool ocultTextOne = true;
  bool ocultTextTwo = true;

  TextEditingController txtNombres = TextEditingController();
  TextEditingController txtApellidos = TextEditingController();
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtCorreo = TextEditingController();
  TextEditingController txtRol = TextEditingController();
  TextEditingController txtEstado = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtRepeatPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF776B5D),
        centerTitle: true,
        title: const Text("App - BelcomSpa", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    
                    color: Colors.black,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        "Registro de Usuario",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: txtNombres,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB0A695),
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      hintText: "Nombres",
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 42, 42)),
                      prefixIcon: Icon(Icons.lock),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce tu nombres";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: txtApellidos,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB0A695),
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      hintText: "Apellidos",
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 42, 42)),
                      prefixIcon: Icon(Icons.lock),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce tu apellidos";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: txtUsername,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB0A695),
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      hintText: "Username",
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 42, 42)),
                      prefixIcon: Icon(Icons.lock),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce tu username";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: txtCorreo,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB0A695),
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      hintText: "Email",
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 42, 42)),
                      prefixIcon: Icon(Icons.lock),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce tu correo";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: txtRol,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB0A695),
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      hintText: "Rol",
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 42, 42)),
                      prefixIcon: Icon(Icons.lock),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce tu correo";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: txtEstado,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFB0A695),
                      border: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                      hintText: "Estado",
                      hintStyle: TextStyle(
                      color: Color.fromARGB(255, 42, 42, 42)),
                      prefixIcon: Icon(Icons.lock),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce tu correo";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    obscureText: ocultTextOne,
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
                              ocultTextOne = !ocultTextOne;
                            });
                          },
                          icon: Icon(ocultTextOne
                              ? Icons.visibility
                              : Icons.visibility_off))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce tu contraseña";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  TextFormField(
                    obscureText: ocultTextTwo,
                    obscuringCharacter: '*',
                    controller: txtRepeatPassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFB0A695),
                      border: const OutlineInputBorder(
                      borderSide: BorderSide.none),
                      focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none),
                      hintText: "Repeat Password",
                      hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 42, 42, 42)),
                      prefixIcon: const Icon(Icons.lock),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              ocultTextTwo = !ocultTextTwo;
                            });
                          },
                          icon: Icon(ocultTextTwo
                              ? Icons.visibility
                              : Icons.visibility_off))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Por Favor, Introduce tu contraseña";
                      } else if (txtRepeatPassword.value !=
                          txtPassword.value) {
                        return "Error, Las contraseñas no coinciden";
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
                        final Map<String, dynamic> datos = {
                          "nombres": txtNombres.text,
                          "apellidos": txtApellidos.text,
                          "username": txtUsername.text,
                          "correo": txtCorreo.text,
                          "estado": txtEstado.text,
                          "rol": txtRol.text,
                          "password": txtPassword.text
                        };
      
                        final apiService = ApiService(url, "usuarios");
                        bool estadoPost =
                            await apiService.postPeticion(datos);
      
                        if (estadoPost) {
                          Alertas.tipoAlerta(context, 2, "¡Registro Exitoso!",
                              "Se registro un nuevo usuario en el aplicativo");
                          Future.delayed(const Duration(seconds: 3), () {
                              Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const LoginScreen()));
                          });
                        } else {
                          Alertas.tipoAlerta(context, 3, "¡Error Registro!",
                              "No se pudo registrar el usuario, correo o username existentes.");
                        }
                        _formKey.currentState?.reset();
                      }
                    },
                    child: const Text("Registrar", style: TextStyle(color: Colors.white, fontSize: 18)))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
