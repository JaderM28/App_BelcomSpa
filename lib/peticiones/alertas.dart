import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_belcomspa_flutter/screens/usuarios/listarUsuarios.dart';

class Alertas {

  static Future<bool> tipoAlerta(
    BuildContext context,
    int opcion,
    String titulo,
    String descripcion,
  ) async {
    Completer<bool> completer = Completer();

    switch (opcion) {
      case 1:
        AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: titulo,
            desc: descripcion,
            width: 600,
            btnCancelOnPress: () {
              completer.complete(false);
            },
            btnOkOnPress: () {
              completer.complete(true);
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const ListarUsuarios()));
              });
            }).show();
        break;

      case 2:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.topSlide,
          showCloseIcon: true,
          title: titulo,
          desc: descripcion,
          width: 350,
          
        ).show();
      break;
      case 3:
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.topSlide,
          showCloseIcon: false,
          title: titulo,
          desc: descripcion,
          width: 350,
          autoHide: const Duration(seconds: 5),
        ).show();
      break;
    }

    return completer.future;
  }

  //Alerta Eliminar

  //Alerta Success
  static Future<bool> success(BuildContext context) async {
    Completer<bool> completer = Completer();
    AwesomeDialog(
      context: context,
      width: 350,
      dialogType: DialogType.success,
      animType: AnimType.topSlide,
      showCloseIcon: true,
      title: 'Exitoso',
    ).show();
    return completer.future;
  }
}
