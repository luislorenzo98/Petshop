<?php

    // Defino las cosntantes
    define("HOST", "localhost");
    define("USERNAME", "root");
    define("PASSWORD", "");
    define("DATABASE", "petshop2");
        
    class Connection{


        // Única instancia de la clase
        private static $instance=null;

        // Instancia de la conexión PDO
        private static $conn;

        final private function __construct(){
            try{
                // Crear nueva conexión PDO
                self::getConnection();
            }catch (PDOException $e){
                // Mostrar mensaje de error
            }
        }

        // Conexión a Base de Datos --Singleton--
        public static function getInstance(){
            if(self::$instance===null)
            {
                self::$instance=new self();
            }
            return self::$instance;
        }


        public function getConnection()
        {
            if (self::$conn == null) {
                self::$conn = new PDO("mysql:host=" . HOST . "; dbname=" . DATABASE, USERNAME, PASSWORD, 
                    array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES utf8")
                );                
                self::$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            }

            return self::$conn;
        }
 
        
        // Destructor
        function _destructor()
        {
            self::$conn = null;
        }

    }

?>