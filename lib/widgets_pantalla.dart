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
                  var cursor = document.querySelector('#cursor');
                  if (cursor) {
                      entidad.removeChild(cursor);
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
                  cursor.setAttribute('color', 'rgba(255, 255, 255, 0.1)');
                 cursor.setAttribute('animation_click', 'property: scale; startEvents: click; from: 0.1 0.1 0.1; to: 1 1 1; dur: 150');
                 cursor.setAttribute('animationfusing', 'property: fusing; startEvents: fusing; from: 1 1 1; to: 0.1 0.1 0.1; dur: 1500');
                 cursor.setAttribute('event-setmouseenter', '_event: mouseenter; color: rgba(255, 255, 255, 0.1);');
                 cursor.setAttribute('event-set_mouseleave', '_event: mouseleave; color: rgba(255, 255, 255, 0.1);');
                //cursor.setAttribute('raycaster', 'objects: .link , .circle');
                cursor.setAttribute('raycaster', 'objects: .link, .circle; far: 10; interval: 100');
                cursor.setAttribute('fusing', '0.09999999999999998 0.09999999999999998 0.09999999999999998');
                  entidad.appendChild(cursor);
              }

              function volverAagregarCursor1() {
                var cursor = document.createElement('a-cursor');
                  cursor.setAttribute('id', 'cursor');
                  cursor.setAttribute('color', 'rgba(255, 255, 255, 0.1)');
                  entidad.appendChild(cursor);
              }  

              function establecerColor(){
                if(document.getElementById('cursor')){
                var cursor = document.getElementById('cursor');
                 cursor.setAttribute('color', 'rgba(255, 255, 255, 0.1);');
                 cursor.setAttribute('event-setmouseenter', '_event: mouseenter; rgba(255, 255, 255, 0.1);');
                 cursor.setAttribute('event-set_mouseleave', '_event: mouseleave; rgba(255, 255, 255, 0.1);');
                }
              }

              //funcion agregar propiedad circle

              function agregarCircle(){
                 // Crear un nuevo script con el id "circle"
                var nuevoScript = document.createElement('script');
                nuevoScript.setAttribute('id', 'circle');
                nuevoScript.setAttribute('type', 'text/html');
                nuevoScript.innerHTML = `
                   <a-entity class="circle" geometry="primitive: circle; radius: 1" material="src: \${thumb}" animation__mouseenter="property: scale; to: 1.5 1.5 1.5; dur: 300; startEvents: mouseenter" animation__mouseleave="property: scale; to: 1 1 1; dur: 300; startEvents: mouseleave" event-set__click="_target: #image-360; _delay: 300; material.src: \${src}" proxy-event="event: click; to: #image-360; as: fade" sound="on: click; src: #click-sound"></a-entity>
               `;

                // Agregar el nuevo script al cuerpo del documento o a la cabeza según tu estructura HTML
               document.head.appendChild(nuevoScript);
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

  Widget botonAgregarCursor(bool mostrarBoton, WebViewController? controller) {
    return Visibility(
      visible: mostrarBoton,
      child: IconButton(
        onPressed: () async {
          // print("eliminando puntito");
          // Cambiar la URL del WebView

          await controller!.runJavaScript('''
           volverAagregarCursor(); // Volver a agregar el cursor
            // establecerColor();
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
