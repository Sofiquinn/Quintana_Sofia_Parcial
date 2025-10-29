-- Datos de ejemplo para sq_QuizMaster (15 preguntas, 3 categorías)
USE sq_parcial_plp3;

-- Categorías
INSERT INTO sq_categoria (sq_nombre, sq_dificultad) VALUES
('Fundamentos de Web', 'facil'),
('Lógica y Algoritmos', 'media'),
('Bases de Datos', 'dificil');

-- Preguntas

-- Fundamentos de Web
INSERT INTO sq_pregunta (sq_id_categoria, sq_enunciado, sq_tiempo_seg) VALUES
(1,'¿Qué protocolo asegura la comunicación cifrada en la web?',20),
(1,'¿Qué lenguaje define la estructura de una página?',20),
(1,'¿Dónde se ejecuta JavaScript típicamente?',20),
(1,'¿Qué hace CSS principalmente?',20),
(1,'¿Qué significa HTTP?',20);

-- Lógica y Algoritmos
INSERT INTO sq_pregunta (sq_id_categoria, sq_enunciado, sq_tiempo_seg) VALUES
(2,'La complejidad de una búsqueda binaria es:',25),
(2,'Un arreglo ordenado permite:',25),
(2,'El “if” evalúa:',25),
(2,'Un bucle “for” se usa para:',25),
(2,'¿Qué es un algoritmo estable en ordenamiento?',25);

-- Bases de Datos
INSERT INTO sq_pregunta (sq_id_categoria, sq_enunciado, sq_tiempo_seg) VALUES
(3,'¿Qué asegura una clave primaria?',30),
(3,'¿Qué hace una clave foránea?',30),
(3,'¿Cuál es el SQL para consultar datos?',30),
(3,'¿Qué es la normalización?',30),
(3,'¿Qué motor popular usa SQL columnar?',30);


-- Fundamentos de Web
-- P1
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'TCP',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué protocolo asegura la comunicación cifrada en la web?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'TLS/HTTPS',1 FROM sq_pregunta WHERE sq_enunciado='¿Qué protocolo asegura la comunicación cifrada en la web?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'FTP',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué protocolo asegura la comunicación cifrada en la web?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'SMTP',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué protocolo asegura la comunicación cifrada en la web?';

-- P2
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'HTML',1 FROM sq_pregunta WHERE sq_enunciado='¿Qué lenguaje define la estructura de una página?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'CSS',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué lenguaje define la estructura de una página?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'SQL',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué lenguaje define la estructura de una página?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'PHP',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué lenguaje define la estructura de una página?';

-- P3
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'En el navegador (cliente)',1 FROM sq_pregunta WHERE sq_enunciado='¿Dónde se ejecuta JavaScript típicamente?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'En el switch de red',0 FROM sq_pregunta WHERE sq_enunciado='¿Dónde se ejecuta JavaScript típicamente?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'En la BIOS',0 FROM sq_pregunta WHERE sq_enunciado='¿Dónde se ejecuta JavaScript típicamente?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'En la impresora',0 FROM sq_pregunta WHERE sq_enunciado='¿Dónde se ejecuta JavaScript típicamente?';

-- P4
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Define estilos y presentación',1 FROM sq_pregunta WHERE sq_enunciado='¿Qué hace CSS principalmente?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Gestiona la BD',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué hace CSS principalmente?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Compila el kernel',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué hace CSS principalmente?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Cifra conexiones',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué hace CSS principalmente?';

-- P5
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'HyperText Transfer Protocol',1 FROM sq_pregunta WHERE sq_enunciado='¿Qué significa HTTP?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'High Traffic Transfer Program',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué significa HTTP?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Hyper Terminal Transmission',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué significa HTTP?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Host Transfer Tunnel',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué significa HTTP?';

-- Lógica y Algoritmos
-- P6
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'O(log n)',1 FROM sq_pregunta WHERE sq_enunciado='La complejidad de una búsqueda binaria es:';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'O(n^2)',0 FROM sq_pregunta WHERE sq_enunciado='La complejidad de una búsqueda binaria es:';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'O(n!)',0 FROM sq_pregunta WHERE sq_enunciado='La complejidad de una búsqueda binaria es:';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'O(1)',0 FROM sq_pregunta WHERE sq_enunciado='La complejidad de una búsqueda binaria es:';

-- P7
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Búsqueda eficiente por índice',1 FROM sq_pregunta WHERE sq_enunciado='Un arreglo ordenado permite:';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Almacenar solo strings',0 FROM sq_pregunta WHERE sq_enunciado='Un arreglo ordenado permite:';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Evitar memoria',0 FROM sq_pregunta WHERE sq_enunciado='Un arreglo ordenado permite:';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Solo inserciones',0 FROM sq_pregunta WHERE sq_enunciado='Un arreglo ordenado permite:';

-- P8
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Una condición booleana',1 FROM sq_pregunta WHERE sq_enunciado='El “if” evalúa:';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'El tamaño de RAM',0 FROM sq_pregunta WHERE sq_enunciado='El “if” evalúa:';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'La IP del servidor',0 FROM sq_pregunta WHERE sq_enunciado='El “if” evalúa:';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'La batería',0 FROM sq_pregunta WHERE sq_enunciado='El “if” evalúa:';

-- P9
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Iterar un rango conocido',1 FROM sq_pregunta WHERE sq_enunciado='Un bucle “for” se usa para:';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Pintar la UI',0 FROM sq_pregunta WHERE sq_enunciado='Un bucle “for” se usa para:';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Configurar DNS',0 FROM sq_pregunta WHERE sq_enunciado='Un bucle “for” se usa para:';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Cifrar TLS',0 FROM sq_pregunta WHERE sq_enunciado='Un bucle “for” se usa para:';

-- P10
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Mantiene orden relativo de iguales',1 FROM sq_pregunta WHERE sq_enunciado='¿Qué es un algoritmo estable en ordenamiento?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Usa menos de 1KB',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué es un algoritmo estable en ordenamiento?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Solo ordena números',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué es un algoritmo estable en ordenamiento?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Requiere GPU',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué es un algoritmo estable en ordenamiento?';

-- Bases de Datos
-- P11
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Unicidad por fila',1 FROM sq_pregunta WHERE sq_enunciado='¿Qué asegura una clave primaria?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Velocidad de GPU',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué asegura una clave primaria?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Consumo de batería',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué asegura una clave primaria?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Formato de imagen',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué asegura una clave primaria?';

-- P12
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Relaciona tablas',1 FROM sq_pregunta WHERE sq_enunciado='¿Qué hace una clave foránea?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Comprime PNG',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué hace una clave foránea?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Mide latencia',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué hace una clave foránea?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Enruta paquetes',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué hace una clave foránea?';

-- P13
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'SELECT',1 FROM sq_pregunta WHERE sq_enunciado='¿Cuál es el SQL para consultar datos?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'INSERT',0 FROM sq_pregunta WHERE sq_enunciado='¿Cuál es el SQL para consultar datos?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'DELETE',0 FROM sq_pregunta WHERE sq_enunciado='¿Cuál es el SQL para consultar datos?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'UPDATE',0 FROM sq_pregunta WHERE sq_enunciado='¿Cuál es el SQL para consultar datos?';

-- P14
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Reducir redundancia/mejorar diseño',1 FROM sq_pregunta WHERE sq_enunciado='¿Qué es la normalización?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Acelerar GPU',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué es la normalización?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Apagar servidor',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué es la normalización?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Convertir a PDF',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué es la normalización?';

-- P15
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'ClickHouse (ejemplo)',1 FROM sq_pregunta WHERE sq_enunciado='¿Qué motor popular usa SQL columnar?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Redis',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué motor popular usa SQL columnar?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'Nginx',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué motor popular usa SQL columnar?';
INSERT INTO sq_opcion (sq_id_pregunta, sq_texto, sq_es_correcta)
SELECT sq_id_pregunta,'cURL',0 FROM sq_pregunta WHERE sq_enunciado='¿Qué motor popular usa SQL columnar?';
