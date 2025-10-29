<?php
//POST: guarda resultado de partida + respuestas (opcional).
// GET : devuelve top 10 del ranking.
require __DIR__.'/sq_conexion.php';
header('Content-Type: application/json; charset=utf-8');

try {
  $pdo = sq_get_conexion();

  if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $json = json_decode(file_get_contents('php://input'), true);
    $sq_jugador       = trim($json['sq_jugador'] ?? 'Anónimo');
    $sq_puntaje       = (int)($json['sq_puntaje'] ?? 0);
    $sq_preg_tot      = (int)($json['sq_preguntas_tot'] ?? 0);
    $sq_correctas     = (int)($json['sq_correctas'] ?? 0);
    $sq_duracion_seg  = (int)($json['sq_duracion_seg'] ?? 0);
    $sq_detalle       = $json['sq_respuestas'] ?? [];

    $pdo->beginTransaction();
    $st = $pdo->prepare("INSERT INTO sq_partida (sq_jugador, sq_puntaje, sq_preguntas_tot, sq_correctas, sq_duracion_seg)
                         VALUES (?,?,?,?,?)");
    $st->execute([$sq_jugador, $sq_puntaje, $sq_preg_tot, $sq_correctas, $sq_duracion_seg]);
    $idPartida = (int)$pdo->lastInsertId();

    if (is_array($sq_detalle)) {
      $sti = $pdo->prepare("INSERT INTO sq_partida_respuesta (sq_id_partida, sq_id_pregunta, sq_id_opcion, sq_correcta)
                            VALUES (?,?,?,?)");
      foreach ($sq_detalle as $r) {
        $sti->execute([
          $idPartida,
          (int)$r['sq_id_pregunta'],
          (int)$r['sq_id_opcion'],
          (int)$r['sq_correcta']
        ]);
      }
    }
    $pdo->commit();
    echo json_encode(['ok'=>true, 'sq_id_partida'=>$idPartida], JSON_UNESCAPED_UNICODE);
    exit;
  }

  // GET top 10
  $top = $pdo->query("SELECT sq_jugador, sq_puntaje, sq_correctas, sq_preguntas_tot, sq_creado_en FROM sq_partida ORDER BY sq_puntaje DESC, sq_creado_en DESC LIMIT 10")->fetchAll();
  echo json_encode(['ok'=>true, 'top'=>$top], JSON_UNESCAPED_UNICODE);
} catch (Throwable $e) {
  if (isset($pdo) && $pdo->inTransaction()) $pdo->rollBack();
  http_response_code(500);
  echo json_encode(['ok'=>false, 'error'=>'Error en ranking']);
}
