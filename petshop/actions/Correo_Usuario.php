<?php
    require '../Usuario.php';

    if($_SERVER['REQUEST_METHOD']=='POST'){
        //echo "POST";
        $entrada=json_decode(file_get_contents("php://input"),true);
        //echo "<bR>BODY= ".$body;

        if($entrada==null){
            $correo=$_REQUEST['correo'];
            $contrasena=$_REQUEST['contrasena'];
        }
        else{
            $correo=$entrada['correo'];
            $contrasena=$entrada['contrasena'];
        }

        $respuesta = Usuario::login($correo, $contrasena);

    if($respuesta){
        if($respuesta['rol']==1){
            echo json_encode(
                array(
                    'id'=>$respuesta['id_administrador'],
                    'rol'=> 1,
                    'mensaje'=>'Exito'
                )
            );
        }else{
            if($respuesta['rol']==2){
                echo json_encode(
                    array(
                        'id'=>$respuesta['id_usuario'],
                        'rol'=> 2,
                        'mensaje'=>'Exito'
                    )
                );
            }
        }
    }else {
    // Código de fallo
    print json_encode(
        array(
            'rol' => 0,
            'mensaje' => 'Correo incorrecto o contraseña incorrecta')
    );
    }
}

?>