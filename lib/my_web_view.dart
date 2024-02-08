// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:proyect/providers.dart';
import 'package:webview_flutter/webview_flutter.dart';

//Variable con la dirección URL
const String _direccionURL = 'https://netrabbitonline.shop/mapavr/';
const String _urlModoRV = 'https://netrabbitonline.shop/mapavr/vr.php?';

//Clase "MyWebView" utilizada para cargar una vista de navegador web clásico Android con la dirección URL
class MyWebView extends ConsumerStatefulWidget {
  const MyWebView({super.key});

  @override
  MyWebViewState createState() => MyWebViewState();
}

class MyWebViewState extends ConsumerState<MyWebView> {
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

    Timer.periodic(const Duration(seconds: 1), (timer) async {
      // Actualiza la interfaz de usuario con el tiempo transcurrido
      var currentUrl = await _controller.currentUrl();
      print("la variables en resultado es: $currentUrl");

      if (currentUrl!.contains(_urlModoRV)) {
        print("El texto principal si existeeee");
        await Future.delayed(
          const Duration(seconds: 2),
        ); // tiempo que debe pasar para después continuar con la actualización del provider
        if (ref.watch(visibleBotonRV) == false) {
          ref.read(visibleBotonRV.notifier).update((state) => true);
        }
      } else {
        if (ref.watch(visibleBotonRV) == true) {
          ref.read(visibleBotonRV.notifier).update((state) => false);
        }
      }
    });
  }

//Activa/desactiva la pantalla completa
  void setFullScreen(bool isFullScreen) {
    FullScreenWindow.setFullScreen(isFullScreen);
  }

//Función que retorna una función con nombre "build", esa función retorna una variable de tipo "Widget"
  @override
  Widget build(BuildContext context) {
    bool _visibilidadProvider = ref.watch(visibleBotonRV);
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: _controller),
        floatingActionButton: Visibility(
          visible: _visibilidadProvider,
          child: FloatingActionButton(
            onPressed: () async {},
            child: const Text("RV"),
          ),
        ),
      ),
    );
  }
}
