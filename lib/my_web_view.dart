// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:proyect/providers.dart';
import 'package:webview_flutter/webview_flutter.dart';

//Variable con la dirección URL
const String _direccionURL = 'https://netrabbitonline.shop/mapavr/';
const String _urlModoRV = 'https://netrabbitonline.shop/mapavr/vr.php?';
const String _direccionURL1 = 'https://netrabbitonline.shop/mapavr/vr.php?id=4';

WebViewController? _controller;

//Clase "MyWebView" utilizada para cargar una vista de navegador web clásico Android con la dirección URL
class MyWebView extends ConsumerStatefulWidget {
  const MyWebView({super.key});

  @override
  MyWebViewState createState() => MyWebViewState();
}

class MyWebViewState extends ConsumerState<MyWebView> {
//Esta función permite establecer estados o inicializar variables al terminar de cargar los widget
  @override
  void initState() {
    super.initState();
    //llama a la función para activar la pantalla completa
    setFullScreen(true);

    // variable que establece el controlador de la vista Web (IMPORTANTE)
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(_direccionURL))
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (change) {
          print("Ha cambiado la url");
        },
        onPageFinished: (currentUrl) async {
          print("la url ($currentUrl) ha terminado de cargaaar");

          if (currentUrl.contains(_urlModoRV)) {
            print("El texto principal si existeeee");

            // Configura la orientación a lateral
            await SystemChrome.setPreferredOrientations([
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight,
            ]);

            await Future.delayed(
              const Duration(seconds: 3),
            ); // tiempo que debe pasar para después continuar con la actualización del provider
            if (ref.watch(visibleBotonRV) == false) {
              ref.read(visibleBotonRV.notifier).update((state) => true);
              for (int f = 0; f < 2; f++) {
                while (true) {
                  bool _valor = await _controller!.runJavaScript('''
                // Obtiene el elemento por su clase
                var vrButtonContainer = document.querySelector('.a-enter-vr.fullscreen');
                var vrButtonContainer2 = document.querySelector('.a-enter-vr.a-hidden');
    
                // Remueve la clase 'fullscreen' del elemento si existe
                    if (vrButtonContainer) {
                        vrButtonContainer.classList.remove('fullscreen');
                	//alert("removido con exitooo");
                   }

                   if (vrButtonContainer2) {
                       vrButtonContainer2.classList.remove('a-hidden');
	                //alert("removido con exitooo 2");
                   }
                ''').then((value) {
                    print(
                        "se ejecutó bieeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeen :D");
                    return true;
                  }).onError((error, stackTrace) {
                    print(
                        "ocurrió un errooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooor");
                    return false;
                  });
                  if (_valor) {
                    break;
                  }
                }
              }
            }
          } else {
            if (ref.watch(visibleBotonRV) == true) {
              ref.read(visibleBotonRV.notifier).update((state) => false);

              // Cambia la orientación de nuevo a vertical
              await SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
            }
          }
        },
      ));
  }

//Activa/desactiva la pantalla completa
  void setFullScreen(bool isFullScreen) {
    FullScreenWindow.setFullScreen(isFullScreen);
  }

//Función que retorna una función con nombre "build", esa función retorna una variable de tipo "Widget"
  @override
  Widget build(BuildContext context) {
    // Obtiene el tamaño de la pantalla
    // final Size _screenSize = MediaQuery.of(context).size;
    // bool _visibilidadProvider = ref.watch(visibleBotonRV);
    return SafeArea(
      minimum: const EdgeInsets.all(0),
      child: Scaffold(
        body: WebViewWidget(controller: _controller!),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        floatingActionButton: const Text(""),
      ),
    );
  }
}
