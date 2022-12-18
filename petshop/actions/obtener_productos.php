<?php
    require '../Productos.php';
    //require 'MissedCalls.php';

    if($_SERVER['REQUEST_METHOD']=='POST'){
        //echo "POST";
        $entrada=json_decode(file_get_contents("php://input"),true);
        //echo "<bR>BODY= ".$body;

        $respuesta = Productos::listarProductos();
        //$respuesta = MissedCalls::listarLlamadas();
        //print_r($respuesta);
    if($respuesta){
        echo json_encode(
            array(
                'data'=>$respuesta,
                'estado'=> 1,
                'mensaje'=>'Exito')
        );
    }else {
    // Código de fallo
    print json_encode(
        array(
            'estado' => 0,
            'mensaje' => 'Error.')
    );
    }
}

?>