SELECT  bookid, title, publishyear, isbn, created FROM Books;

BEGIN;

DECLARE mycursor CURSOR FOR SELECT * FROM Books;

FETCH 2 FROM MyCursor;

FETCH 4 FROM MyCursor;

FETCH BACKWARD 3 FROM MyCursor;

FETCH FORWARD 6 FROM MyCursor;

FETCH NEXT FROM MyCursor;

FETCH NEXT FROM MyCursor;

FETCH ALL FROM MyCursor;

CLOSE MyCursor;
COMMIT;


