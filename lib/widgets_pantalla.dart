// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

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

  Widget botonPruebas(bool mostrarBoton, WebViewController? controller) {
    return Visibility(
      visible: mostrarBoton,
      child: IconButton(
        onPressed: () async {
          // print("eliminando puntito");
          // Cambiar la URL del WebView

          await controller!.runJavaScript('''
            var icon = document.getElementById("cursor");
    
      
            //removemos el cursor (PRUEBAA)

            if(icon){
              // icon.remove();
              // alert("removido con exitooo el icono...");
            }


             // ASIGNAR ID AL <a-scene>
             var escena = document.querySelector('a-scene');

             // Asignar un ID al elemento <a-scene>
             escena.id = 'miEscena';

             if(document.getElementById('miEscena')){
              //alert("agregado al a-scene");
             }

             // ASIGNAR ID AL <a-entity>
             var entidad = document.querySelector('a-entity');

             // Asignar un ID al elemento <a-entity>
             entidad.id = 'miIdDeEntidad';

             if(document.getElementById('miIdDeEntidad')){
              //alert("agregada al a-entity");
             }

              //PONER Y QUITAR BOTÓN CURSOR
              // Obtener el elemento <a-entity>
              var entidad = document.querySelector('#miIdDeEntidad');

              // Función para quitar el cursor
              function quitarCursor() {
                  var cursor = document.getElementById('cursor');
                  if (cursor) {
                      cursor.remove();
                  }
              }

              function quitarCursor1() {
                  var cursor1 = document.getElementById('circle');
                  if (cursor1) {
                      cursor1.remove();
                  }
              }

              // Función para volver a agregar el cursor
              function volverAagregarCursor() {
                 var cursor = document.createElement('a-cursor');
                 cursor.setAttribute('id', 'cursor');
                  cursor.setAttribute('scale', '0.1 0.1 0.1');
                  cursor.setAttribute('animation_click', 'property: scale; startEvents: click; from: 0.1 0.1 0.1; to: 1 1 1; dur: 150');
                  cursor.setAttribute('animationfusing', 'property: fusing; startEvents: fusing; from: 1 1 1; to: 0.1 0.1 0.1; dur: 1500');
                  cursor.setAttribute('event-setmouseenter', '_event: mouseenter; color: springgreen;');
                  cursor.setAttribute('event-set_mouseleave', '_event: mouseleave; color: rgba(255, 255, 255, 0.1);');
                  cursor.setAttribute('raycaster', 'objects: .link , .circle');
                 // cursor.setAttribute('raycaster', 'objects: .link, .circle; far: 10; interval: 100');
                 entidad.appendChild(cursor);
              }

              function volverAagregarCursor1() {
                var cursor = document.createElement('a-cursor');
                  cursor.setAttribute('id', 'cursor');
                  cursor.setAttribute('color', 'rgba(255, 255, 255, 0.1)');
                  entidad.appendChild(cursor);
              }  
              function volverAagregarCursor2() {
                var cursor = document.createElement('a-cursor');
                  cursor.setAttribute('id', 'cursor');
                  cursor.setAttribute('scale', '0.5 0.5 0.5');
                  alert("sip");
                  entidad.appendChild(cursor);
              }  

              function establecerColor(){
                if(document.getElementById('cursor')){
                  var cursor = document.getElementById('cursor');

                  cursor.removeAttribute('animation_click');
                  cursor.removeAttribute('animationfusing');
                  cursor.removeAttribute('event-setmouseenter');
                  cursor.removeAttribute('event-set_mouseleave');
                  cursor.removeAttribute('raycaster');

                  cursor.setAttribute('scale', '0.06 0.06 0.06');
                  cursor.setAttribute('color', 'rgba(255, 255, 255, 0.1);');
                  cursor.setAttribute('animation_click', 'property: scale; startEvents: click; from: 0.1 0.1 0.1; to: 1 1 1; dur: 150');
                  cursor.setAttribute('animationfusing', 'property: fusing; startEvents: fusing; from: 1 1 1; to: 0.1 0.1 0.1; dur: 1500');
                  cursor.setAttribute('event-setmouseenter', '_event: mouseenter; color: springgreen;');
                  cursor.setAttribute('event-set_mouseleave', '_event: mouseleave; color: rgba(255, 255, 255, 0.1);');
                  cursor.setAttribute('raycaster', 'objects: .link , .circle');
                }
              }

             
           ''');
        },
        icon: const Icon(
          Icons.confirmation_num,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget botonQuitarCursor(bool mostrarBoton, WebViewController? controller) {
    return Visibility(
      visible: mostrarBoton,
      child: IconButton(
        onPressed: () async {
          // print("eliminando puntito");
          // Cambiar la URL del WebView

          await controller!.runJavaScript('''
            quitarCursor(); // Quitar el cursor
            // quitarCursor1(); // Quitar el estilo del circle
           ''');
        },
        icon: const Icon(
          Icons.delete,
          size: 40,
          color: Color.fromARGB(255, 163, 23, 13),
        ),
      ),
    );
  }

  Widget imprimirCodigoFuente(
      bool mostrarBoton, WebViewController? controller) {
    return Visibility(
      visible: mostrarBoton,
      child: IconButton(
        onPressed: () async {
          // print("eliminando puntito");
          // Cambiar la URL del WebView

          await controller!.runJavaScript('''
            console.log(document.documentElement.outerHTML);
           ''');

          Object _resultadoPrint = await controller!
              .runJavaScriptReturningResult(
                  "document.documentElement.outerHTML");
          String _codigoFuente = "$_resultadoPrint";

          // print("el codigo fuente es: $_codigoFuente");
        },
        icon: const Icon(
          Icons.print,
          size: 40,
          color: Color.fromARGB(255, 4, 97, 58),
        ),
      ),
    );
  }

  Widget establecerJscript(bool mostrarBoton, WebViewController? controller) {
    return Visibility(
      visible: mostrarBoton,
      child: IconButton(
        onPressed: () async {
          await controller!.runJavaScript('''
            var miEscena = document.querySelector('a-scene');

            if (miEscena) {
              // Agrega el nuevo atributo vr-mode-ui="enabled: true"
              miEscena.setAttribute('vr-mode-ui', 'enabled: true');
                 
            }  
           ''');
        },
        icon: const Icon(
          Icons.javascript,
          size: 40,
          color: Color.fromARGB(255, 4, 97, 58),
        ),
      ),
    );
  }

  Widget botonAgregarCursor(bool mostrarBoton, WebViewController? controller) {
    return Visibility(
      visible: mostrarBoton,
      child: IconButton(
        onPressed: () async {
          // print("eliminando puntito");
          // Cambiar la URL del WebView

          await controller!.runJavaScript('''
          // volverAagregarCursor(); // Volver a agregar el cursor
          establecerColor();
           ''');
        },
        icon: const Icon(
          Icons.add,
          size: 40,
          color: Color.fromARGB(255, 12, 101, 173),
        ),
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
