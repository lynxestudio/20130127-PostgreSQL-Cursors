# Entendiendo cursors (cursores) en PostgreSQL.

Para el manejo de grandes cantidades de datos tanto en PostgreSQL como en otras bases de datos relacionales existe el concepto de cursors (cursores) los cuales representan un resultset (conjunto de datos) que son asociados a una variable, una variable de tipo cursor. Esta variable representa un apuntador hacia una tabla virtual representada por una consulta y su respectivo comando SELECT asociado.

La diferencia entre un comando SELECT no asociado a un cursor y uno asociado, es que en el primero la consulta regresará todos los registros a la vez y si queremos limitar la cantidad de registros para procesar debemos correr la consulta nuevamente agregando WHERE, BETWEEN o cualquier otra instrucción para filtrar los resultados. En el caso del comando asociado a un cursor este nos permite desplazarnos y limitar la cantidad de registros para procesar dentro del resultset sin necesidad de un nuevo comando SELECT.

Como ejemplo tenemos una tabla Books dentro de una base de datos llamada MyBooks, aqui esta el script para su creación.

CREATE TABLE books
(
  bookid serial NOT NULL,
  title character varying(512),
  publishyear smallint,
  isbn character varying(13),
  created date DEFAULT ('now'::text)::date,
  CONSTRAINT books_pkey PRIMARY KEY (bookid)
)
Para mostrar la diferencia entre una consulta sin cursor y una consulta asociada a un cursor, ejecutamos la siguiente consulta.
SELECT  bookid, title, publishyear, isbn, created FROM Books.
Esta consulta nos devuelve el siguiente resultado.


Ahora mostramos los comandos que pueden utilizarse al asociar una consulta a un cursor. Para el trabajo con cursores es necesario que estos se encuentren dentro del ámbito de una transacción. Empezamos con una transacción.

BEGIN;
Declaramos el cursor como una variable de tipo cursor y le asociamos una consulta SQL.
DECLARE mycursor CURSOR FOR SELECT * FROM Books;
Ahora podemos navegar entre los registros del resultset, con el comando FETCH, de este comando la sintaxis es:
FETCH [FORWARD | BACKWARD |  ALL | NEXT]
A continuación unos ejemplos de su utilización.
Obtenemos un par de registros.
FETCH 2 FROM MyCursor;


Obtenemos los siguientes 4 registros y nos desplazamos:
FETCH 4 FROM MyCursor;


Obtenemos 3 registros hacia atrás a partir del último registro.
FETCH BACKWARD 3 FROM MyCursor;


Avanzamos de nuevo y obtenemos los próximos 6 registros:
FETCH FORWARD 6 FROM MyCursor;


Obtenemos el próximo registro

FETCH NEXT FROM MyCursor;

También podemos avanzar de forma negativa con FORWARD -[n] lo que es equivalente a BACKWARD [n].
FETCH FORWARD -10 FROM MyCursor;

Obtenemos todos los registros del cursor:
FETCH ALL FROM MyCursor;

Por último cerramos el cursor y confirmamos (o abortamos) la transacción.
CLOSE MyCursor;
COMMIT;
