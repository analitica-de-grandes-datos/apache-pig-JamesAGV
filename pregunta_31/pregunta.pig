/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.csv' USING PigStorage(',') AS (f1:INT, f2:CHARARRAY, f3:CHARARRAY, f4:CHARARRAY, f5:CHARARRAY, f6:INT);

dates = FOREACH lines GENERATE ToDate(f4,'YYYY-MM-dd') AS date;

years = FOREACH dates GENERATE ToString(date, 'YYYY');

years = GROUP years BY $0;

years = FOREACH years GENERATE $0, COUNT(years);

STORE years INTO 'output' USING PigStorage(',');