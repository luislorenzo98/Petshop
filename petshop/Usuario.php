<?php

    require 'DBConnection.php';

    class Usuario{

        function __construct(){}

        public static function getAll()
        {
            $query = "SELECT * FROM usuarios";
            try {
                // Preparar sentencia
                $statement = Connection::getInstance()->getConnection()->prepare($query);
                // Ejecutar sentencia preparada
                $statement->execute();
    
                return $statement->fetchAll(PDO::FETCH_ASSOC);
    
            } catch (PDOException $e) {
                return false;
            }
        }

        /*public static function hablar(){
            $query = "SELECT a.* FROM asignatura a, profesor_asignatura pa 
            WHERE id_profesor = 1 and id_asignatura = codigo";
            $statement = Connection::getInstance()->getConnection()->prepare($query);
            // Ejecutar sentencia preparada
            $statement->execute();
            $result = $statement->fetchAll(PDO::FETCH_ASSOC);

            echo "por aquí...";
            echo "<br>";
            print_r($result);
        }*/

        public static function login($correo, $contrasena) {
            //$contrasena_fuerte = password_hash($contrasena,PASSWORD_DEFAULT);

            
            $query = "SELECT * FROM usuarios WHERE correo = ?";
            
            
            try {
                // Preparar sentencia
                $statement = Connection::getInstance()->getConnection()->prepare($query);
                // Ejecutar sentencia preparada
                $statement->execute(array($correo));
                // Capturar primera fila del resultado
                $registro = $statement->fetch(PDO::FETCH_ASSOC);
                
                //print_r($registro);
                //print 'hola';
                if(password_verify($contrasena, $registro['contrasena'])){
                //print "<br>";

                // Ejecutar sentencia preparada
                //$rol = $statement->execute();
                //print $rol;
                if($registro["rol"]!=1){
                    $consultRol = "SELECT id_usuario FROM usuarios WHERE id = " . $registro["id"];
                }else{
                    $query = "SELECT id, rol, id_administrador FROM usuarios WHERE correo = ?";
                    $statement = Connection::getInstance()->getConnection()->prepare($query);
                    $statement->execute(array($correo));
                    $registro = $statement->fetch(PDO::FETCH_ASSOC);
                    //echo "ID_TUTOR: " . $registro['id_tutor'];
                    //print "<br>";
                    //echo "Eres un Tutor.";
                }
                return $registro;
            }
            } catch (PDOException $e) {
                // Aquí puedes clasificar el error dependiendo de la excepción
                // para presentarlo en la respuesta Json
                return 404;
            }
        }


        public static function insert($correo, $contrasena, $rol, $rol_usuario) {

            $contrasena_cript = password_hash($contrasena,PASSWORD_DEFAULT);
            
            if($rol==1){
                $query = "INSERT INTO usuarios ( " . "correo," . " contrasena," . " rol," . " id_administrador) " .
                " VALUES( ?,?,?,?)";
            }else{
                if($rol==2){
                    $query = "INSERT INTO usuarios ( " . "correo," . " contrasena," . " rol," . " id_usuario) " .
                    " VALUES( ?,?,?,?)";
                }
            }
    
            // Preparar la sentencia
            $statement = Connection::getInstance()->getConnection()->prepare($query);
            
            
            //$result = $statement->fetchAll(PDO::FETCH_ASSOC);
            //print_r($result);
            return $statement->execute(array($correo, $contrasena_cript, $rol, $rol_usuario));
        }
    }
    
    //$user = new Usuario();
    //$user->insert("jesus@gmail.com", "paco", "1", "1");
    //$user->login("usu@gmail.com", "1234");
?>