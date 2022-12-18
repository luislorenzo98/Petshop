<?php
    require 'DBConnection.php';

    class Productos{

        function __construct(){}

         public static function listarProductos(){

            $query = "SELECT * FROM productos";
            try {
                
                // Preparar sentencia
                $statement = Connection::getInstance()->getConnection()->prepare($query);
                // Ejecutar sentencia preparada
                $statement->execute(array());
                
                $registro = $statement->fetchAll(PDO::FETCH_ASSOC);
                //echo "Alumnos...";
                //print_r($registro);

                return $registro;
    
            } catch (PDOException $e) {
                return false;
            }
        }

        public static function listarFavoritos(){

            $query = "SELECT * FROM productos WHERE favorito=1";
            try {
                
                // Preparar sentencia
                $statement = Connection::getInstance()->getConnection()->prepare($query);
                // Ejecutar sentencia preparada
                $statement->execute(array());
                
                $registro = $statement->fetchAll(PDO::FETCH_ASSOC);
                //echo "Alumnos...";
                //print_r($registro);

                return $registro;
    
            } catch (PDOException $e) {
                return false;
            }
        }

        public static function marcarfavorito($id){

            $consulta = "SELECT * FROM productos WHERE ? = id";

             $statement = Connection::getInstance()->getConnection()->prepare($consulta);
                // Ejecutar sentencia preparada
                $statement->execute(array($id));
                $registro = $statement->fetchAll(PDO::FETCH_ASSOC);

           // $id = $array['id'];
           // $stopdate = $registro['stopdate'];
           // $src = $registro['src'];


            //$comentario = 'llamada por'.$src.' realizada dia '.$stopdate;
            //$query = "UPDATE missedcalls SET processed='1', comments='" .$comentario. "' WHERE ? = id";
            $query = "UPDATE productos SET favorito='1' WHERE ? = id";
            try {
                
                // Preparar sentencia
                $statement = Connection::getInstance()->getConnection()->prepare($query);
                // Ejecutar sentencia preparada
                
                
                //$registro = $statement->fetchAll(PDO::FETCH_ASSOC);
                //echo "Alumnos...";
                //print_r($registro);

               // print("La id ".$id." ha sido marcada");
                return $statement->execute(array($id));
    
            } catch (PDOException $e) {
                return false;
            }
        } 

        public static function quitarfavorito($id){

            $consulta = "SELECT * FROM productos WHERE ? = id";

             $statement = Connection::getInstance()->getConnection()->prepare($consulta);
                // Ejecutar sentencia preparada
                $statement->execute(array($id));
                $registro = $statement->fetchAll(PDO::FETCH_ASSOC);

           // $id = $array['id'];
           // $stopdate = $registro['stopdate'];
           // $src = $registro['src'];


            //$comentario = 'llamada por'.$src.' realizada dia '.$stopdate;
            //$query = "UPDATE missedcalls SET processed='1', comments='" .$comentario. "' WHERE ? = id";
            $query = "UPDATE productos SET favorito='0' WHERE ? = id";
            try {
                
                // Preparar sentencia
                $statement = Connection::getInstance()->getConnection()->prepare($query);
                // Ejecutar sentencia preparada
                
                
                //$registro = $statement->fetchAll(PDO::FETCH_ASSOC);
                //echo "Alumnos...";
                //print_r($registro);

               // print("La id ".$id." ha sido marcada");
                return $statement->execute(array($id));
    
            } catch (PDOException $e) {
                return false;
            }
        } 

       
}
 //  $call = new Calls();
 //  $call->listarLlamadas();
?>