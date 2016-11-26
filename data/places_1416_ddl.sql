/* places_1416_ddl.sql

The places tables refer to either geographic locations, or, occasionally, 
large moveable object like 1000+ dTon ships. 

*/

DROP TABLE if EXISTS places_1416;

CREATE TABLE if NOT EXISTS places_1416(
  id          INTEGER PRIMARY KEY,
  name        varchar[15],
  uxp         varchar[10],
  location    varchar[20],
  type        varchar[10],
  political   varchar[15],
  image       varchar[50],
  url         varchar[50],
  notes       text
);


