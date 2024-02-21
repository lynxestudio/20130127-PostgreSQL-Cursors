CREATE TABLE books
(
  bookid serial NOT NULL,
  title character varying(512),
  publishyear smallint,
  isbn character varying(13),
  created date DEFAULT ('now'::text)::date,
  CONSTRAINT books_pkey PRIMARY KEY (bookid)
)
