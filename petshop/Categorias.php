<?php
    require 'DBConnection.php';

    class Categorias{

        function __construct(){}

         public static function listarCategorias(){

            $query = "SELECT * FROM categorias";
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

        public static function getProductos($id_categoria)
        {
            $query = "SELECT c.nombre as c_nombre, p.* FROM productos p, categorias c WHERE c.id = p.id_categoria AND ? = p.id_categoria ";
            try {
                
                // Preparar sentencia
                $statement = Connection::getInstance()->getConnection()->prepare($query);
                // Ejecutar sentencia preparada
                $statement->execute(array($id_categoria));
                
                $registro = $statement->fetchAll(PDO::FETCH_ASSOC);
                //echo "Alumnos...";
                //print_r($registro);

                return $registro;
    
            } catch (PDOException $e) {
                return false;
            }
        }
}
 //  $call = new Calls();
 //  $call->listarLlamadas();
?>