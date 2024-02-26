import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WidgetsPantalla {
  Widget circuloProgreso(bool mostrarPantallaCarga) {
    return Visibility(
      visible: mostrarPantallaCarga,
      child: Container(
        alignment: Alignment.center,
        child: Material(
            color: const Color.fromARGB(200, 0, 0, 0),
            child: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )),
      ),
    );
  }

  Widget ventanaNavegadorBasico(
      bool mostrarPantallaCarga, WebViewController? controller) {
    return Visibility(
      visible: !mostrarPantallaCarga,
      child: WebViewWidget(controller: controller!),
    );
  }

  Future mostrarVentana(String message, BuildContext context) async {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Aviso'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
