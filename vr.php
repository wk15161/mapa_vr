<?php
$id = $_REQUEST["id"];

if ($id == "1") { // Plazaidentidad
    $img = "plazaidentidad.jpg";
} else if ($id == "2") { // AF
    $img = "af.jpg";
} else if ($id == "3") { // BD
    $img = "bd.jpg";
} else if ($id == "4") { // BF
    $img = "bf.jpg";
} else if ($id == "5") { // CF
    $img = "cf.jpg";
} else if ($id == "6") { // H
    $img = "df.jpg";
} else if ($id == "7") { // ED
    $img = "h.jpg";
} else if ($id == "8") { // ED
    $img = "ed.jpg";
} else if ($id == "9") { // EF
    $img = "ef.jpg";
} else if ($id == "10") { // Estacionamiento
    $img = "estacionamiento.jpg";
} else if ($id == "11") { // FF
    $img = "ff.jpg";
} else if ($id == "12") { // FF2
    $img = "ff2.jpg";
} else if ($id == "13") { // I
    $img = "i.jpg";
} else if ($id == "14") { // IF
    $img = "if.jpg";
} else if ($id == "15") { // Jardincafe
    $img = "jardincafe.jpg";
} else if ($id == "16") { // Canchas
    $img = "canchas.jpg";
} else if ($id == "17") { // D
    $img = "d.jpg";
} else if ($id == "18") { // Canchas
    $img = "mac.jpg";
} else if ($id == "19") { // D
    $img = "hc.jpg";
} else if ($id == "20") { // D
    $img = "biblioteca.jpg";
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="description" content="Recorrido en 360° por UPVT | TraveVR">

    <title>Recorrido en 360° | TraveVR</title>

    <!-- Favicon -->
    <link href="assets/images/icon.png" rel="icon">

    <!-- A-Frame -->
    <script src="https://aframe.io/releases/1.4.0/aframe.min.js"></script>
    <script src="https://unpkg.com/aframe-event-set-component@5/dist/aframe-event-set-component.min.js"></script>
    <script src="https://unpkg.com/aframe-layout-component@5.3.0/dist/aframe-layout-component.min.js"></script>
    <script src="https://unpkg.com/aframe-template-component@3.2.1/dist/aframe-template-component.min.js"></script>
    <script
        src="https://unpkg.com/aframe-proxy-event-component@2.1.0/dist/aframe-proxy-event-component.min.js"></script>

    <!-- Propiedades Generales -->
    <script id="link" type="text/html">
        <a-entity class="link" geometry="primitive: plane; height: 1; width: 1" material="src: ${thumb}" animation__mouseenter="property: scale; to: 1.5 1.5 1.5; dur: 300; startEvents: mouseenter" animation__mouseleave="property: scale; to: 1 1 1; dur: 300; startEvents: mouseleave" event-set__click="_target: #image-360; _delay: 300; material.src: ${src}" proxy-event="event: click; to: #image-360; as: fade" sound="on: click; src: #click-sound"></a-entity>
    </script>
    <script id="circle" type="text/html">
        <a-entity class="circle" geometry="primitive: circle; height: 1; width: 1" material="src: ${thumb}" animation__mouseenter="property: scale; to: 1.5 1.5 1.5; dur: 300; startEvents: mouseenter" animation__mouseleave="property: scale; to: 1 1 1; dur: 300; startEvents: mouseleave" event-set__click="_target: #image-360; _delay: 300; material.src: ${src}" proxy-event="event: click; to: #image-360; as: fade" sound="on: click; src: #click-sound"></a-entity>
    </script>
</head>

<body>
    <?php
    if ($img != "") {
        ?>
        <a-scene>
            <!-- Cursor -->
            <a-entity camera look-controls>
                <!-- ORIGINAL -->
                <!-- <a-cursor id="cursor" color="white"
                    animation__click="property: scale; startEvents: click; from: 0.1 0.1 0.1; to: 1 1 1; dur: 150"
                    animation__fusing="property: fusing; startEvents: fusing; from: 1 1 1; to: 0.1 0.1 0.1; dur: 1500"
                    event-set__mouseenter="_event: mouseenter; color: springgreen;"
                    event-set__mouseleave="_event: mouseleave; color: white;" raycaster="objects: .link , .circle">
                </a-cursor> -->

                <!-- HEDER (INICIO) -->
                <?php if ($_REQUEST['appMovil'] && !empty($_REQUEST['appMovil'])) {
                    $valorEscala = "0.025";
                    $valorAumento = "0.060";
                    $varAppMovil = $_REQUEST['appMovil'];
                    ?>
                    <a-cursor id="cursor" color="white"
                        animation__click="property: scale; startEvents: click; from: <?php echo ("$valorEscala $valorEscala $valorEscala"); ?>; to: <?php echo ("$valorAumento $valorAumento $valorAumento"); ?>; dur: 150"
                        animation__fusing="property: fusing; startEvents: fusing; from: <?php echo ("$valorAumento $valorAumento $valorAumento"); ?>; to: <?php echo ("$valorEscala $valorEscala $valorEscala"); ?>; dur: 1500"
                        event-set__mouseenter="_event: mouseenter; color: springgreen;"
                        event-set__mouseleave="_event: mouseleave; color: white;" raycaster="objects: .link , .circle">
                    </a-cursor>
                    <?php
                    if ($varAppMovil == '1') {
                        echo ("
                        <script>
                        var cursor = document.getElementById('cursor');
                        if(cursor){
                            cursor.setAttribute('scale', '$valorEscala $valorEscala $valorEscala');
                        }
                        </script>
                        ");
                    }
                } else { ?>

                    <a-cursor id="cursor" color="white"
                        animation__click="property: scale; startEvents: click; from: 0.1 0.1 0.1; to: 1 1 1; dur: 150"
                        animation__fusing="property: fusing; startEvents: fusing; from: 1 1 1; to: 0.1 0.1 0.1; dur: 1500"
                        event-set__mouseenter="_event: mouseenter; color: springgreen;"
                        event-set__mouseleave="_event: mouseleave; color: white;" raycaster="objects: .link , .circle">
                    </a-cursor>

                <?php } ?>
                <!-- HEDER (FIN) -->
            </a-entity>

            <a-assets>
                <!-- Sonido -->
                <audio id="click-sound" src="https://cdn.aframe.io/360-image-gallery-boilerplate/audio/click.ogg"></audio>

                <!------------------------------------ Imágenes ------------------------------------>

                <!-- Salir -->
                <img id="salir" src="assets/images/salir2.jpg">

                <!-- Mostrada al inicio -->
                <img id="inicio" src="assets/images/360/<?php echo $img; ?>" />

                <!-- 1 -->
                <img id="plazaidentidad" src="assets/images/360/plazaidentidad.jpg" />
                <img id="plazaidentidads" src="assets/images/360/plazaidentidads.png" />
                <img id="af" src="assets/images/360/af.jpg" />
                <img id="afs" src="assets/images/360/afs.png" />
                <img id="bf" src="assets/images/360/bf.jpg" />
                <img id="bfs" src="assets/images/360/bfs.png" />
                <img id="bd" src="assets/images/360/bd.jpg" />
                <img id="bds" src="assets/images/360/bds.png" />
                <img id="if" src="assets/images/360/if.jpg" />
                <img id="ifs" src="assets/images/360/ifs.png" />

                <!-- 2 -->
                <img id="i" src="assets/images/360/i.jpg" />
                <img id="is" src="assets/images/360/is.png" />
                <img id="canchas" src="assets/images/360/canchas.jpg" />
                <img id="canchass" src="assets/images/360/canchass.png" />
                <img id="estacionamiento" src="assets/images/360/estacionamiento.jpg" />
                <img id="estacionamientos" src="assets/images/360/estacionamientos.png" />
                <img id="cf" src="assets/images/360/cf.jpg" />
                <img id="cfs" src="assets/images/360/cfs.png" />
                <img id="jardincafe" src="assets/images/360/jardincafe.jpg" />
                <img id="jardincafes" src="assets/images/360/jardincafes.png" />

                <!-- 3 -->
                <img id="ef" src="assets/images/360/ef.jpg" />
                <img id="efs" src="assets/images/360/efs.png" />
                <img id="ed" src="assets/images/360/ed.jpg" />
                <img id="eds" src="assets/images/360/eds.png" />
                <img id="ff2" src="assets/images/360/ff2.jpg" />
                <img id="ff2s" src="assets/images/360/ff2s.png" />
                <img id="ff" src="assets/images/360/ff.jpg" />
                <img id="ffs" src="assets/images/360/ffs.png" />
                <img id="df" src="assets/images/360/df.jpg" />
                <img id="dfs" src="assets/images/360/dfs.png" />

                <!-- 4 -->
                <img id="mac" src="assets/images/360/mac.jpg" />
                <img id="macs" src="assets/images/360/macs.png" />
                <img id="d" src="assets/images/360/d.jpg" />
                <img id="ds" src="assets/images/360/ds.png" />
                <img id="h" src="assets/images/360/h.jpg" />
                <img id="hs" src="assets/images/360/hs.png" />
                <img id="hc" src="assets/images/360/hc.jpg" />
                <img id="hcs" src="assets/images/360/hcs.png" />
                <img id="biblioteca" src="assets/images/360/biblioteca.jpg" />
                <img id="bibliotecas" src="assets/images/360/bibliotecas.png" />

            </a-assets>

            <!-- Imagenes -->
            <a-entity id="links" layout="type: line; margin: 1.3" position="-2 0 -4">
                <a-entity template="src: #link" data-src="#plazaidentidad" data-thumb="#plazaidentidads"></a-entity>
                <a-entity template="src: #link" data-src="#af" data-thumb="#afs"></a-entity>
                <a-entity template="src: #link" data-src="#bf" data-thumb="#bfs"></a-entity>
                <a-entity template="src: #link" data-src="#bd" data-thumb="#bds"></a-entity>
                <a-entity template="src: #link" data-src="#if" data-thumb="#ifs"></a-entity>
            </a-entity>
            <a-entity id="links" layout="type: line; margin: 1.3" position="-2 -1.3 -4" rotation="-10 0 0">
                <a-entity template="src: #link" data-src="#i" data-thumb="#is"></a-entity>
                <a-entity template="src: #link" data-src="#estacionamiento" data-thumb="#estacionamientos"></a-entity>
                <a-entity template="src: #link" data-src="#canchas" data-thumb="#canchass"></a-entity>
                <a-entity template="src: #link" data-src="#cf" data-thumb="#cfs"></a-entity>
                <a-entity template="src: #link" data-src="#jardincafe" data-thumb="#jardincafes"></a-entity>
            </a-entity>
            <a-entity id="links" layout="type: line; margin: 1.3" position="-2 -2.6 -3.5" rotation="-20 0 0">
                <a-entity template="src: #link" data-src="#ef" data-thumb="#efs"></a-entity>
                <a-entity template="src: #link" data-src="#ed" data-thumb="#eds"></a-entity>
                <a-entity template="src: #link" data-src="#ff2" data-thumb="#ff2s"></a-entity>
                <a-entity template="src: #link" data-src="#ff" data-thumb="#ffs"></a-entity>
                <a-entity template="src: #link" data-src="#df" data-thumb="#dfs"></a-entity>
            </a-entity>
            <a-entity id="links" layout="type: line; margin: 1.3" position="-2 -3.4 -2.5" rotation="-40 0 0">
                <a-entity template="src: #link" data-src="#mac" data-thumb="#macs"></a-entity>
                <a-entity template="src: #link" data-src="#d" data-thumb="#ds"></a-entity>
                <a-entity template="src: #link" data-src="#h" data-thumb="#hs"></a-entity>
                <a-entity template="src: #link" data-src="#hc" data-thumb="#hcs"></a-entity>
                <a-entity template="src: #link" data-src="#biblioteca" data-thumb="#bibliotecas"></a-entity>
            </a-entity>
            <a-entity id="links" layout="type: line; margin: 1.3" position="0 -10 -3" rotation="-70 0 0">
                <a-entity template="src: #circle" data-src="#" data-thumb="#salir"
                    onclick="window.location.href = 'index.php?s=1';"></a-entity>
            </a-entity>

            <!-- Escena Mostrada -->
            <a-sky id="image-360" src="#inicio"
                animation__fade="property: components.material.material.color; type: color; from: #FFF; to: #000; dur: 300; startEvents: fade"
                animation__fadeback="property: components.material.material.color; type: color; from: #000; to: #FFF; dur: 300; startEvents: animationcomplete__fade"></a-sky>
        </a-scene>
        <?php
    }
    ?>
</body>

</html>