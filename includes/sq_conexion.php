<?php

function sq_get_conexion(): PDO {
  $sq_host = '127.0.0.1';
  $sq_db   = 'sq_parcial_plp3';
  $sq_user = 'root';
  $sq_pass = '';       
  $sq_port = 3307;     

  $dsn = "mysql:host=$sq_host;port=$sq_port;dbname=$sq_db;charset=utf8mb4";
  $opt = [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
  ];
  return new PDO($dsn, $sq_user, $sq_pass, $opt);
}




