/* 
Pregunta
===========================================================================

Para el archivo `data.tsv` compute la cantidad de registros por letra.
Almacene los resultados separados por comas. 

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:CHARARRAY, f3:INT);

words = FOREACH lines GENERATE f1 AS word;

grouped = GROUP words BY word;

wordcount = FOREACH grouped GENERATE group, COUNT(words);

STORE wordcount INTO 'output' USING PigStorage(',');
