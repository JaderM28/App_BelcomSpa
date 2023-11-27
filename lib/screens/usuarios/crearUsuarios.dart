// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/alertas.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/request.dart';
import 'package:proyecto_belcomspa_flutter/screens/usuarios/listarUsuarios.dart';

class CrearUsuarios extends StatefulWidget {
  const CrearUsuarios({super.key});

  @override
  State<CrearUsuarios> createState() => _CrearUsuariosState();
}

class _CrearUsuariosState extends State<CrearUsuarios> {
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
        centerTitle: true,
        title: const Text("Registrar Usuarios"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Card(
          color: const Color.fromARGB(255, 200, 180, 113),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      "Formulario Registro",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: txtNombres,
                      decoration: const InputDecoration(labelText: "Nombres"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por Favor, Introduce tu nombres";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: txtApellidos,
                      decoration: const InputDecoration(labelText: "Apellidos"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por Favor, Introduce tu apellidos";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: txtUsername,
                      decoration: const InputDecoration(labelText: "Username"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por Favor, Introduce tu username";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: txtCorreo,
                      decoration: const InputDecoration(labelText: "Correo"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por Favor, Introduce tu correo";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: txtRol,
                      decoration: const InputDecoration(labelText: "Rol"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por Favor, Introduce tu correo";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: txtEstado,
                      decoration: const InputDecoration(labelText: "Estado"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Por Favor, Introduce tu correo";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: ocultTextOne,
                      obscuringCharacter: '*',
                      controller: txtPassword,
                      decoration: InputDecoration(
                          labelText: "Password",
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
                    TextFormField(
                      obscureText: ocultTextTwo,
                      obscuringCharacter: '*',
                      controller: txtRepeatPassword,
                      decoration: InputDecoration(
                          labelText: "Password",
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final Map<String, dynamic> datos = {
                              "nombres": txtNombres.text,
                              "apellidos": txtApellidos.text,
                              "username": txtUsername.text,
                              "correo": txtCorreo.text,
                              "rol": txtRol.text,
                              "estado": txtEstado.text,
                              "password": txtPassword.text
                            };

                            final apiService = ApiService(url, "usuarios");
                            bool estadoPost =
                                await apiService.postPeticion(datos);

                            if (estadoPost) {
                              Alertas.tipoAlerta(context, 2, "Registro Exitoso",
                                  "Se registro un nuevo usuario en el aplicativo");
                              Future.delayed(const Duration(seconds: 3), () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ListarUsuarios()));
                              });
                            } else {
                              Alertas.tipoAlerta(context, 3, "Error Registro",
                                  "No se pudo registrar el usuario, correo o username existentes.");
                            }
                            _formKey.currentState?.reset();
                          }
                        },
                        child: const Text("Registrar"))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
