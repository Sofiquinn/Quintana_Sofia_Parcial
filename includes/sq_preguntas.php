<?php
//GET: devuelve 15 preguntas con sus opciones (sin marcar la correcta).
//POST: valida una respuesta (id_pregunta + id_opcion) y responde si es correcta.
require __DIR__.'/sq_conexion.php';
header('Content-Type: application/json; charset=utf-8');

try {
  $pdo = sq_get_conexion();

  if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $json  = json_decode(file_get_contents('php://input'), true);
    $idP   = (int)($json['sq_id_pregunta'] ?? 0);
    $idO   = (int)($json['sq_id_opcion'] ?? 0);

    if ($idP <= 0 || $idO <= 0) {
      http_response_code(400);
      echo json_encode(['ok'=>false, 'error'=>'Parámetros inválidos']);
      exit;
    }

    $st = $pdo->prepare("
      SELECT o.sq_es_correcta,
             (SELECT sq_id_opcion FROM sq_opcion WHERE sq_id_pregunta = :p AND sq_es_correcta = 1 LIMIT 1) AS sq_id_opcion_correcta
      FROM sq_opcion o
      WHERE o.sq_id_opcion = :o AND o.sq_id_pregunta = :p
      LIMIT 1
    ");
    $st->execute([':p'=>$idP, ':o'=>$idO]);
    $row = $st->fetch();

    if (!$row) {
      http_response_code(404);
      echo json_encode(['ok'=>false, 'error'=>'Opción no encontrada para la pregunta']);
      exit;
    }

    echo json_encode([
      'ok' => true,
      'correcta' => (int)$row['sq_es_correcta'] === 1,
      'sq_id_opcion_correcta' => (int)$row['sq_id_opcion_correcta']
    ], JSON_UNESCAPED_UNICODE);
    exit;
  }

  // GET
  $filtros = [];
  $where   = [];

  if (!empty($_GET['sq_categoria'])) {
    $where[] = 'p.sq_id_categoria = :cat';
    $filtros[':cat'] = (int)$_GET['sq_categoria'];
  }
  if (!empty($_GET['sq_dificultad'])) {
    $where[] = 'c.sq_dificultad = :dif';
    $filtros[':dif'] = $_GET['sq_dificultad'];
  }
  $sqlWhere = $where ? 'WHERE '.implode(' AND ', $where) : '';

  $st = $pdo->prepare("
    SELECT p.sq_id_pregunta, p.sq_enunciado, p.sq_tiempo_seg,
           c.sq_id_categoria, c.sq_nombre, c.sq_dificultad
    FROM sq_pregunta p
    JOIN sq_categoria c ON c.sq_id_categoria = p.sq_id_categoria
    $sqlWhere
    ORDER BY RAND()
    LIMIT 15
  ");
  $st->execute($filtros);
  $pregs = $st->fetchAll();

  $ids = array_column($pregs, 'sq_id_pregunta');
  $opciones = [];
  if ($ids) {
    $in  = implode(',', array_fill(0, count($ids), '?'));
    $st2 = $pdo->prepare("SELECT sq_id_opcion, sq_id_pregunta, sq_texto FROM sq_opcion WHERE sq_id_pregunta IN ($in)");
    $st2->execute($ids);
    while ($r = $st2->fetch()) {
      $opciones[$r['sq_id_pregunta']][] = [
        'sq_id_opcion' => (int)$r['sq_id_opcion'],
        'sq_texto'     => $r['sq_texto']
      ];
    }
  }

  $data = [];
  foreach ($pregs as $p) {
    $data[] = [
      'sq_id_pregunta' => (int)$p['sq_id_pregunta'],
      'sq_enunciado'   => $p['sq_enunciado'],
      'sq_tiempo_seg'  => (int)$p['sq_tiempo_seg'],
      'sq_categoria'   => [
        'sq_id_categoria' => (int)$p['sq_id_categoria'],
        'sq_nombre'       => $p['sq_nombre'],
        'sq_dificultad'   => $p['sq_dificultad']
      ],
      'sq_opciones'    => $opciones[$p['sq_id_pregunta']] ?? []
    ];
  }

  echo json_encode(['ok'=>true, 'preguntas'=>$data], JSON_UNESCAPED_UNICODE);
} catch (Throwable $e) {
  http_response_code(500);
  echo json_encode(['ok'=>false, 'error'=>'Error interno']);
}
