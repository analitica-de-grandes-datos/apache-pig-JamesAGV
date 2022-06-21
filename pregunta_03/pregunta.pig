/*
Pregunta
===========================================================================

Obtenga los cinco (5) valores más pequeños de la 3ra columna.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:CHARARRAY, f3:INT);

numeros = FOREACH lines GENERATE f3;

numeros_ordenados = ORDER numeros BY f3;

numeros = LIMIT numeros_ordenados 5;

STORE numeros INTO 'output' USING PigStorage(',');