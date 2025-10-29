Descripción
Plataforma de trivia web con prefijo sq_. Permite jugar una partida de 15 preguntas, validar respuestas en tiempo real y registrar un ranking persistente.
Tecnologías
Frontend: HTML, CSS, JavaScript (router por hash, temporizador, puntaje).
Backend: PHP con PDO.
Base de datos: MySQL/MariaDB.

Instalación y puesta en marcha
Crear la base y tablas: importar database/sq_estructura.sql.

Cargar datos iniciales: importar database/sq_datos.sql.

Configurar conexión: editar includes/sq_conexion.php (host, puerto, usuario, clave, base).

Desplegar en el servidor web (por ejemplo, htdocs/ en XAMPP) y abrir http://localhost/.

Endpoints

includes/sq_preguntas.php

GET: devuelve 15 preguntas filtrables por sq_categoria y sq_dificultad.

POST: valida { sq_id_pregunta, sq_id_opcion } y responde con { correcta, sq_id_opcion_correcta }.

includes/sq_ranking.php

POST: registra la partida (jugador, puntaje, aciertos, duración).

GET: devuelve el Top 10.

Funcionalidades principales

Temporizador por pregunta con penalización por tiempo agotado.

Puntaje progresivo con bonus por rapidez y racha de aciertos.

Feedback visual inmediato para respuestas correctas e incorrectas.

Navegación por hash entre Inicio, Juego y Resultados.

Ranking persistente almacenado en la base de datos.



Uso
El proyecto está orientado a fines académicos. Puede modificarse y reutilizarse citando la fuente.
