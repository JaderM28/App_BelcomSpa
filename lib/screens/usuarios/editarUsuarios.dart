// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/alertas.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/request.dart';

class EditarUsuarios extends StatefulWidget {
  String idUsuario;
  dynamic datos;

  EditarUsuarios({super.key, required this.idUsuario, required this.datos});

  @override
  State<EditarUsuarios> createState() => _EditarUsuariosState();
}

class _EditarUsuariosState extends State<EditarUsuarios> {
  final apiService = ApiService(
      "https://backend-valhalla.onrender.com/ruta/usuarios", "usuarios");
  final _formKey = GlobalKey<FormState>();

  late TextEditingController txtNombres;
  late TextEditingController txtApellidos;
  late TextEditingController txtUsername;
  late TextEditingController txtCorreo;
  late TextEditingController txtRol;
  late TextEditingController txtEstado;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    setState(() {
      txtNombres = TextEditingController(text: widget.datos['nombres']);
      txtApellidos = TextEditingController(text: widget.datos['apellidos']);
      txtUsername = TextEditingController(text: widget.datos['username']);
      txtCorreo = TextEditingController(text: widget.datos['correo']);
      txtRol = TextEditingController(text: widget.datos['rol']);
      txtEstado = TextEditingController(text: widget.datos['estado'].toString());
    }); // Actualiza el estado para reconstruir el widget con los datos cargados.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Editar Usuarios"),
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
                      "Formulario de Editar",
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
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          
                          final Map<String, dynamic> datos = {
                            "_id": widget.idUsuario,
                            "nombres": txtNombres.text,
                            "apellidos": txtApellidos.text,
                            "username": txtUsername.text,
                            "correo": txtCorreo.text,
                            "rol": txtRol.text,
                            "estado": txtEstado.text,
                          };

                          bool confirmacion = await Alertas.tipoAlerta(context, 1, "Esta seguro de Editar",
                                "Se modificaran los valores actuales y no se podra volver a restaurar");

                          if(confirmacion){
                            bool estadoPut =
                              await apiService.putPeticion(datos);

                            if (estadoPut){
                              Alertas.success(context);
                            }else{
                              Alertas.tipoAlerta(context, 3, "Error Modificacion",
                                  "No se pudo modificar el usuario, la peticion tuvo fallas.");
                            }

                            _formKey.currentState?.reset();
                          }

                        }
                      },
                      child: const Text("Continuar"))
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
