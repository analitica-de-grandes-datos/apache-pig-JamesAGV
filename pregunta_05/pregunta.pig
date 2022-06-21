/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.tsv' AS (f1:CHARARRAY, f2:BAG{t: TUPLE(p:CHARARRAY)}, f3:MAP[]);

minusculas = FOREACH lines GENERATE FLATTEN(f2)  AS letras;

minusculas_group = GROUP minusculas BY letras;

minusculas_conteo = FOREACH minusculas_group GENERATE group, COUNT(minusculas);

STORE minusculas_conteo INTO 'output' USING PigStorage(',');