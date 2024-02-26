// ignore_for_file: avoid_print, no_leading_underscores_for_local_identifiers, unused_element, unused_local_variable, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fullscreen_window/fullscreen_window.dart';
import 'package:proyect/widgets_pantalla.dart';
import 'package:proyect/providers.dart';
import 'package:webview_flutter/webview_flutter.dart';

//Variable con la dirección URL
const String _direccionURL = 'https://netrabbitonline.shop/travevr/';
const String _urlModoRV = 'https://netrabbitonline.shop/travevr/vr.php?';
const String _direccionURL1 =
    'https://netrabbitonline.shop/travevr/vr.php?id=4';
const String _direccionURLSalida =
    "https://netrabbitonline.shop/travevr/index.php?s=1";

WebViewController? _controller;
int _tiempo = 1;
//clase de la pantalla de carga
WidgetsPantalla _widget = WidgetsPantalla();

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
    bool existeGiroscopio = false;

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

          if (!currentUrl.contains(_urlModoRV)) {
            // Cambia la orientación de nuevo a vertical
            await SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);

            Object retVal1 = await _controller!
                .runJavaScriptReturningResult("deviceHasGyroscope");

            existeGiroscopio = bool.parse("$retVal1");

            if (ref.watch(mostrarBotonSalida) == true) {
              ref.read(mostrarBotonSalida.notifier).update((state) => false);
            }

            if (ref.watch(visibleBotonRV) == true) {
              print("cambiando estoo");
              _tiempo = 100000;
              await Future.delayed(
                const Duration(seconds: 1),
              ); // tiempo que debe pasar para después continuar con la actualización del provider
              ref.read(visibleBotonRV.notifier).update((state) => false);
            }
          }

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
              ref.read(mostrarPantallaCarga.notifier).update((state) => true);

              ref.read(visibleBotonRV.notifier).update((state) => true);
              for (int f = 0; f < 2; f++) {
                while (true && existeGiroscopio) {
                  bool _valor = await _controller!.runJavaScript('''


                // Obtiene el elemento por su clase
                var vrButtonContainer = document.querySelector('.a-enter-vr.fullscreen');
                var vrButtonContainer2 = document.querySelector('.a-enter-vr.a-hidden');

                var icon = document.getElementById("cursor");
    
                // Remueve la clase 'fullscreen' del elemento si existe
                    if (vrButtonContainer) {
                        vrButtonContainer.classList.remove('fullscreen');
                	//alert("removido con exitooo");
                   }

                   if (vrButtonContainer2) {
                    //creamos una nueva variable llamada

                    
                       vrButtonContainer2.classList.remove('a-hidden');
	                //alert("removido con exitooo 2");


                    var nuevoDiv = document.createElement("div");

                    // Asignar un ID al nuevo div
                    nuevoDiv.id = "verBotonRV";

                    // Puedes agregar más contenido o estilos al div si lo deseas
                    nuevoDiv.innerHTML = "";

                    // Insertar el nuevo div al final del body
                    document.body.appendChild(nuevoDiv);

                     
                   }

                   //removemos el cursor (PRUEBAA)

                   if(icon){
                    //icon.remove();
                    //alert("removido con exitooo el icono...");
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

              //primero guardamos el valor en una variable Javascript sobre si el botón existe o no
              await _controller!.runJavaScript('''
              var existeButon = false;
              var buton1 = document.getElementById("verBotonRV");
               if(buton1){
                existeButon=true;
               }else{
                existeButon=false;
               }
              ''');

              //hacemos una comprobación de si existe el boton de realidad virtual (servirá más adelante)
              Object _resultado = await _controller!
                  .runJavaScriptReturningResult("existeButon");

              ref.read(mostrarPantallaCarga.notifier).update((state) => false);
            }

            //si no se está mostrando la "x" de salida, entonces la mostraremos
            if (ref.watch(mostrarBotonSalida) == false) {
              ref.read(mostrarBotonSalida.notifier).update((state) => true);
            }

            if (!existeGiroscopio) {
              await Future.delayed(
                const Duration(seconds: 1),
              );

              _widget.mostrarVentana(
                  "El teléfono no es compatible con Realidad Virtual...",
                  context);
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
    // bool _mostrarBarraProgresoProvider = ref.watch(mostrarPantallaCarga);
    bool _mostrarBotonSalidaProvider = ref.watch(mostrarBotonSalida);

    return SafeArea(
      minimum: const EdgeInsets.all(0),
      child: Scaffold(
          body: Stack(
            children: [
              _widget.ventanaNavegadorBasico(false, _controller!),
              _widget.circuloProgreso(false),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniStartTop,
          floatingActionButton: Visibility(
            visible: _mostrarBotonSalidaProvider,
            child: IconButton(
              onPressed: () async {
                print("saliendo");
                // Cambiar la URL del WebView
                await _controller?.loadRequest(Uri.parse(_direccionURLSalida));
              },
              icon: const Icon(
                Icons.close,
                size: 40,
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
