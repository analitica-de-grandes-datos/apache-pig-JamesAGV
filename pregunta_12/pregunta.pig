/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
salida esperada es la siguiente:

  (Hamilton)
  (Holcomb)
  (Garrett)
  (Fry)
  (Kinney)
  (Klein)
  (Diaz)
  (Guy)
  (Estes)
  (Jarvis)
  (Knight)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.csv' USING PigStorage(',') AS (f1:INT, f2:CHARARRAY, f3:CHARARRAY, f4:CHARARRAY, f5:CHARARRAY, f6:INT);

--apellidos = FOREACH lines GENERATE f3 as apellido;

--apellidos = FOREACH lines GENERATE REGEX_EXTRACT(f3,'(H)(.*)',1),REGEX_EXTRACT(f3,'(H)(.*)',2);
--apellidos = FOREACH lines GENERATE REGEX_EXTRACT(f3,'([D-K].*)',1);
apellidos = FOREACH lines GENERATE REGEX_EXTRACT_ALL(f3,'([D-K].*)') AS last_name;

salida = FILTER apellidos BY last_name is not null;

STORE salida INTO 'output' USING PigStorage(',');
--STORE apellidos INTO 'output' USING PigStorage(',');