import 'package:flutter/material.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:webview_flutter/webview_flutter.dart';

//Variable con la dirección URL
const String _direccionURL = 'https://netrabbitonline.shop/mapavr/';

//Clase "MyWebView" utilizada para cargar una vista de navegador web clásico Android con la dirección URL
class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  // variable que establece el controlador de la vista Web (IMPORTANTE)
  final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(_direccionURL));

//Esta función permite establecer estados o inicializar variables al terminar de cargar los widget
  @override
  void initState() {
    super.initState();
    //llama a la función para activar la pantalla completa
    setFullScreen(true);
  }

//Activa/desactiva la pantalla completa
  void setFullScreen(bool isFullScreen) {
    FullScreenWindow.setFullScreen(isFullScreen);
  }

//Función que retorna una función con nombre "build", esa función retorna una variable de tipo "Widget"
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text(''),
        // ),

        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
