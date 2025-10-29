CREATE DATABASE IF NOT EXISTS sq_parcial_plp3
  CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE sq_parcial_plp3;

DROP TABLE IF EXISTS sq_partida_respuesta;
DROP TABLE IF EXISTS sq_partida;
DROP TABLE IF EXISTS sq_opcion;
DROP TABLE IF EXISTS sq_pregunta;
DROP TABLE IF EXISTS sq_categoria;

CREATE TABLE sq_categoria (
  sq_id_categoria   INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  sq_nombre         VARCHAR(80) NOT NULL,
  sq_dificultad     ENUM('facil','media','dificil') NOT NULL DEFAULT 'facil'
) ENGINE=InnoDB;

CREATE TABLE sq_pregunta (
  sq_id_pregunta    INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  sq_id_categoria   INT UNSIGNED NOT NULL,
  sq_enunciado      VARCHAR(255) NOT NULL,
  sq_tiempo_seg     INT UNSIGNED NOT NULL DEFAULT 20,
  CONSTRAINT fk_sq_pregunta_categoria
    FOREIGN KEY (sq_id_categoria) REFERENCES sq_categoria(sq_id_categoria)
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE sq_opcion (
  sq_id_opcion      INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  sq_id_pregunta    INT UNSIGNED NOT NULL,
  sq_texto          VARCHAR(255) NOT NULL,
  sq_es_correcta    TINYINT(1) NOT NULL DEFAULT 0,
  CONSTRAINT fk_sq_opcion_pregunta
    FOREIGN KEY (sq_id_pregunta) REFERENCES sq_pregunta(sq_id_pregunta)
    ON DELETE CASCADE
) ENGINE=InnoDB;

-- Registro de partidas y respuestas para ranking
CREATE TABLE sq_partida (
  sq_id_partida     INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  sq_jugador        VARCHAR(60) NOT NULL,
  sq_puntaje        INT NOT NULL DEFAULT 0,
  sq_preguntas_tot  INT NOT NULL,
  sq_correctas      INT NOT NULL,
  sq_duracion_seg   INT NOT NULL,
  sq_creado_en      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE sq_partida_respuesta (
  sq_id_resp        INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  sq_id_partida     INT UNSIGNED NOT NULL,
  sq_id_pregunta    INT UNSIGNED NOT NULL,
  sq_id_opcion      INT UNSIGNED NOT NULL,
  sq_correcta       TINYINT(1) NOT NULL,
  CONSTRAINT fk_sq_pr_partida
    FOREIGN KEY (sq_id_partida) REFERENCES sq_partida(sq_id_partida)
      ON DELETE CASCADE,
  CONSTRAINT fk_sq_pr_pregunta
    FOREIGN KEY (sq_id_pregunta) REFERENCES sq_pregunta(sq_id_pregunta)
      ON DELETE CASCADE,
  CONSTRAINT fk_sq_pr_opcion
    FOREIGN KEY (sq_id_opcion) REFERENCES sq_opcion(sq_id_opcion)
      ON DELETE CASCADE
) ENGINE=InnoDB;

-- Índices 
CREATE INDEX idx_sq_pregunta_cat ON sq_pregunta(sq_id_categoria);
CREATE INDEX idx_sq_opcion_preg  ON sq_opcion(sq_id_pregunta);
CREATE INDEX idx_sq_partida_pts  ON sq_partida(sq_puntaje DESC, sq_creado_en DESC);
