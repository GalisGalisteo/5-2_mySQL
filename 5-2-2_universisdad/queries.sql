USE universidad;

-- 1.Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.

SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1, apellido2, nombre;

-- 2.Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.

SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = 'alumno' AND telefono IS NULL ORDER BY apellido1, apellido2, nombre;

-- 3.Retorna el llistat dels alumnes que van néixer en 1999.

SELECT apellido1, apellido2, nombre, fecha_nacimiento FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999 ORDER BY apellido1, apellido2, nombre;

-- 4.Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.

SELECT apellido1, apellido2, nombre, nif fecha_nacimiento FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif REGEXP 'k$' ORDER BY apellido1, apellido2, nombre;


-- 5.Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.

SELECT nombre FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- 6 Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.

SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departamento FROM persona p JOIN profesor pr ON p.id = pr.id_profesor JOIN departamento d ON d.id = pr.id_departamento WHERE p.tipo = 'profesor' ORDER BY p.apellido1, p.apellido2, p.nombre;
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departamento FROM persona p, profesor pr, departamento d WHERE p.id = pr.id_profesor AND d.id = pr.id_departamento AND p.tipo = 'profesor' ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.

SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin, p.nif FROM asignatura a JOIN alumno_se_matricula_asignatura asma ON a.id = asma.id_asignatura JOIN curso_escolar ce ON ce.id = asma.id_curso_escolar JOIN persona p ON p.id = asma.id_alumno WHERE p.nif = '26902806M';
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin, p.nif FROM asignatura a, alumno_se_matricula_asignatura asma, curso_escolar ce, persona p WHERE a.id = asma.id_asignatura AND ce.id = asma.id_curso_escolar AND p.id = asma.id_alumno AND p.nif = '26902806M';


-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).

SELECT d.nombre FROM asignatura a JOIN grado g ON g.id = a.id_grado JOIN profesor p USING (id_profesor) JOIN departamento d ON p.id_departamento = d.id WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)' AND a.id_profesor IS NOT NULL GROUP BY d.nombre;

-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.

SELECT p.apellido1, p.apellido2, p.nombre FROM alumno_se_matricula_asignatura asma JOIN persona p ON asma.id_alumno = p.id JOIN curso_escolar ce ON asma.id_curso_escolar = ce.id WHERE anyo_inicio = 2018 AND anyo_fin = 2019 GROUP BY p.apellido1, p.apellido2, p.nombre ORDER BY p.apellido1, p.apellido2, p.nombre;


-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.

SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departamento FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN departamento d ON d.id = pr.id_departamento WHERE p.tipo = 'profesor' ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 2. Retorna un llistat amb els professors/es que no estan associats a un departament.

SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS departamento FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN departamento d ON d.id = pr.id_departamento WHERE p.tipo = 'profesor' AND d.nombre IS NULL ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.

SELECT d.nombre FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento WHERE pr.id_profesor IS NULL;

-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.

SELECT p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN asignatura a ON p.id = a.id_profesor WHERE p.tipo = 'profesor' AND a.id_profesor IS NULL ORDER BY apellido1, apellido2, nombre;

-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.

SELECT nombre FROM asignatura WHERE id_profesor IS NULL;

-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.

SELECT d.nombre, a.nombre AS asignaturas FROM profesor pr LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor JOIN departamento d ON id_departamento = d.id WHERE a.nombre IS NULL GROUP BY d.nombre, a.nombre;

-- RESUMEN

-- 1. Retorna el nombre total d'alumnes que hi ha.

SELECT COUNT(tipo) AS total_alumnos FROM persona WHERE tipo = 'alumno';

-- 2. Calcula quants alumnes van néixer en 1999.

SELECT COUNT(fecha_nacimiento) AS alumnos_year_1999 FROM persona WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- 3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.

SELECT d.nombre AS departamento, COUNT(p.id) AS total_profesores FROM persona p JOIN profesor pr ON p.id = pr.id_profesor JOIN departamento d ON d.id = pr.id_departamento GROUP BY d.nombre;

-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.

SELECT d.nombre AS departamento, COUNT(p.id) AS total_profesores FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento LEFT JOIN persona p ON pr.id_profesor = p.id GROUP BY d.nombre;

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.

SELECT g.nombre AS grados, COUNT(a.nombre) AS total_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre ORDER BY total_asignaturas DESC;

-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.

SELECT g.nombre AS grados, COUNT(a.nombre) AS total_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre HAVING COUNT(a.nombre) > 40 ORDER BY total_asignaturas DESC;

-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.

SELECT g.nombre AS grados, a.tipo AS tipo_asignatura, COUNT(a.creditos) AS total_creditos FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre, a.tipo;

-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.

SELECT ce.anyo_inicio, COUNT(asma.id_alumno) AS total_alumnos_matriculados FROM curso_escolar ce LEFT JOIN alumno_se_matricula_asignatura asma ON ce.id = asma.id_curso_escolar GROUP BY ce.anyo_inicio;
-- 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.

SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) as total_asignaturas FROM persona p LEFT JOIN asignatura a ON p.id = a.id_profesor GROUP BY p.id, p.nombre, p.apellido1, p.apellido2;

-- 10. Retorna totes les dades de l'alumne/a més jove.

SELECT * FROM persona WHERE tipo = 'alumno' ORDER BY fecha_nacimiento LIMIT 1;

-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.

SELECT p.id, p.nombre, p.apellido1, p.apellido2, pr.id_departamento, a.nombre AS asignaturas FROM persona p LEFT JOIN asignatura a ON p.id = a.id_profesor JOIN profesor pr ON p.id = pr.id_profesor WHERE a.nombre IS NULL;
