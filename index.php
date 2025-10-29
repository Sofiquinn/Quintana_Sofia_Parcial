<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8">
  <title>sq_QuizMaster</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/sq_estilos.css">
</head>
<body>

<header class="sq_header">
  <div class="sq_brand">sq_QuizMaster</div>
  <button class="sq_menu_btn" aria-label="Abrir menú" aria-expanded="false">☰</button>
  <nav class="sq_nav" aria-label="Navegación principal">
    <a href="#sq_inicio" class="sq_nav_link">Inicio</a>
    <a href="#sq_juego" class="sq_nav_link">Jugar</a>
    <a href="#sq_resultados" class="sq_nav_link">Resultados</a>
  </nav>
</header>

<main>
  <section id="sq_inicio" class="sq_seccion">
    <h1>Bienvenido a sq_QuizMaster</h1>
    <p>Gamificá tu aprendizaje con preguntas de <strong>Web</strong>, <strong>Algoritmos</strong> y <strong>Bases de Datos</strong>.</p>

    <form class="sq_form_config" aria-label="Configurar partida" onsubmit="return false">
      <label for="sq_nombre">Nombre</label>
      <input id="sq_nombre" name="sq_nombre" placeholder="Tu nombre" required>

      <label for="sq_categoria">Categoría</label>
      <select id="sq_categoria" name="sq_categoria">
        <option value="">Todas</option>
        <option value="1">Fundamentos de Web (fácil)</option>
        <option value="2">Lógica y Algoritmos (media)</option>
        <option value="3">Bases de Datos (difícil)</option>
      </select>

      <label for="sq_dificultad">Dificultad</label>
      <select id="sq_dificultad" name="sq_dificultad">
        <option value="">Cualquiera</option>
        <option value="facil">Fácil</option>
        <option value="media">Media</option>
        <option value="dificil">Difícil</option>
      </select>

      <button type="button" id="sq_btn_empezar" onclick="window.sq_empezar?.()">Empezar</button>
    </form>
  </section>

  <!-- Juego -->
  <section id="sq_juego" class="sq_seccion" hidden>
    <div class="sq_hud" role="status" aria-live="polite">
      <div>Jugador: <span id="sq_lbl_jugador">-</span></div>
      <div>Puntaje: <span id="sq_lbl_puntaje">0</span></div>
      <div>Pregunta: <span id="sq_lbl_pos">0</span>/15</div>
      <div class="sq_timer">⏱ <span id="sq_lbl_timer">00</span>s</div>
    </div>

    <div class="sq_card">
      <h2 id="sq_enunciado">—</h2>

      <div id="sq_opciones" class="sq_opciones" role="listbox" aria-label="Opciones de respuesta">
        <!-- Botones de opciones generados por JS -->
      </div>

      <div class="sq_feedback" id="sq_feedback" aria-live="assertive"></div>

      <div class="sq_acciones">
        <button id="sq_btn_siguiente" disabled>Siguiente</button>
      </div>
    </div>
  </section>

  <!-- Resultados -->
  <section id="sq_resultados" class="sq_seccion" hidden>
    <h2>Resultados</h2>

    <div class="sq_resumen">
      <p>Jugador: <strong id="sq_res_jugador">—</strong></p>
      <p>Puntaje: <strong id="sq_res_puntaje">0</strong></p>
      <p>Correctas: <strong id="sq_res_correctas">0</strong> de <strong id="sq_res_total">0</strong></p>
      <p>Duración: <strong id="sq_res_tiempo">0</strong> s</p>
    </div>

    <h3>Top 10</h3>
    <ol id="sq_ranking" class="sq_ranking"></ol>

    <div class="sq_acciones">
      <a href="#sq_inicio" id="sq_link_volver" class="sq_btn_link">Volver a jugar</a>
    </div>
  </section>
</main>

<script defer src="js/sq_script.js"></script>
</body>
</html>
