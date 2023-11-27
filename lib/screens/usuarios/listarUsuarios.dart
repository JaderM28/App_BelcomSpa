// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/alertas.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/request.dart';
import 'package:proyecto_belcomspa_flutter/peticiones/sesion.dart';
import 'package:proyecto_belcomspa_flutter/screens/usuarios/crearUsuarios.dart';
import 'package:proyecto_belcomspa_flutter/screens/usuarios/editarUsuarios.dart';
import 'package:proyecto_belcomspa_flutter/themes/themes.dart';

class ListarUsuarios extends StatefulWidget {
  const ListarUsuarios({super.key});

  @override
  State<ListarUsuarios> createState() => _ListarUsuariosState();
}

class _ListarUsuariosState extends State<ListarUsuarios> {
  final apiService = ApiService(
      "https://backend-valhalla.onrender.com/ruta/usuarios", "usuarios");
  List<dynamic> listData = [];
  List<dynamic> originalData = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    listData = await apiService.getPeticion();
    originalData = List.from(listData);
    setState(
        () {}); // Actualiza el estado para reconstruir el widget con los datos cargados.
  }

  void busquedaUsuarios(String consulta) {
    setState(() {
      listData = originalData
          .where((item) => item['username']
              .toString()
              .toLowerCase()
              .contains(consulta.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final sesionProvider = Provider.of<SesionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF776B5D),
        centerTitle: true,
        title: const Text("Gestionar Usuarios", style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold,),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.brightness_4,
                size: 30,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                size: 30,
              ),
              onPressed: () {
                sesionProvider.cerrarSesion(context);
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (consulta) {
                busquedaUsuarios(consulta);
              },
              decoration: const InputDecoration(
                hintText: "Buscar usuario..",
                icon: Icon(Icons.search)
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
                //este builder se comporta como un foreach
                itemCount: listData.length, //Obtiene la cantidad de elementos
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ExpansionTile(
                      backgroundColor: const Color.fromARGB(255, 191, 190, 188),
                      title: Text(
                          "Username: ${listData[index]['username'].toString()}"),
                      subtitle: Text(
                          "Correo: ${listData[index]['correo'].toString()}"),
                      leading: const Icon(Icons.person),
                      expandedAlignment: Alignment.centerLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            color: const Color.fromARGB(255, 221, 217, 217),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Center(
                                      child: Text(
                                    "Datos del Usuario",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Nombre: ${listData[index]['nombres'].toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "Apellido: ${listData[index]['apellidos'].toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "Username: ${listData[index]['username'].toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "Correo: ${listData[index]['correo'].toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "Rol: ${listData[index]['rol'].toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "Estado: ${(listData[index]['estado'].toString() == "true") ? "Activo" : "Inactivo"}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditarUsuarios(
                                                                idUsuario: listData[
                                                                            index]
                                                                        ['_id']
                                                                    .toString(),
                                                                datos: listData[
                                                                    index])));
                                              });
                                            },
                                            child: const Text("Editar")),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              bool confirmacion =
                                                  await Alertas.tipoAlerta(
                                                      context,
                                                      1,
                                                      "¿Esta seguro de Eliminar?",
                                                      "Se eliminara el usuario actual y no se podra volver a recuperar");

                                              if (confirmacion) {
                                                final Map<String, dynamic>
                                                    idDatos = {
                                                  "_id": listData[index]['_id']
                                                      .toString(),
                                                };

                                                bool estadoDelete =
                                                    await apiService
                                                        .deletePeticion(
                                                            idDatos);

                                                if (estadoDelete) {
                                                  Alertas.success(context);
                                                } else {
                                                  Alertas.tipoAlerta(
                                                      context,
                                                      3,
                                                      "Error Modificacion",
                                                      "No se pudo modificar el usuario, la peticion tuvo fallas.");
                                                }
                                              }
                                            },
                                            child: const Text("Eliminar"))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const CrearUsuarios()));
            });
          },
          child: const Icon(Icons.add)),
    );
  }
}
