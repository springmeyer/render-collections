/*
http://en.wikipedia.org/wiki/Well-known_text
*/

create table test(gid serial PRIMARY KEY, geom geometry, geog geography);

INSERT INTO test(geom,geog) values (GeomFromEWKT('SRID=4326;POINT(0 0)'),ST_GeographyFromText('SRID=4326;POINT(0 0)'));
INSERT INTO test(geom,geog) values (GeomFromEWKT('SRID=4326;POINT(-2 2)'),ST_GeographyFromText('SRID=4326;POINT(-2 2)'));
INSERT INTO test(geom,geog) values (GeomFromEWKT('SRID=4326;MULTIPOINT(2 1,1 2)'),ST_GeographyFromText('SRID=4326;MULTIPOINT(2 1,1 2)'));
INSERT INTO test(geom,geog) values (GeomFromEWKT('SRID=4326;LINESTRING(0 0,1 1,1 2)'),ST_GeographyFromText('SRID=4326;LINESTRING(0 0,1 1,1 2)'));
INSERT INTO test(geom,geog) values (GeomFromEWKT('SRID=4326;MULTILINESTRING((1 0,0 1,3 2),(3 2,5 4))'),ST_GeographyFromText('SRID=4326;MULTILINESTRING((1 0,0 1,3 2),(3 2,5 4))'));
INSERT INTO test(geom,geog) values (GeomFromEWKT('SRID=4326;POLYGON((0 0,4 0,4 4,0 4,0 0),(1 1, 2 1, 2 2, 1 2,1 1))'),ST_GeographyFromText('SRID=4326;POLYGON((0 0,4 0,4 4,0 4,0 0),(1 1, 2 1, 2 2, 1 2,1 1))'));
INSERT INTO test(geom,geog) values (GeomFromEWKT('SRID=4326;MULTIPOLYGON(((1 1,3 1,3 3,1 3,1 1),(1 1,2 1,2 2,1 2,1 1)), ((-1 -1,-1 -2,-2 -2,-2 -1,-1 -1)))'),ST_GeographyFromText('SRID=4326;MULTIPOLYGON(((1 1,3 1,3 3,1 3,1 1),(1 1,2 1,2 2,1 2,1 1)), ((-1 -1,-1 -2,-2 -2,-2 -1,-1 -1)))'));
INSERT INTO test(geom,geog) values (GeomFromEWKT('SRID=4326;GEOMETRYCOLLECTION(POLYGON((1 1, 2 1, 2 2, 1 2,1 1)),POINT(2 3),LINESTRING(2 3,3 4))'),ST_GeographyFromText('SRID=4326;GEOMETRYCOLLECTION(POLYGON((1 1, 2 1, 2 2, 1 2,1 1)),POINT(2 3),LINESTRING(2 3,3 4))'));