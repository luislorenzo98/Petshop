<?php
    require '../Categorias.php';

    if($_SERVER['REQUEST_METHOD']=='POST'){
        //echo "POST";
        $entrada=json_decode(file_get_contents("php://input"),true);
        //echo "<bR>BODY= ".$body;

        if($entrada==null){
            $id_categoria=$_REQUEST['id_categoria'];
        }
        else{
            $id_categoria=$_REQUEST['id_categoria'];
        }

        $respuesta = Categorias::getProductos($id_categoria);

    if($respuesta){
        echo json_encode(
            array(
                'datos'=>$respuesta,
                'estado'=> 1,
                'mensaje'=>'Exito')
        );
    }else {
    // Código de fallo
    print json_encode(
        array(
            'estado' => 0,
            'mensaje' => 'No hay productos en esta categoria.')
    );
    }
}

?>