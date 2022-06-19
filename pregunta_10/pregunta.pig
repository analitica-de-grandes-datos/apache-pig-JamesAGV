/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Genere una relación con el apellido y su longitud. Ordene por longitud y 
por apellido. Obtenga la siguiente salida.

  Hamilton,8
  Garrett,7
  Holcomb,7
  Coffey,6
  Conway,6

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.csv' USING PigStorage(',') AS (f1:INT, f2:CHARARRAY, f3:CHARARRAY, f4:CHARARRAY, f5:CHARARRAY, f6:INT);

apellidos = FOREACH lines GENERATE f3 AS apellido;

apellidos_diff = DISTINCT apellidos;

apellidos = FOREACH apellidos_diff GENERATE apellido AS inicial, SIZE(apellido) AS apellido_size;

apellidos_ordenados = ORDER apellidos BY apellido_size DESC, inicial;

apellidos_ordenados = LIMIT apellidos_ordenados 5;

STORE apellidos_ordenados INTO 'output' USING PigStorage(',');