/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:BAG{t: TUPLE(p:CHARARRAY)}, f3:MAP[]);

cantidades = FOREACH lines GENERATE f1 AS letra, SIZE(f2) AS size_f2, SIZE(f3) AS size_f3;

cantidades_ordenadas = ORDER cantidades BY letra, size_f2, size_f3;

STORE cantidades_ordenadas INTO 'output' USING PigStorage(',');