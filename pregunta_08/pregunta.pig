/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra de la 
columna 2 y clave de al columna 3; esto es, por ejemplo, la cantidad de 
registros en tienen la letra `b` en la columna 2 y la clave `jjj` en la 
columna 3 es:

  ((b,jjj), 216)

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:BAG{t: TUPLE(p:CHARARRAY)}, f3:MAP[]);

cantidades = FOREACH lines GENERATE FLATTEN(f2) AS letra, FLATTEN(f3) AS (clave, valor);

cantidades = FOREACH cantidades GENERATE (letra,clave) AS tupla;

cantidades_group = GROUP cantidades BY tupla;

cantidades = FOREACH cantidades_group GENERATE group, COUNT(cantidades);

STORE cantidades INTO 'output' USING PigStorage(',');
