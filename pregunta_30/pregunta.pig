/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el codigo en Pig para manipulación de fechas que genere la siguiente
salida.

   1971-07-08,08,8,jue,jueves
   1974-05-23,23,23,jue,jueves
   1973-04-22,22,22,dom,domingo
   1975-01-29,29,29,mie,miercoles
   1974-07-03,03,3,mie,miercoles
   1974-10-18,18,18,vie,viernes
   1970-10-05,05,5,lun,lunes
   1969-02-24,24,24,lun,lunes
   1974-10-17,17,17,jue,jueves
   1975-02-28,28,28,vie,viernes
   1969-12-07,07,7,dom,domingo
   1973-12-24,24,24,lun,lunes
   1970-08-27,27,27,jue,jueves
   1972-12-12,12,12,mar,martes
   1970-07-01,01,1,mie,miercoles
   1974-02-11,11,11,lun,lunes
   1973-04-01,01,1,dom,domingo
   1973-04-29,29,29,dom,domingo

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/

lines = LOAD 'data.csv' USING PigStorage(',') AS (f1:INT, f2:CHARARRAY, f3:CHARARRAY, f4:CHARARRAY, f5:CHARARRAY, f6:INT);

dates = FOREACH lines GENERATE ToDate(f4,'YYYY-MM-dd') AS date;

salida = FOREACH dates GENERATE ToString(date,'YYYY-MM-dd'), ToString(date,'dd'), ToString(date,'d'), ToString(date,'EEE');

salida = FOREACH salida GENERATE $0, $1, $2, REPLACE($3,'Thu', 'jueves');

salida = FOREACH salida GENERATE $0, $1, $2, REPLACE($3,'Sun', 'domingo');

salida = FOREACH salida GENERATE $0, $1, $2, REPLACE($3,'Mon', 'lunes');

salida = FOREACH salida GENERATE $0, $1, $2, REPLACE($3,'Tue', 'martes');

salida = FOREACH salida GENERATE $0, $1, $2, REPLACE($3,'Wed', 'miercoles');

salida = FOREACH salida GENERATE $0, $1, $2, REPLACE($3,'Fri', 'viernes');

salida = FOREACH salida GENERATE $0, $1, $2, SUBSTRING($3,0,3), $3;

STORE salida INTO 'output' USING PigStorage(',');