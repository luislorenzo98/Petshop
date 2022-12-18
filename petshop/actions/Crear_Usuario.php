<?php
    require '../Usuario.php';

    if($_SERVER['REQUEST_METHOD']=='POST'){
        //echo "POST";
        $entrada=json_decode(file_get_contents("php://input"),true);
        //echo "<bR>BODY= ".$body;

        if($entrada==null){
            $correo=$_REQUEST['correo'];
            $contrasena=$_REQUEST['contrasena'];
            $rol=$_REQUEST['rol'];
            $rol_usuario=$_REQUEST['rol_usuario'];
        }
        else{
            $correo=$body['correo'];
            $contrasena=$body['contrasena'];
            $rol=$body['rol'];
            $rol_usuario=$body['rol_usuario'];
        }

        $respuesta = Usuario::insert($correo, $contrasena, $rol, $rol_usuario);

    if($respuesta){
        echo json_encode(
            array(
                'datos'=>$respuesta['id'],
                'estado'=> 1,
                'mensaje'=>'Usuario creado con éxito.'
            )
        );

    }else {
    // Código de falla
        print json_encode(
            array(
                'estado' => 0,
                'mensaje' => 'El usuario no pudo crearse o ya existe.'
            )
        );
    }
}

?>