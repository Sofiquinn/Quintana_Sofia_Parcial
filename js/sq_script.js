
// Carga preguntas (GET), valida respuesta (POST).
// Calcula puntaje (bonus por rapidez y penalizaciones).
// Muestra resultado inmediato y navega entre vistas.

// Estado global del juego (se reinicia al volver a jugar)
const sq_STATE = {
  jugador: '',          
  preguntas: [],        
  pos: 0,               
  puntaje: 0,           
  correctas: 0,         
  racha: 0,             
  tiempoInicio: 0,      
  tiempoPregunta: 0,    
  restante: 0,       
  timerId: null,       
  respuestas: [],       
  terminado: false     
};

const $  = (q) => document.querySelector(q);
const $$ = (q) => document.querySelectorAll(q);
const sq_pad2 = (n) => String(n).padStart(2,'0'); 
const p_now = () => performance.now();            

// Muestra una sección y oculta las demás
function sq_show(idSel){
  ['#sq_inicio','#sq_juego','#sq_resultados'].forEach(id => $(id).hidden = true);
  $(idSel).hidden = false;
}

// Router por hash 
function sq_route() {
  const h = (location.hash || '#sq_inicio').toLowerCase();

  // Inicio: siempre se puede mostrar
  if (h === '#sq_inicio') {
    sq_show('#sq_inicio');
    return;
  }

  // Juego: solo si ya hay preguntas cargadas
  if (h === '#sq_juego') {
    if (sq_STATE.preguntas.length) sq_show('#sq_juego');
    else location.hash = '#sq_inicio';
    return;
  }

  // Resultados: solo si la partida terminó
  if (h === '#sq_resultados') {
    if (sq_STATE.terminado) sq_show('#sq_resultados');
    else location.hash = '#sq_inicio';
    return;
  }

  // Cualquier otro hash redirige a inicio
  location.hash = '#sq_inicio';
}

// Llama al backend para traer 15 preguntas (según filtros)
async function sq_cargarPreguntas() {
  const cat = $('#sq_categoria').value;     
  const dif = $('#sq_dificultad').value;     
  const url = `includes/sq_preguntas.php?sq_categoria=${encodeURIComponent(cat)}&sq_dificultad=${encodeURIComponent(dif)}`;

  const r = await fetch(url);
  const j = await r.json();

  // Validación mínima del payload
  if (!j.ok || !Array.isArray(j.preguntas) || !j.preguntas.length) {
    throw new Error('No hay preguntas disponibles');
  }
  sq_STATE.preguntas = j.preguntas;
}

// Dibuja la pregunta actual y opciones, y empieza el temporizador
function sq_renderPregunta() {
  const p = sq_STATE.preguntas[sq_STATE.pos];
  if (!p) return;

  $('#sq_enunciado').textContent = p.sq_enunciado;
  $('#sq_lbl_pos').textContent   = sq_STATE.pos + 1;

  // Contenedor de opciones (limpiar y volver a pintar)
  const cont = $('#sq_opciones');
  cont.innerHTML = '';

  // Mezclar opciones para no fijar el orden
  const opciones = [...p.sq_opciones].sort(() => Math.random() - 0.5);
  opciones.forEach(o => {
    const btn = document.createElement('button');
    btn.className = 'sq_opcion';
    btn.textContent = o.sq_texto;
    btn.dataset.sqIdOpcion = String(o.sq_id_opcion);
    // Al hacer click, validar contra el servidor
    btn.onclick = () => sq_validarRespuesta(p.sq_id_pregunta, o.sq_id_opcion, btn);
    cont.appendChild(btn);
  });

  // Temporizador por pregunta (1 segundo por tick)
  clearInterval(sq_STATE.timerId);
  sq_STATE.restante = p.sq_tiempo_seg ?? 20;
  $('#sq_lbl_timer').textContent = sq_pad2(sq_STATE.restante);
  sq_STATE.tiempoPregunta = p_now();

  sq_STATE.timerId = setInterval(() => {
    sq_STATE.restante--;
    $('#sq_lbl_timer').textContent = sq_pad2(Math.max(0, sq_STATE.restante));

    // Si se acabó el tiempo: penaliza, bloquea opciones y habilita “Siguiente”
    if (sq_STATE.restante <= 0) {
      clearInterval(sq_STATE.timerId);
      sq_feedback('Tiempo agotado. -5 pts','sq_bad');
      sq_sumarPuntaje(-5);
      $$('.sq_opcion').forEach(b=>b.disabled = true);
      $('#sq_btn_siguiente').disabled = false;

      // Registrar que no respondió (opción 0)
      sq_STATE.respuestas.push({
        sq_id_pregunta: p.sq_id_pregunta,
        sq_id_opcion: 0,
        sq_correcta: 0
      });
    }
  }, 1000);

  $('#sq_btn_siguiente').disabled = true;
  sq_feedback('', '');
}

// Muestra un mensaje de feedback (ok / error) bajo las opciones
function sq_feedback(msg, cls){
  const f = $('#sq_feedback');
  f.className = 'sq_feedback ' + (cls || '');
  f.textContent = msg || '';
}

// Envía la respuesta al servidor y pinta correcto/incorrecto
async function sq_validarRespuesta(idPregunta, idOpcion, btn){
  // Evita dobles clics
  $$('.sq_opcion').forEach(b=>b.disabled = true);

  let esCorrecta = false;
  let idCorrecta = 0;

  try{
    // POST al backend de preguntas para validar
    const resp = await fetch('includes/sq_preguntas.php', {
      method:'POST',
      headers:{'Content-Type':'application/json'},
      body: JSON.stringify({ sq_id_pregunta: idPregunta, sq_id_opcion: idOpcion })
    });
    const js = await resp.json();
    if (js.ok) {
      esCorrecta = !!js.correcta;
      idCorrecta = js.sq_id_opcion_correcta || 0;
    }
  }catch{
    esCorrecta = false;
  }

  // Cálculo de puntaje y estilos visuales
  if (esCorrecta){
    btn.classList.add('sq_ok');
    sq_STATE.racha++;
    const consumido = Math.max(0, (p_now()-sq_STATE.tiempoPregunta)/1000);
    const bonusTiempo = Math.max(0, 5 - Math.floor(consumido/4)); // pequeño bonus por rapidez
    const puntos = 10 + (2*sq_STATE.racha) + bonusTiempo;
    sq_sumarPuntaje(puntos);
    sq_STATE.correctas++;
    sq_feedback(`✔ Correcto (+${puntos})`,'sq_ok');
  }else{
    btn.classList.add('sq_bad');
    // Resalta también la correcta si el server la envió
    if (idCorrecta){
      const okBtn = Array.from($$('.sq_opcion')).find(
        b => Number(b.dataset.sqIdOpcion) === Number(idCorrecta)
      );
      if (okBtn) okBtn.classList.add('sq_ok');
    }
    sq_STATE.racha = 0;
    sq_sumarPuntaje(-3);
    sq_feedback('✖ Incorrecto (-3)','sq_bad');
  }

  // Registrar respuesta para guardar luego en ranking
  sq_STATE.respuestas.push({
    sq_id_pregunta: idPregunta,
    sq_id_opcion: idOpcion,
    sq_correcta: esCorrecta ? 1 : 0
  });

  clearInterval(sq_STATE.timerId);
  $('#sq_btn_siguiente').disabled = false;
}

// Suma/resta puntos sin permitir valores negativos
function sq_sumarPuntaje(delta){
  sq_STATE.puntaje = Math.max(0, sq_STATE.puntaje + delta);
  $('#sq_lbl_puntaje').textContent = sq_STATE.puntaje;
}

// Arranca una nueva partida: resetea estado y carga preguntas
async function sq_empezar(){
  try {
    sq_STATE.jugador = ($('#sq_nombre').value || 'Anónimo').slice(0,60);
    $('#sq_lbl_jugador').textContent = sq_STATE.jugador;

    // Reset de estado para nueva partida
    sq_STATE.pos = 0;
    sq_STATE.puntaje = 0;
    sq_STATE.correctas = 0;
    sq_STATE.racha = 0;
    sq_STATE.respuestas = [];
    sq_STATE.terminado = false;
    sq_STATE.tiempoInicio = p_now();

    // Cargar preguntas y mostrar vista de juego
    await sq_cargarPreguntas();
    sq_show('#sq_juego');
    location.hash = '#sq_juego';
    sq_renderPregunta();
  } catch (err) {
    console.error('Error al empezar:', err);
    alert('No se pudieron cargar las preguntas. Verificá la BD y includes/sq_preguntas.php.');
  }
}

// Avanza a la siguiente pregunta o finaliza
function sq_siguiente(){
  sq_STATE.pos++;
  if (sq_STATE.pos >= sq_STATE.preguntas.length) {
    sq_finalizar();
  } else {
    sq_renderPregunta();
  }
}

// Cierra la partida: muestra resumen y guarda ranking
async function sq_finalizar(){
  clearInterval(sq_STATE.timerId);
  const dur = Math.round((p_now() - sq_STATE.tiempoInicio)/1000);

  // Resumen en pantalla
  $('#sq_res_jugador').textContent   = sq_STATE.jugador;
  $('#sq_res_puntaje').textContent   = sq_STATE.puntaje;
  $('#sq_res_correctas').textContent = sq_STATE.correctas;
  $('#sq_res_total').textContent     = sq_STATE.preguntas.length;
  $('#sq_res_tiempo').textContent    = dur;

  // Guardar en ranking 
  try{
    await fetch('includes/sq_ranking.php', {
      method:'POST',
      headers:{'Content-Type':'application/json'},
      body: JSON.stringify({
        sq_jugador: sq_STATE.jugador,
        sq_puntaje: sq_STATE.puntaje,
        sq_preguntas_tot: sq_STATE.preguntas.length,
        sq_correctas: sq_STATE.correctas,
        sq_duracion_seg: dur,
        sq_respuestas: sq_STATE.respuestas
      })
    });
  }catch{}

  // Cargar Top 10 y mostrarlo
  try{
    const r = await fetch('includes/sq_ranking.php');
    const j = await r.json();
    const ol = $('#sq_ranking');
    ol.innerHTML = '';
    if (j.ok && Array.isArray(j.top) && j.top.length){
      j.top.forEach(it => {
        const li = document.createElement('li');
        li.textContent = `${it.sq_jugador} — ${it.sq_puntaje} pts (${it.sq_correctas}/${it.sq_preguntas_tot})`;
        ol.appendChild(li);
      });
    } else {
      $('#sq_ranking').innerHTML = '<li>No hay registros</li>';
    }
  }catch{
    $('#sq_ranking').innerHTML = '<li>No hay registros</li>';
  }

  // Marcar fin y navegar a resultados
  sq_STATE.terminado = true;
  sq_show('#sq_resultados');
  location.hash = '#sq_resultados';
}

// Vuelve al inicio y limpia todo para una nueva partida
function sq_resetYVolver(e){
  e.preventDefault();
  clearInterval(sq_STATE.timerId);

  // Reset completo del estado
  Object.assign(sq_STATE, {
    jugador:'', preguntas:[], pos:0, puntaje:0, correctas:0, racha:0,
    tiempoInicio:0, tiempoPregunta:0, restante:0, timerId:null, respuestas:[], terminado:false
  });

  // Limpiar UI básica
  $('#sq_opciones').innerHTML = '';
  $('#sq_feedback').textContent = '';
  $('#sq_lbl_puntaje').textContent = '0';
  $('#sq_lbl_pos').textContent = '0';
  $('#sq_lbl_timer').textContent = '00';
  $('#sq_nombre').value = '';

  // Volver a inicio
  sq_show('#sq_inicio');
  location.hash = '#sq_inicio';
}

// Enlaza eventos y activa router al cargar el DOM
function sq_initUI(){
  // Botón menú (mobile)
  const btnMenu = $('.sq_menu_btn');
  if (btnMenu) btnMenu.addEventListener('click', ()=>{
    document.body.classList.toggle('sq_nav_open');
    btnMenu.setAttribute('aria-expanded', document.body.classList.contains('sq_nav_open') ? 'true' : 'false');
  });

  // Botones principales
  const btnStart = $('#sq_btn_empezar');
  if (btnStart) btnStart.addEventListener('click', sq_empezar);

  const btnSig = $('#sq_btn_siguiente');
  if (btnSig) btnSig.addEventListener('click', sq_siguiente);

  const linkVolver = $('#sq_link_volver');
  if (linkVolver) linkVolver.addEventListener('click', sq_resetYVolver);

  $$('.sq_nav_link').forEach(a=> a.addEventListener('click', ()=> document.body.classList.remove('sq_nav_open')));

  // Router por hash
  window.addEventListener('hashchange', sq_route);
  sq_route();
}

document.addEventListener('DOMContentLoaded', sq_initUI);

window.sq_empezar = sq_empezar;
