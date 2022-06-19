/*
Pregunta
===========================================================================

Para el archivo `data.tsv` Calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:BAG{t: TUPLE(p:CHARARRAY)}, f3:MAP[]);

claves = FOREACH lines GENERATE FLATTEN(f3) AS (clave, valor);

claves = FOREACH claves GENERATE clave AS key;

claves_group = GROUP claves BY key;

claves_count = FOREACH claves_group GENERATE group, COUNT(claves);

STORE claves_count INTO 'output' USING PigStorage(',');