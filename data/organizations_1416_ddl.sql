/* organiations_1416_ddl.sql

  Just the bare bones.

  id
  name
  notes
*/

DROP TABLE if EXISTS organizations_1416;

CREATE TABLE if NOT EXISTS organizations_1416(
  id    INTEGER PRIMARY KEY,
  name  varchar[20],
  notes text
);

