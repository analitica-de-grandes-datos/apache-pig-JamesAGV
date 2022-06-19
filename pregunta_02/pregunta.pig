/*
Pregunta
===========================================================================

Ordene el archivo `data.tsv`  por letra y valor (3ra columna). Escriba el
resultado separado por comas.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

     >>> Escriba el codigo del mapper a partir de este punto <<<

*/

lines = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:CHARARRAY, f3:INT);

words = FOREACH lines GENERATE f1 AS word, f2, f3;

grouped = GROUP words BY word;

letra_fecha = FOREACH grouped GENERATE words;

letras_fecha = FOREACH letra_fecha GENERATE FLATTEN(words);

--STORE letras_fecha INTO 'output' USING PigStorage(',');

ordered_1 = ORDER letras_fecha BY word, f3;

STORE ordered_1 INTO 'output' USING PigStorage(',');
